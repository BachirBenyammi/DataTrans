object Form1: TForm1
  Left = 13
  Top = 111
  Width = 399
  Height = 188
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
  object SpeedButton1: TSpeedButton
    Left = 360
    Top = 40
    Width = 23
    Height = 22
    Caption = '...'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 360
    Top = 104
    Width = 23
    Height = 22
    Caption = '...'
    OnClick = SpeedButton2Click
  end
  object Button1: TButton
    Left = 72
    Top = 8
    Width = 105
    Height = 25
    Caption = 'Inistialiser 1er Com'
    TabOrder = 0
    OnClick = Button1Click
  end
  object BtnEmission: TButton
    Left = 184
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Envoyer'
    Enabled = False
    TabOrder = 1
    OnClick = BtnEmissionClick
  end
  object Button3: TButton
    Left = 72
    Top = 72
    Width = 105
    Height = 25
    Caption = 'Initialer 2 eme Com'
    TabOrder = 2
    OnClick = Button3Click
  end
  object BtnReception: TButton
    Left = 184
    Top = 72
    Width = 75
    Height = 25
    Caption = '&Recevoir'
    Enabled = False
    TabOrder = 3
    OnClick = BtnReceptionClick
  end
  object Edit1: TEdit
    Left = 8
    Top = 40
    Width = 345
    Height = 21
    TabOrder = 4
  end
  object Edit2: TEdit
    Left = 8
    Top = 104
    Width = 345
    Height = 21
    TabOrder = 5
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 142
    Width = 391
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 50
      end>
  end
  object CB_Com1: TComboBox
    Left = 8
    Top = 8
    Width = 57
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 7
    Items.Strings = (
      'COM1'
      'COM2')
  end
  object CB_COM2: TComboBox
    Left = 8
    Top = 72
    Width = 57
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 8
    Items.Strings = (
      'COM1'
      'COM2')
  end
  object OD: TOpenDialog
    Left = 280
    Top = 8
  end
  object SD: TSaveDialog
    Left = 256
    Top = 8
  end
end
