object Form1: TForm1
  Left = 51
  Top = 159
  Width = 426
  Height = 105
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Transmission parall'#232'le'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 24
    Top = 8
    Width = 257
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 24
    Top = 40
    Width = 257
    Height = 21
    TabOrder = 1
  end
  object BtnEnvoyer: TButton
    Left = 296
    Top = 8
    Width = 105
    Height = 25
    Caption = '&Envoyer'
    TabOrder = 2
    OnClick = BtnEnvoyerClick
  end
  object BtnRecevoir: TButton
    Left = 296
    Top = 40
    Width = 105
    Height = 25
    Caption = '&Recevoir'
    TabOrder = 3
    OnClick = BtnRecevoirClick
  end
end
