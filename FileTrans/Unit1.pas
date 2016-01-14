unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellApi, ComCtrls, Buttons;

type
  TForm1 = class(TForm)
    Button1: TButton;
    BtnEmission: TButton;
    Button3: TButton;
    BtnReception: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    StatusBar1: TStatusBar;
    OD: TOpenDialog;
    SD: TSaveDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    CB_Com1: TComboBox;
    CB_COM2: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BtnEmissionClick(Sender: TObject);
    procedure BtnReceptionClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Reception;
    procedure Emmission;
    procedure Initial(Com:string);
    procedure Initial_Reception;
    procedure Initial_Emmission;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  end;

var
  Form1: TForm1;
  Count : integer;
  Temps: cardinal;
implementation

{$R *.dfm}

Function GetFileSise(FileName:String):LongInt;
var
  Search:TSearchRec;
begin
  If FindFirst(ExpandFileName(FileName),faAnyFile,Search) = 0 Then
    Result := Search.Size
  else
    result := 0
end;

function TempsReste(TimeCount : cardinal):TDateTime;
var
  h, m, s : word;
  Count : Cardinal;
begin
  Count := GetTickCount - TimeCount;
  h := (Count div 3600000) mod 24;
  m := (Count div 60000) mod 60;
  s := (Count div 1000) mod 60;
  Result := Encodetime(h, m, s, 0);
end;

function Port(Com:string):word;
begin
  if Com = 'COM1' then
    result := $3f8
  else
    result := $2f8
end;
function LSR(Port :word):word;
begin
  LSR:= $3FD;
  case Port of
    $2F8: LSR := $2FD;
    $3F8: LSR := $3FD;
  end;
end;

procedure SetPort(port:word; valeur: byte);
begin
  asm
    mov al, valeur;
    mov dx, port;
    out dx, al;
  end;
end;

function GetPort(port:word):byte;
var
  valeur:byte;
begin
  asm                       
    mov dx, port;
    in al, dx;
    mov valeur, al;
  end;
  GetPort := valeur;
end;

procedure SendChar(Port:word; C: char);
begin
  while (GetPort(LSR(Port)) and $20)=0 do ;
  SetPort(Port,Ord(C));
end;

Function ReadChar(Port:word): char;
begin
  while not odd(GetPort(LSR(Port))) do ;
  ReadChar:= Chr(GetPort(Port));
end;

procedure Tform1.Initial(Com:string);
begin
  if Port(Com) = $3f8 then
    begin
      SetPort($3FB, $80);
      SetPort($3f8, 1);
      SetPort($3FB, $3);
    end
  else
    begin
      SetPort($2FB, $80);
      SetPort($2f8, 1);
      SetPort($2FB, $3);
    end
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
Initial(CB_Com1.Text);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Initial(CB_Com2.Text);
end;

procedure TForm1.BtnEmissionClick(Sender: TObject);
begin
  Initial_Emmission;
  SendChar(Port(CB_Com1.Text),'$');
  Emmission;
end;

procedure TForm1.BtnReceptionClick(Sender: TObject);
begin
  Initial_Reception;
  if ReadChar(Port(CB_Com2.Text))= '$' then
    begin
      SendChar (Port(CB_Com2.Text),'ù');
      Reception;
    end;
end;

procedure TForm1.Initial_Reception;
begin
  Temps := gettickcount;
  BtnReception.Enabled := false;
  Statusbar1.Panels[1].Text := 'Réception en cours...';
end;

procedure TForm1.Reception;
label debut;
var f:file of byte;
     nomf:string;
     c:byte;
begin
   nomf :=edit2.Text;
   assignfile(f,nomf);
   rewrite(f);
 debut:
 if ReadChar(Port(CB_Com2.Text)) <> '£' then
    begin
      C:=GetPort(Port(CB_Com2.Text));
      write(f,C);
      SendChar (Port(CB_Com2.Text),'ù');
      Application.ProcessMessages;
      Statusbar1.Panels[2].Text := TimeToStr(TempsReste(Temps));
    goto debut;
    end
  else
    begin
      BtnReception.Enabled := true;
      Statusbar1.Panels[1].Text := 'Réception términé';
      CloseFile(f);
    end;
end;

procedure TForm1.Initial_Emmission;
begin
  Temps := gettickcount;
  BtnEmission.Enabled := false;
  Statusbar1.Panels[0].Text := 'Emission en cours...';
  Count := 0;
end;

procedure TForm1.Emmission;
label debut;
var f:file of byte;
     nomf:string;
     c:byte;
begin
   nomf :=edit1.Text;
   assignfile(f,nomf);
   reset(f);
 debut:
  if (ReadChar(Port(CB_Com1.Text)) = 'ù') then
    if (count < GetFileSise(edit1.Text))then
    begin
      seek(f,Count);
      read(f,C);
      SendChar (Port(CB_Com1.Text),Chr(C));
      inc(count);
      Application.ProcessMessages;
      Statusbar1.Panels[2].Text := TimeToStr(TempsReste(Temps));
      goto debut
    end
  else
    begin
      SendChar(Port(CB_Com1.Text),'£');
      BtnEmission.Enabled := true;
      Statusbar1.Panels[0].Text := 'Emission términé';
      closefile(f);
    end;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
 { MsComm.CommPort := StrToInt(EditComm.Text);
  MsComm.Settings :=
    Edit_Vitesse.Text + ',n,' +
    Edit_Donnees.Text + ',' +
    Edit_Stop.Text;}
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if od.Execute then
    begin
      Edit1.Text := od.FileName;
      BtnEmission.Enabled := true;
    end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
   if SD.Execute then
    begin
      Edit2.Text:=SD.FileName;
      BtnReception.Enabled := true;
    end;
end;

end.

mov dx,$3fb   //RLC
mov al,80
out dx,al

mov dx,$3f8   //DLL
mov al,18
out dx,al
inc dx

xor al,al
out dx,al
mov al,$1e
mov dx,$3fb
out dx,al

mov dx,$3f9
mov al,01
out dx,al


