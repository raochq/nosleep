unit module;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Menus, ExtCtrls,Forms;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    MenuItem1: TMenuItem;
    PopupMenu1: TPopupMenu;
    TrayIcon1: TTrayIcon;
    procedure DataModuleCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
  private

  public

  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

{ TDataModule1 }

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  //TrayIcon1.Show();
end;

procedure TDataModule1.MenuItem1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TDataModule1.TrayIcon1Click(Sender: TObject);
begin
  PopupMenu1.AutoPopup:=true;
end;


end.

