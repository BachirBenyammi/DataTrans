unit Unit1;

interface

uses
  Windows, SysUtils, Classes, Forms, StdCtrls, Controls, dialogs;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    BtnEnvoyer: TButton;
    BtnRecevoir: TButton;
    procedure BtnEnvoyerClick(Sender: TObject);
    procedure BtnRecevoirClick(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure EcritByte(C: byte; Port: word); assembler;
asm
  mov dx, Port;
  mov al, C
  out dx, al
end;

function LitByte(Port: word): byte; assembler
asm
  mov dx, Port;
  in al, dx
end;

procedure TestDonneesRecu;
begin
  repeat
    Application.ProcessMessages;
  until LitByte($378) = 0;
end;

procedure TestDonneesPret;
begin
  repeat
    Application.ProcessMessages;
  until LitByte($378) <> 0;
end;

procedure EnvoyerByte(c: byte);
begin
  TestDonneesRecu;
  EcritByte(c, $378);
end;

function RecevoirByte: byte;
begin
  TestDonneesPret;
  Result := LitByte($378);
  EcritByte(0, $378);
end;

procedure EnvoyeMsg(Msg: string);
var
  i: integer;
begin
  for i:= 0 to Length(Msg) - 1 do
    EnvoyerByte(Ord(Msg[i]));
end;

function RecevoirMsg(Taille: byte): string;
var
  i: integer;
  Msg: string;
begin
  Msg := '';
  for i := 0 to Taille - 1 do
    Msg := Msg + Chr(RecevoirByte);
  result := Msg;
end;

procedure TForm1.BtnEnvoyerClick(Sender: TObject);
var
  Taille : byte;
begin
  EcritByte(0, $378);
  Taille := length(Edit1.Text);
  EnvoyerByte(Taille);
  EnvoyeMsg(Edit1.Text);
end;

procedure TForm1.BtnRecevoirClick(Sender: TObject);
var
  Taille : byte;
begin
  EcritByte(0, $378);
  Taille := RecevoirByte;
  Edit2.Text := inttostr(Taille);
  Edit2.Text := RecevoirMsg(Taille);
end;

end.
