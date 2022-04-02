unit AkiUI;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Math, Generics.Collections,
  Gtk3, Gdk3, GdkPixbuf2, GObject2, Gio2, Glib2;

type

  TAWindow = class;
  TAWidget = class;

  TAWindowList = specialize TList<TAWindow>;
  TAWidgetList = specialize TList<TAWidget>;

  TAObject = class
  strict protected
    FData: Pointer;
    FDataInt: Integer;
    FDataString: String;
    FDataObject: TObject;

  public
    property Data: Pointer read FData write FData;
    property DataInt: Integer read FDataInt write FDataInt;
    property DataString: String read FDataString write FDataString;
    property DataObject: TObject read FDataObject write FDataObject;
  end;


  TProcedureOfObject = procedure of object;
  TProcedureOfObjectList = specialize TList <TProcedureOfObject>;
  TSignalCallback = procedure (Sender: TAObject) of object;


  TSignal = class
  strict private
    { być moze dodać też listy of procedure is nested
      https://www.freepascal.org/docs-html/ref/refse17.html
    }
    FEventCallbackList: TProcedureOfObjectList;

  public
    function Count: Integer;
    function GetCallbackByIndex(Index: Integer): TSignalCallback;
    procedure AddCallback(SignalCallback: TSignalCallback);

    constructor Create;
    destructor Destroy; override;
  end;

  TAApplication = class (TAObject)
  private
    FGtkApp: PGtkApplication;
    FWindows: TAWindowList;
    FMainWindow: TAWindow;

    { Zawsze jest klasa TSignal i odpowiadająca funkcja }
    FOnActivateSignal: TSignal;
    procedure ActivateSignal;
  public
    constructor Create(const AppID: String);
    destructor Destroy; override;

    function Run: Integer;

    { Window that will be created in ActivateSignal }
    property MainWindow: TAWindow read FMainWindow write FMainWindow;

    // signals
    property OnActivate: TSignal read FOnActivateSignal;

  end;

  TWindowState = (
    wsNotInitialized,
    wsInitializedBackend
  );

  TAWindow = class (TAObject)
  strict private
    FApplication: TAApplication;
    FState: TWindowState;
    FTitle: String;
    FWidth: Integer;
    FHeight: Integer;
    FWidgetList: TAWidgetList;
  private
    FGtkWindow: PGtkWidget;

    FOnDestroySignal: TSignal;
    procedure InitBackend;

    procedure DestroySignal;
  public
    constructor Create(Application:TAApplication; const ATitle: String; const ADefaultWidth,
      ADefaultHeight: Integer);
    destructor Destroy; override;

    procedure Add(Widget: TAWidget);

    property Application: TAApplication read FApplication;
  end;

  TAWidget = class (TAObject)
  protected
    FGtkWidget: PGtkWidget;
    FParent: TAObject;

    procedure InitBackend; virtual;
  public
  end;

var
  Application: TAApplication;


implementation

{ TAWidget }

procedure TAWidget.InitBackend;
begin

end;

{ TSignal }

function TSignal.Count: Integer;
begin
  if FEventCallbackList = nil then
    Exit(0);
  Result := FEventCallbackList.Count;
end;

function TSignal.GetCallbackByIndex(Index: Integer): TSignalCallback;
begin
  Result := TSignalCallback(FEventCallbackList[Index]);
end;

procedure TSignal.AddCallback(SignalCallback: TSignalCallback);
begin
  if FEventCallbackList = nil then
    FEventCallbackList := TProcedureOfObjectList.Create;
  FEventCallbackList.Add(TProcedureOfObject(SignalCallback));
end;

constructor TSignal.Create;
begin

end;

destructor TSignal.Destroy;
begin
  FreeAndNil(FEventCallbackList);
  inherited Destroy;
end;

{ TAApplication --------------------------------------------------------------- }

procedure TAApplication.ActivateSignal;
var
  I: Integer;
