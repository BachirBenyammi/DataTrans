object Form1: TForm1
  Left = 58
  Top = 106
  Width = 413
  Height = 200
  BorderIcons = [biSystemMenu]
  Caption = 'Transmission S'#233'rie'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Lab_Temps: TLabel
    Left = 48
    Top = 48
    Width = 36
    Height = 13
    Caption = '0:00:00'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 35
    Height = 13
    Caption = 'Temps:'
  end
  object Label1: TLabel
    Left = 296
    Top = 128
    Width = 28
    Height = 13
    Caption = 'Taille:'
  end
  object Lab_Taille_Rec: TLabel
    Left = 328
    Top = 128
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label3: TLabel
    Left = 296
    Top = 80
    Width = 28
    Height = 13
    Caption = 'Taille:'
  end
  object Lab_Taille_Emi: TLabel
    Left = 328
    Top = 80
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Initial Com1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 72
    Width = 75
    Height = 25
    Caption = '&Envoyer'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 112
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Initial Com2'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 120
    Width = 75
    Height = 25
    Caption = '&Recevoir'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Edit1: TEdit
    Left = 88
    Top = 72
    Width = 201
    Height = 21
    TabOrder = 4
  end
  object Edit2: TEdit
    Left = 88
    Top = 120
    Width = 201
    Height = 21
    TabOrder = 5
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 154
    Width = 405
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 50
      end>
  end
end
