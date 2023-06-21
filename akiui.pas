unit AkiUI;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Math, Generics.Collections,
  Gtk4, Gdk4, GdkPixbuf2, GObject2, Gio2, Glib2;

const
  DefaultSpacing = 2;

type

  TAWindow = class;
  TAWidget = class;

  TAWindowList = specialize TList<TAWindow>;
  TAWidgetList = specialize TList<TAWidget>;

  { Aki UI object with some user data fields }
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
  TSignalCallback = procedure (const Sender: TAObject) of object;


  { Class to add multiple callbacks to one event }
  TASignal = class
  strict private
    { Maybe here should be also list for procedure is nested and simple
      procedures, to cover all possibilities:
      https://www.freepascal.org/docs-html/ref/refse17.html }
    FEventCallbackList: TProcedureOfObjectList;

  public
    function Count: Integer;
    function GetCallbackByIndex(Index: Integer): TSignalCallback;
    procedure AddCallback(SignalCallback: TSignalCallback);

    { Call all calbacks in this TASignal }
    procedure CallAllCallbacks(const Sender: TAObject);

    destructor Destroy; override;
  end;

  TAApplication = class (TAObject)
  private
    FGtkApp: PGtkApplication;
    FWindows: TAWindowList;
    FMainWindow: TAWindow;

    { There is always a class and a corresponding function. }
    FOnActivateSignal: TASignal;
    procedure ActivateSignal;
  public
    constructor Create(const AppID: String);
    destructor Destroy; override;

    function Run: Integer;

    { Window that will be created in ActivateSignal }
    property MainWindow: TAWindow read FMainWindow write FMainWindow;

    { signals }
    property OnActivate: TASignal read FOnActivateSignal;

  end;

  TWindowState = (
    wsNotInitialized,
    wsInitializedBackend
  );

  { TAWindow }

  TAWindow = class (TAObject)
  strict private
    FApplication: TAApplication;
    FState: TWindowState;
    FTitle: String;
    FWidth: Integer;
    FHeight: Integer;
    FChildWidget: TAWidget;
  private
    FGtkWindow: PGtkWidget;

    FOnDestroySignal: TASignal;

    { Creates gtk objects and sets its properties }
    procedure InitBackend;

    procedure DestroySignal;
  public
    constructor Create(Application:TAApplication; const ATitle: String; const ADefaultWidth,
      ADefaultHeight: Integer);

    { TODO: Destroying window from code do not remove gtk4 objects }
    destructor Destroy; override;

    procedure SetChild(Widget: TAWidget);

    procedure Show;

    property Title: String read FTitle;

    property Application: TAApplication read FApplication;
    property OnDestroy: TASignal read FOnDestroySignal;
  end;

  { Base class for all widgets }
  TAWidget = class (TAObject)
  strict private
    { Can be set only on InitBackend in this class }
    FInitializedBackend: Boolean;
    FDestroySignalID: gulong;
  private
    FOnDestroySignal: TASignal;

    { Signal sent when widget will be destroyed }
    procedure DestroySignal;
  protected
    FGtkWidget: PGtkWidget;
    FParent: TAObject;

    procedure InitBackend; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    procedure BeforeDestruction; override;

    property InitializedBackend: Boolean read FInitializedBackend;
    property Parent: TAObject read FParent;

    property OnDestroy: TASignal read FOnDestroySignal;
  end;

  TAOrientation = (
    oHorizontal = 0,
    oVertical = 1
  );

  TABox = class (TAWidget)
  strict private
    FWidgetList: TAWidgetList;
    FOrientation: TAOrientation;
    FSpacing: Integer;
  protected
    procedure InitBackend; override;
    procedure InitItemInBackend(const AWidget: TAWidget);
  public
    constructor Create(const AOrientation: TAOrientation);
    destructor Destroy; override;

    procedure BeforeDestruction; override;

    { Parameters from  }
    procedure AddWidget(const AWidget: TAWidget);

    { Removes widget but not destroys it }
    procedure RemoveWidget(const AWidget: TAWidget);

  end;

  { Simple button class }
  TAButton = class (TAWidget)
  strict private
    FTitle: String;

  private
    FOnClickedSignal: TASignal;
    procedure ClickedSignal;
  protected
    procedure InitBackend; override;
  public
    constructor Create(const ATitle: String);
    destructor Destroy; override;

    property OnClicked: TASignal read FOnClickedSignal;
  end;


  TALabel = class (TAWidget)
  strict private
    FTitle: String;

  protected
    procedure InitBackend; override;

  public
    constructor Create(const ATitle: String);

  end;

var
  Application: TAApplication;


implementation

{ TALabel }

procedure TALabel.InitBackend;
begin
  if InitializedBackend then
    Exit;

  FGtkWidget := gtk_label_new(Pgchar(FTitle));
  { Should be always last in InitBackend }
  inherited InitBackend;
end;

constructor TALabel.Create(const ATitle: String);
begin
  inherited Create;
  FTitle := ATitle;
end;

{ TABox }

procedure TABox.InitBackend;
var
  I: Integer;
begin
  if InitializedBackend then
    Exit;

  FGtkWidget := gtk_box_new(Integer(FOrientation), FSpacing);

  for I := 0 to FWidgetList.Count - 1 do
    InitItemInBackend(FWidgetList[I]);

  inherited InitBackend;
end;

procedure TABox.InitItemInBackend(const AWidget: TAWidget);
begin
  AWidget.InitBackend;

  gtk_box_append(PGtkBox(FGtkWidget), AWidget.FGtkWidget);
end;

constructor TABox.Create(const AOrientation: TAOrientation);
begin
  inherited Create;
  FWidgetList := TAWidgetList.Create;
  FOrientation := AOrientation;
  FSpacing := DefaultSpacing;
end;

destructor TABox.Destroy;
begin
  { Items are removed in before destruction. }
  FreeAndNil(FWidgetList);
  inherited Destroy;
end;

procedure TABox.BeforeDestruction;
var
  I: Integer;
begin
  inherited BeforeDestruction;

  for I := 0 to FWidgetList.Count -1 do
  begin
    FWidgetList[I].Free;
  end;
end;

procedure TABox.AddWidget(const AWidget: TAWidget);
begin
  AWidget.FParent := Self;
  FWidgetList.Add(AWidget);
  if InitializedBackend then
    InitItemInBackend(AWidget);
end;

procedure TABox.RemoveWidget(const AWidget: TAWidget);
var
  I: Integer;
begin
  for I := FWidgetList.Count - 1 downto 0 do
  begin
    if FWidgetList[I] = AWidget then
    begin
      FWidgetList.Delete(I);
      { When it is called from destroy signal we do not need to remove it from
        box because it is removed at this stage }
      if AWidget.FGtkWidget <> nil then
         gtk_box_remove(PGtkBox(FGtkWidget), AWidget.FGtkWidget);

      { We support only one time widget adding. }
      break;
    end;
  end;
end;


{ TAButton }

procedure clicked_TAButton(Button: PGtkButton; UserData: GPointer); cdecl;
var
  AButton: TAButton;
begin
  AButton := TAButton(UserData);
  AButton.ClickedSignal;
end;

procedure TAButton.ClickedSignal;
var
  I: Integer;
begin
  for I := 0 to FOnClickedSignal.Count -1 do
  begin
    FOnClickedSignal.GetCallbackByIndex(i)(Self);
  end;
end;

procedure TAButton.InitBackend;
begin
  if InitializedBackend then
    Exit;

  FGtkWidget := gtk_button_new_with_label(Pgchar(FTitle));
  g_signal_connect_data(FGtkWidget, 'clicked', TGCallback(@clicked_TAButton), Self, nil, 0);

  { Should be always last in InitBackend }
  inherited InitBackend;
end;

constructor TAButton.Create(const ATitle: String);
begin
  inherited Create;
  FTitle := ATitle;
  FOnClickedSignal := TASignal.Create;
end;

destructor TAButton.Destroy;
begin
  FreeAndNil(FOnClickedSignal);
  inherited Destroy;
end;

{ TAWidget -------------------------------------------------------------------- }

procedure TAWidget.DestroySignal;
begin
  FOnDestroySignal.CallAllCallbacks(Self);
end;

procedure destroy_TAWidget(GtkWidget: PGtkWidget; UserData: GPointer); cdecl;
var
  Widget: TAWidget;
  Window: TAWindow;
begin
  Widget := TAWidget(UserData);
  Writeln('destroy_TAWidget ' + Widget.ClassName);
  { TODO: check should DestroySignal be called here or only in BeforeDestruction }
  Writeln('Call Destroy signal at destroy_TAWidget()');
  Widget.DestroySignal;

  Widget.FGtkWidget := nil; // do not try destroy it in destructor
  { At this stage widget is not in box or window }

  if Widget.Parent is TAWindow then
  begin
    Window := TAWindow(Widget.Parent);
    Window.SetChild(nil);
  end;

  if Widget.Parent is TABox then
  begin
    TABox(Widget.Parent).RemoveWidget(Widget);
  end;


  FreeAndNil(Widget);

  Writeln('Widget destroyed.');
end;

procedure TAWidget.InitBackend;
begin
  if FInitializedBackend then
    Exit;

  if FGtkWidget <> nil then
  begin
    FDestroySignalID := g_signal_connect_data(FGtkWidget, 'destroy', TGCallback(@destroy_TAWidget), Self, nil, 0);
    //g_signal_handler_disconnect(FGTKWidget, FDestroySignalID);
    FInitializedBackend := true;
  end else
    Writeln('Widget not initialized correctly. Maybe missed inherited that should be on end.');
end;

constructor TAWidget.Create;
begin
  inherited Create;
  FOnDestroySignal := TASignal.Create;
end;

destructor TAWidget.Destroy;
begin
  Writeln('Destroy ' + ClassName);

  { When we are here from widget destroy signal we do not need to destroy it }
  if FGtkWidget = nil then
    FInitializedBackend := false;

  if InitializedBackend then
  begin
    g_signal_handler_disconnect(FGTKWidget, FDestroySignalID);
    g_object_unref(FGTKWidget);
    //gtk_widget_destroy(FGTKWidget);
    Writeln('Widget destroyed 2.');
  end;

  FreeAndNil(FOnDestroySignal);
  inherited Destroy;
end;

procedure TAWidget.BeforeDestruction;
begin
  inherited BeforeDestruction;

  Writeln('Call DestroySignal form TAWidget.BeforeDestruction().');
  DestroySignal;
end;

{ TASignal }

function TASignal.Count: Integer;
begin
  if FEventCallbackList = nil then
    Exit(0);
  Result := FEventCallbackList.Count;
end;

function TASignal.GetCallbackByIndex(Index: Integer): TSignalCallback;
begin
  Result := TSignalCallback(FEventCallbackList[Index]);
end;

procedure TASignal.AddCallback(SignalCallback: TSignalCallback);
begin
  if FEventCallbackList = nil then
    FEventCallbackList := TProcedureOfObjectList.Create;
  FEventCallbackList.Add(TProcedureOfObject(SignalCallback));
end;

procedure TASignal.CallAllCallbacks(const Sender: TAObject);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    GetCallbackByIndex(I)(Sender);
end;

destructor TASignal.Destroy;
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
    //gtk_widget_show_all(FMainWindow.FGtkWindow);
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
  FOnActivateSignal := TASignal.Create;
end;

destructor TAApplication.Destroy;
begin
  Writeln('FreeAndNil(FWindows) - START');
  { All windows are destroyed in destroy_TAWindow() }
  FreeAndNil(FWindows);
  Writeln('FreeAndNil(FWindows) - STOP');
  FreeAndNil(FOnActivateSignal);
  g_object_unref(FGtkApp);
  Writeln('TAApplication.Destroy');
  inherited;
end;

{ Function for support apliaction activation }
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

{ When GTK Window is destroyed destroy our TAWindow. }
procedure destroy_TAWindow(GtkApp: PGtkWidget; UserData: GPointer); cdecl;
var
  Window: TAWindow;
begin
  Window := TAWindow(UserData);
  Window.DestroySignal;

  Window.Application.FWindows.Remove(Window);
  if Window.Application.MainWindow = Window then
    Window.Application.MainWindow := nil;

  Writeln('Window ' + Window.Title + ' destroy - START');
  FreeAndNil(Window);
  Writeln('Window destroy.');
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

    if FChildWidget <> nil then
    begin
      FChildWidget.InitBackend;

      gtk_window_set_child(PGtkWindow(FGtkWindow), FChildWidget.FGtkWidget);
    end;
    { add children widgets }
{    for I := 0 to FWidgetList.Count -1 do
    begin
      FWidgetList[I].InitBackend;
      //gtk_container_add(PGtkContainer(FGtkWindow), FWidgetList[I].FGtkWidget);
    end;}
    gtk_widget_show(FGtkWindow);

    FState := wsInitializedBackend;
  end;
end;

procedure TAWindow.DestroySignal;
begin
  FOnDestroySignal.CallAllCallbacks(Self);
end;

constructor TAWindow.Create(Application:TAApplication; const ATitle: String; const ADefaultWidth,
  ADefaultHeight: Integer);
begin
  FTitle := ATitle;
  FWidth := ADefaultWidth;
  FHeight := ADefaultHeight;
  FOnDestroySignal := TASignal.Create;
  FApplication := Application;
  FApplication.FWindows.Add(Self);
end;

destructor TAWindow.Destroy;
begin
  if FChildWidget <> nil then
  begin
    Writeln('TAWindow: Destroy child widget in TAWindow.Destroy');
    FreeAndNil(FChildWidget);
  end;

  FreeAndNil(FOnDestroySignal);
  inherited Destroy;
end;

procedure TAWindow.SetChild(Widget: TAWidget);
begin
  if (FChildWidget <> nil) and (Widget <> nil) then
  begin
    gtk_window_set_child(PGtkWindow(FGtkWindow), nil);
    FreeAndNil(FChildWidget);
  end;
  FChildWidget := Widget;
  if FChildWidget = nil then
     Exit;
  FChildWidget.FParent := Self;
  if FState = wsInitializedBackend then
  begin
    FChildWidget.InitBackend;
    gtk_window_set_child(PGtkWindow(FGtkWindow), FChildWidget.FGtkWidget);
  end;
end;

procedure TAWindow.Show;
begin
  if FState = wsInitializedBackend then
     gtk_widget_show(FGtkWindow);
end;


end.

