unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellApi, ComCtrls, Buttons;

type
  TMainForm = class(TForm)
    StatusBar1: TStatusBar;
    OD: TOpenDialog;
    SD: TSaveDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    SpeedButton1: TSpeedButton;
    Button1: TButton;
    BtnEmission: TButton;
    Edit_Src: TEdit;
    CB_Com1: TComboBox;
    Anim_Emi: TAnimate;
    TabSheet2: TTabSheet;
    SpeedButton2: TSpeedButton;
    Button3: TButton;
    BtnReception: TButton;
    Edit_Dest: TEdit;
    CB_COM2: TComboBox;
    Anim_Rec: TAnimate;
    Pb_Emi: TProgressBar;
    PB_Rec: TProgressBar;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BtnEmissionClick(Sender: TObject);
    procedure BtnReceptionClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Reception;
    procedure Emmission;
    procedure Initial(Com:string);
    procedure Initial_Reception;
    procedure Initial_Emmission;
    Function ReadByte(Port:word): Byte;
    procedure SendByte(Port:word; B: Byte);
    Function ReadChar(Port:word): char;    
    procedure SendChar(Port:word; C: char);
    function GetPort(port:word):byte;
    procedure SetPort(port:word; valeur: byte);
    function LSR(Port :word):word;
    function Port(Com:string):word;
    function TempsReste(TimeCount : cardinal):TDateTime;
    Function TailleFichier(FileName:String):integer;
    procedure EnvoyerTaille(Taille: integer);
    function RecevoirTaille: integer;
  end;

var
  MainForm: TMainForm;
  Temps: cardinal;
  Taille_Fichier_Emi, Count_Fichier_Emi, Taille_Fichier_Rec, Count_Fichier_Rec: integer;
implementation

{$R *.dfm}

function CalculVitesse(FilePos, TimeCount : Cardinal):String;
var
  Speed: Double;
begin
  Speed := FilePos /( abs(GetTickCount - TimeCount) /1000) ;
  Result := FormatFloat('0.00',Speed) + ' Byte/S';
end;

Function TMainform.TailleFichier(FileName:String):integer;
var
  Search:TSearchRec;
begin
  If FindFirst(ExpandFileName(FileName),faAnyFile,Search) = 0 Then
    Result := Search.Size
  else
    result := 0
end;

procedure TMainForm.EnvoyerTaille(Taille: integer);
var
  a, b, c , d: byte;
begin
  asm
    mov eax, Taille;
    mov a, al;
    mov b, ah;
    shr eax, 16;
    mov c, al;
    mov d, ah;
  end;
  SendByte(Port(CB_Com1.Text),a);
  ReadChar(Port(CB_Com1.Text));
  SendByte(Port(CB_Com1.Text),b);
  ReadChar(Port(CB_Com1.Text));
  SendByte(Port(CB_Com1.Text),c);
  ReadChar(Port(CB_Com1.Text));
  SendByte(Port(CB_Com1.Text),d);
end;

function TMainForm.RecevoirTaille;
var
  a, b, c, d: byte;
  taille:integer;
begin
  a := ReadByte(Port(CB_Com2.Text));
  SendChar(Port(CB_Com2.Text),'ù');
  b := ReadByte(Port(CB_Com2.Text));
  SendChar(Port(CB_Com2.Text),'ù');
  c := ReadByte(Port(CB_Com2.Text));
  SendChar(Port(CB_Com2.Text),'ù');
  d := ReadByte(Port(CB_Com2.Text));
  asm
    mov ah, d;
    mov al, c;
    shl eax, 16;
    mov al, a;
    mov ah, b;
    mov taille, eax;
  end;
  result := taille;
end;

function TMainForm.TempsReste(TimeCount : cardinal):TDateTime;
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

function TMainForm.Port(Com:string):word;
begin
  if Com = 'COM1' then
    result := $3f8
  else
    result := $2f8
end;

function TMainForm.LSR(Port :word):word;
begin
  LSR:= $3FD;
  case Port of
    $2F8: LSR := $2FD;
    $3F8: LSR := $3FD;
  end;
end;

procedure TMainForm.SetPort(port:word; valeur: byte);
begin
  asm
    mov al, valeur;
    mov dx, port;
    out dx, al;
  end;
end;

function TMainForm.GetPort(port:word):byte;
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

procedure TMainForm.SendByte(Port:word; B: Byte);
begin
  while (GetPort(LSR(Port)) and $20)=0 do ;
  SetPort(Port,B);
end;

procedure TMainForm.SendChar(Port:word; C: char);
begin
  SendByte(Port, Ord(C))
end;

Function TMainForm.ReadByte(Port:word): Byte;
begin
  while not odd(GetPort(LSR(Port))) do ;
  ReadByte:= GetPort(Port);
end;

