unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellApi, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    StatusBar1: TStatusBar;
    Lab_Temps: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Lab_Taille_Rec: TLabel;
    Label3: TLabel;
    Lab_Taille_Emi: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Reception;
    procedure Emmission;
    procedure Initial_Reception;
    procedure Initial_Emmission;
  end;

var
  Form1: TForm1;
  Temps: cardinal;
  Taille_Emi, Count_Emi, Taille_Rec, Count_Rec: byte;
implementation

{$R *.dfm}

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

procedure SendByte(Port:word; B: Byte);
begin
  while (GetPort(LSR(Port)) and $20)=0 do ;
  SetPort(Port,B);
end;

procedure SendChar(Port:word; C: char);
begin
  SendByte(Port, Ord(C))
end;

Function ReadByte(Port:word): Byte;
begin
  while not odd(GetPort(LSR(Port))) do ;
  ReadByte:= GetPort(Port);
end;

Function ReadChar(Port:word): char;
begin
 ReadChar:= Chr(ReadByte(Port));
end;

procedure SetCOM1;
begin
  SetPort($3FB, $80);
  SetPort($3f8, 1);
  SetPort($3FB, $3);
end;

procedure SetCom2;
begin
  SetPort($2FB, $80);
  SetPort($2f8, $1);
  SetPort($2FB, $3);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
SetCom1;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
SetCom2;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Initial_Emmission;
  Emmission;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Initial_Reception;
  if ReadChar($2f8)= '$' then
    begin
      SendChar ($2f8,'ù');
      Taille_Rec := ReadByte($2f8);
      Lab_Taille_Rec.Caption := InttoStr(Taille_Rec);
      SendChar ($2f8,'ù');
      Reception;
    end;
end;

procedure TForm1.Initial_Reception;
begin
  Count_Rec := 0;
  Temps := gettickcount;
  Button4.Enabled := false;
  Statusbar1.Panels[1].Text := 'Réception en cours...';
end;

procedure TForm1.Reception;
begin
  While Count_Rec < Taille_Rec -1 do
  begin
    Edit2.text := edit2.text + ReadChar($2f8);
    SendChar ($2f8,'ù');
    Application.ProcessMessages;
    Lab_Temps.Caption := TimeToStr(TempsReste(Temps));
    Inc(Count_Rec)
  end;
  Button4.Enabled := true;
  Statusbar1.Panels[1].Text := 'Réception términé';
end;

procedure TForm1.Initial_Emmission;
begin
  Temps := gettickcount;
  Button2.Enabled := false;
  Statusbar1.Panels[0].Text := 'Emission en cours...';
  Count_Emi := 0;
  Taille_Emi := length(Edit1.Text);
  Lab_Taille_Emi.Caption := InttoStr(Taille_Emi);
  SendChar($3f8,'$');
  if (ReadChar($3f8) = 'ù') then
    SendByte($3f8,Taille_Emi);
end;

procedure TForm1.Emmission;
begin
  While Count_Emi < Taille_Emi -1 do
  if (ReadChar($3f8) = 'ù') then
    begin
      Inc(Count_Emi);
      SendChar ($3f8,edit1.text[Count_Emi]);
      Application.ProcessMessages;
      Lab_Temps.Caption := TimeToStr(TempsReste(Temps));
    end;
  Button2.Enabled := true;
  Statusbar1.Panels[0].Text := 'Emission términé';
end;

end.



