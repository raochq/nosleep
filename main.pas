unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,Windows;

type
    EXECUTION_STATE = DWORD;

  { TForm1 }

  TForm1 = class(TForm)
    MenuItem1: TMenuItem;
    PopupMenu1: TPopupMenu;
    TrayIcon1: TTrayIcon;
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
  private

  public

  end;

const
  ES_SYSTEM_REQUIRED = $00000001;
  ES_DISPLAY_REQUIRED = $00000002;
  ES_USER_PRESENT = $00000004;
  ES_AWAYMODE_REQUIRED = $00000040;
  ES_CONTINUOUS = $80000000;

function SetThreadExecutionState(esFlags: EXECUTION_STATE): EXECUTION_STATE;
  stdcall; external 'kernel32.dll' name 'SetThreadExecutionState';
var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
 
procedure BlockSleep(NoSleep:boolean=true);
begin
  if NoSleep then
  begin
    // DisableSCR
    SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, 0, nil, SPIF_SENDWININICHANGE);
    // try this for vista, it will fail on XP
    //SetThreadExecutionState(ES_CONTINUOUS or ES_SYSTEM_REQUIRED or ES_DISPLAY_REQUIRED);
    if (SetThreadExecutionState(ES_CONTINUOUS or ES_SYSTEM_REQUIRED or ES_DISPLAY_REQUIRED) = 0)
    then    // try XP variant as well just to make sure
         SetThreadExecutionState(ES_CONTINUOUS or ES_SYSTEM_REQUIRED);
  end
  else
  begin
    // EnableSCR
    SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, 1, nil, SPIF_SENDWININICHANGE);
    // set state back to normal
    SetThreadExecutionState(ES_CONTINUOUS);
  end;
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
  TrayIcon1.Icon := Application.Icon;
  application.ShowMainForm:=false;
  BlockSleep(true);
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  BlockSleep(false);
  application.Terminate;
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
  PopupMenu1.PopUp;
end;

end.