Function TMainForm.ReadChar(Port:word): char;
begin
 ReadChar:= Chr(ReadByte(Port));
end;

procedure TMainForm.Initial(Com:string);
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

procedure TMainForm.Button1Click(Sender: TObject);
begin
Initial(CB_Com1.Text);
end;

procedure TMainForm.Button3Click(Sender: TObject);
begin
Initial(CB_Com2.Text);
end;

procedure TMainForm.BtnEmissionClick(Sender: TObject);
begin
  Initial_Emmission;
  Emmission;
end;

procedure TMainForm.BtnReceptionClick(Sender: TObject);
begin
  Initial_Reception;
  Reception;
end;

procedure TMainForm.Initial_Emmission;
begin
  Temps := gettickcount;
  Taille_Fichier_Emi := TailleFichier(Edit_Src.Text);
  BtnEmission.Enabled := false;
  Caption := 'Transmission Série - [Emission en cours...]';
  Statusbar1.Panels[1].Text := 'Taille: '+InttoStr(Taille_Fichier_Emi);
  Count_Fichier_Emi := 0;
  SendChar(Port(CB_Com1.Text),'$');
  Anim_Emi.Active:=true;
  PB_Emi.Min:=0;
  PB_Emi.Max:=Taille_Fichier_Emi;
  if ReadChar(Port(CB_Com1.Text)) = 'ù' then
    EnvoyerTaille(Taille_Fichier_Emi);
end;

procedure TMainForm.Initial_Reception;
begin
  Temps := gettickcount;
  Count_Fichier_Rec := 0;
  BtnReception.Enabled := false;
  Anim_Rec.Active:=true;
 if ReadChar(Port(CB_Com2.Text))= '$' then
    begin
      SendChar (Port(CB_Com2.Text),'ù');
      Taille_Fichier_Rec := RecevoirTaille;
      SendChar (Port(CB_Com2.Text),'ù');
    end;
  Caption := 'Transmission Série - [Réception en cours...]';
  Statusbar1.Panels[1].Text := 'Taille: '+ InttoStr(Taille_Fichier_Rec);
  PB_Rec.Min:=0;
  PB_Rec.Max:=Taille_Fichier_Rec;
end;

procedure TMainForm.Emmission;
var f:file of byte;
     nomf:string;
     c:byte;
begin
   nomf :=Edit_Src.Text;
   assignfile(f,nomf);
   reset(f);
   While Count_Fichier_Emi < Taille_Fichier_Emi  do
    if (ReadChar(Port(CB_Com1.Text)) = 'ù') then
    begin
      seek(f,Count_Fichier_Emi);
      read(f,C);
      SendChar (Port(CB_Com1.Text),Chr(C));
      PB_Emi.Position := PB_Emi.Position +1 ;
      Statusbar1.Panels[0].Text := CalculVitesse(PB_Emi.Position, Temps );
      Statusbar1.Panels[2].Text := 'Transmit: '+IntToStr(Count_Fichier_Emi);
      Statusbar1.Panels[3].Text := TimeToStr(TempsReste(Temps));
      Inc(Count_Fichier_Emi);
      Application.ProcessMessages;
    end;
  BtnEmission.Enabled := true;
  Caption := 'Transmission Série - [Emission Terminé]';
  Anim_Emi.Active:=false;
  PB_Emi.Position:=0;
  closefile(f);
end;

procedure TMainForm.Reception;
var f:file of byte;
     nomf:string;
     c:byte;
begin
   nomf :=Edit_Dest.Text;
   assignfile(f,nomf);
   rewrite(f);
  While Count_Fichier_Rec < Taille_Fichier_Rec  do
    begin
      C:=ReadByte(Port(CB_Com2.Text));
      write(f,C);
      Statusbar1.Panels[0].Text := CalculVitesse(PB_Rec.Position, Temps );
      Statusbar1.Panels[2].Text := 'Reçu: '+InttoStr(Count_Fichier_Rec);
      Statusbar1.Panels[3].Text := TimeToStr(TempsReste(Temps));
      PB_Rec.Position := PB_Rec.Position +1 ;
      SendChar (Port(CB_Com2.Text),'ù');
      Application.ProcessMessages;
      Inc(Count_Fichier_Rec)
    end;
  BtnReception.Enabled := true;
  Caption := 'Transmission Série - [Récpetion Terminé]';
  Anim_Rec.Active:=false;
  PB_Rec.Position:=0;
  CloseFile(f);
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  if od.Execute then
    begin
      Edit_Src.Text := od.FileName;
      BtnEmission.Enabled := true;
    end;
end;

procedure TMainForm.SpeedButton2Click(Sender: TObject);
begin
   if SD.Execute then
    begin
      Edit_Dest.Text:=SD.FileName;
      BtnReception.Enabled := true;
    end;
end;

end.
