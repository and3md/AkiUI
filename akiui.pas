unit AkiUI;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Math, Generics.Collections,
  Gtk3, Gdk3, GdkPixbuf2, GObject2, Gio2, Glib2;

const
  DefaultSpacing = 2;

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

    FOnDestroySignal: TASignal;
    procedure InitBackend;

    procedure DestroySignal;
  public
    constructor Create(Application:TAApplication; const ATitle: String; const ADefaultWidth,
      ADefaultHeight: Integer);
    destructor Destroy; override;

    procedure AddWidget(Widget: TAWidget);
    procedure RemoveWidget(Widget: TAWidget);

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
    procedure DestroySignal;
  protected
    FGtkWidget: PGtkWidget;
    FParent: TAObject;

    procedure InitBackend; virtual;
  public
    constructor Create;
    destructor Destroy; override;


    property InitializedBackend: Boolean read FInitializedBackend;
    property Parent: TAObject read FParent;

    property OnDestroy: TASignal read FOnDestroySignal;
  end;

  TAOrientation = (
    oHorizontal = 0,
    oVertical = 1
  );

  { Box item with placing data }
  TABoxItem = class
    Widget: TAWidget;
    Expand: Boolean;
    Fill: Boolean;
    Padding: Integer;

    { Parameters from https://docs.gtk.org/gtk3/method.Box.pack_start.html }
    constructor Create(const AWidget: TAWidget; const AExpand, AFill: Boolean;
      const APadding: Integer);
  end;

  TABoxItemList = specialize TList <TABoxItem>;

  TABox = class (TAWidget)
  strict private
    FBoxItemList: TABoxItemList;
    FOrientation: TAOrientation;
    FSpacing: Integer;
  protected
    procedure InitBackend; override;
    procedure InitItemInBackend(const ABoxItem: TABoxItem);
  public
    constructor Create(const AOrientation: TAOrientation);
    destructor Destroy; override;

    { Parameters from https://docs.gtk.org/gtk3/method.Box.pack_start.html }
    procedure AddWidget(const AWidget: TAWidget; const AExpand, AFill: Boolean;
      const APadding: Integer);

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

var
  Application: TAApplication;


implementation

{ TABoxItem }

constructor TABoxItem.Create(const AWidget: TAWidget; const AExpand,
  AFill: Boolean; const APadding: Integer);
begin
  Widget := AWidget;
  Expand := AExpand;
  Fill := AFill;
  Padding := APadding;
end;

{ TABox }

procedure TABox.InitBackend;
var
  I: Integer;
begin
  if InitializedBackend then
    Exit;

  FGtkWidget := gtk_box_new(Integer(FOrientation), FSpacing);

  for I := 0 to FBoxItemList.Count - 1 do
    InitItemInBackend(FBoxItemList[I]);

  inherited InitBackend;
end;

procedure TABox.InitItemInBackend(const ABoxItem: TABoxItem);
begin
  ABoxItem.Widget.InitBackend;
  gtk_box_pack_start(PGtkBox(FGtkWidget),
    ABoxItem.Widget.FGtkWidget,
    GBoolean(ABoxItem.Expand),
    GBoolean(ABoxItem.Fill),
    ABoxItem.Padding
  );
end;

constructor TABox.Create(const AOrientation: TAOrientation);
begin
  inherited Create;
  FBoxItemList := TABoxItemList.Create;
  FOrientation := AOrientation;
  FSpacing := DefaultSpacing;
end;

destructor TABox.Destroy;
var
  I: Integer;
begin
  for I := 0 to FBoxItemList.Count -1 do
    FBoxItemList[I].Free;
  FreeAndNil(FBoxItemList);
  inherited Destroy;
end;

procedure TABox.AddWidget(const AWidget: TAWidget; const AExpand, AFill: Boolean;
      const APadding: Integer);
var
  BoxItem: TABoxItem;
begin
  BoxItem := TABoxItem.Create(AWidget, AExpand, AFill, APadding);
  FBoxItemList.Add(BoxItem);
  if InitializedBackend then
    InitItemInBackend(BoxItem);
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

{ TAWidget }

procedure TAWidget.DestroySignal;
var
  I: Integer;
begin
  for I := 0 to FOnDestroySignal.Count -1 do
  begin
    FOnDestroySignal.GetCallbackByIndex(i)(Self);
  end;
end;

procedure destroy_TAWidget(GtkWidget: PGtkWidget; UserData: GPointer); cdecl;
var
  Widget: TAWidget;
  Window: TAWindow;
begin
  Widget := TAWidget(UserData);
  Writeln('destroy_TAWidget ' + Widget.ClassName);
  Widget.DestroySignal;

  if Widget.Parent is TAWindow then
  begin
    Window := TAWindow(Widget.Parent);
    Window.RemoveWidget(Widget);
  end;

  Widget.FGtkWidget := nil; // do not try destroy it in destructor
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
  if InitializedBackend then
  begin
    g_signal_handler_disconnect(FGTKWidget, FDestroySignalID);
    gtk_widget_destroy(FGTKWidget);
    Writeln('Widget destroyed 2.');
    FInitializedBackend := false;
  end;
  FreeAndNil(FOnDestroySignal);
  inherited Destroy;
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
  FOnActivateSignal := TASignal.Create;
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

  FreeAndNil(Window);
  Writeln('Window destroyed.');
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
      gtk_container_add(PGtkContainer(FGtkWindow), FWidgetList[I].FGtkWidget);
    end;

    FState := wsInitializedBackend;
  end;
end;

procedure TAWindow.DestroySignal;
var
  I: Integer;
begin
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
  FOnDestroySignal := TASignal.Create;
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

procedure TAWindow.AddWidget(Widget: TAWidget);
begin
  FWidgetList.Add(Widget);
  Widget.FParent := Self;
  if FState = wsInitializedBackend then
  begin
    Widget.InitBackend;
    gtk_container_add(PGtkContainer(FGtkWindow), Widget.FGtkWidget);
  end;


end;

procedure TAWindow.RemoveWidget(Widget: TAWidget);
begin
  Assert(Widget.FParent = Self, 'Trying remove widget with other Parent.');

  FWidgetList.Remove(Widget);
  Widget.FParent := nil;
end;


end.