begin
  { InitBackend and show main window }
  if FMainWindow <> nil then
  begin
    FMainWindow.InitBackend;
    gtk_widget_show_all(FMainWindow.FGtkWindow);
  end;

  { Other functions from signals }
  for I := 0 to FOnActivateSignal.Count -1 do
  begin
    FOnActivateSignal.GetCallbackByIndex(i)(Self);
  end;
end;

constructor TAApplication.Create(const AppID: String);
begin
  SetExceptionMask([exDenormalized, exInvalidOp, exOverflow,
    exPrecision, exUnderflow, exZeroDivide]);
  FGtkApp := gtk_application_new(Pgchar(AppID), G_APPLICATION_FLAGS_NONE);
  FWindows := TAWindowList.Create;
  FOnActivateSignal := TSignal.Create;
end;

destructor TAApplication.Destroy;
begin
  FreeAndNil(FWindows);
  FreeAndNil(FOnActivateSignal);
  g_object_unref(FGtkApp);
  inherited;
end;

{ Funkcja obsługi sygnału aktywacji aplikacji. }
procedure activate_TAApplication(GtkApp: PGtkApplication; UserData: GPointer); cdecl;
var
  App: TAApplication;
begin
  App := TAApplication(UserData);
  App.ActivateSignal;
end;

function TAApplication.Run: Integer;
begin
  g_signal_connect_data(FGtkApp, 'activate', TGCallback(@activate_TAApplication), Self, nil, 0);

  Result := g_application_run(FGtkApp, argc, argv);
end;


{ TAWindow ------------------------------------------------------------------- }

{ Funkcja obsługi sygnału aktywacji aplikacji. }
procedure destroy_TAWindow(GtkApp: PGtkWidget; UserData: GPointer); cdecl;
var
  Window: TAWindow;
begin
  Window := TAWindow(UserData);
  Window.DestroySignal;

  Window.Application.FWindows.Remove(Window);
  if Window.Application.MainWindow = Window then
    Window.Application.MainWindow := nil;

  FreeAndNil(Window);
  Writeln('zniszczno');
end;

procedure TAWindow.InitBackend;
var
  I: Integer;
begin
  if FState = wsNotInitialized then
  begin
    FGtkWindow := gtk_application_window_new(Application.FGtkApp);
    gtk_window_set_title(PGtkWindow(FGtkWindow), Pgchar(FTitle));
    gtk_window_set_default_size(PGtkWindow(FGtkWindow), FWidth, FHeight);
    g_signal_connect_data(FGtkWindow, 'destroy', TGCallback(@destroy_TAWindow), Self, nil, 0);

    { add children widgets }

    for I := 0 to FWidgetList.Count -1 do
    begin
      FWidgetList[I].InitBackend;
    end;

    FState := wsInitializedBackend;
  end;
end;

procedure TAWindow.DestroySignal;
var
  I: Integer;
begin
  { Other functions from signals }
  for I := 0 to FOnDestroySignal.Count -1 do
  begin
    FOnDestroySignal.GetCallbackByIndex(i)(Self);
  end;
end;

constructor TAWindow.Create(Application:TAApplication; const ATitle: String; const ADefaultWidth,
  ADefaultHeight: Integer);
begin
  FTitle := ATitle;
  FWidth := ADefaultWidth;
  FHeight := ADefaultHeight;
  FOnDestroySignal := TSignal.Create;
  FApplication := Application;
  FApplication.FWindows.Add(Self);
  FWidgetList := TAWidgetList.Create;
end;

destructor TAWindow.Destroy;
var
  I: Integer;
begin
  for I := 0 to FWidgetList.Count - 1 do
    FWidgetList[i].Free;
  FreeAndNil(FWidgetList);

  FreeAndNil(FOnDestroySignal);
  inherited Destroy;
end;

procedure TAWindow.Add(Widget: TAWidget);
begin
  FWidgetList.Add(Widget);
  Widget.FParent := Self;
  if FState = wsInitializedBackend then
    Widget.InitBackend;
end;


end.

