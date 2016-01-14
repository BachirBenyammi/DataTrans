object MainForm: TMainForm
  Left = 221
  Top = 137
  Width = 309
  Height = 235
  BorderIcons = [biSystemMenu]
  Caption = 'Transmission S'#233'rie'
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object StatusBar1: TStatusBar
    Left = 0
    Top = 189
    Width = 301
    Height = 19
    Panels = <
      item
        Width = 70
      end
      item
        Width = 85
      end
      item
        Width = 85
      end
      item
        Width = 50
      end>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 297
    Height = 185
    ActivePage = TabSheet1
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Emission'
      object SpeedButton1: TSpeedButton
        Left = 256
        Top = 104
        Width = 25
        Height = 22
        Caption = '...'
        OnClick = SpeedButton1Click
      end
      object Button1: TButton
        Left = 72
        Top = 72
        Width = 105
        Height = 25
        Caption = 'Initialiser'
        TabOrder = 0
        OnClick = Button1Click
      end
      object BtnEmission: TButton
        Left = 184
        Top = 72
        Width = 97
        Height = 25
        Caption = '&Envoyer'
        TabOrder = 1
        OnClick = BtnEmissionClick
      end
      object Edit_Src: TEdit
        Left = 8
        Top = 104
        Width = 241
        Height = 24
        TabOrder = 2
      end
      object CB_Com1: TComboBox
        Left = 8
        Top = 72
        Width = 57
        Height = 22
        Style = csOwnerDrawFixed
        ItemHeight = 16
        TabOrder = 3
        Items.Strings = (
          'COM1'
          'COM2')
      end
      object Anim_Emi: TAnimate
        Left = 8
        Top = 8
        Width = 272
        Height = 60
        CommonAVI = aviCopyFile
        StopFrame = 26
      end
      object Pb_Emi: TProgressBar
        Left = 8
        Top = 136
        Width = 273
        Height = 16
        TabOrder = 5
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Rec'#233'ption'
      ImageIndex = 1
      object SpeedButton2: TSpeedButton
        Left = 256
        Top = 104
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SpeedButton2Click
      end
      object Button3: TButton
        Left = 72
        Top = 72
        Width = 105
        Height = 25
        Caption = 'Initialiser'
        TabOrder = 0
        OnClick = Button3Click
      end
      object BtnReception: TButton
        Left = 184
        Top = 72
        Width = 97
        Height = 25
        Caption = '&Recevoir'
        TabOrder = 1
        OnClick = BtnReceptionClick
      end
      object Edit_Dest: TEdit
        Left = 8
        Top = 104
        Width = 241
        Height = 24
        TabOrder = 2
      end
      object CB_COM2: TComboBox
        Left = 8
        Top = 72
        Width = 57
        Height = 22
        Style = csOwnerDrawFixed
        ItemHeight = 16
        TabOrder = 3
        Items.Strings = (
          'COM1'
          'COM2')
      end
      object Anim_Rec: TAnimate
        Left = 8
        Top = 8
        Width = 272
        Height = 60
        CommonAVI = aviCopyFile
        StopFrame = 26
      end
      object PB_Rec: TProgressBar
        Left = 8
        Top = 133
        Width = 273
        Height = 16
        TabOrder = 5
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'A propos'
      ImageIndex = 2
      object Label1: TLabel
        Left = 84
        Top = 24
        Width = 100
        Height = 16
        Caption = 'BENYAMMI Bachir'
        Font.Charset = ARABIC_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 64
        Top = 48
        Width = 166
        Height = 16
        Caption = '3 eme Ann'#233'e Info. cycle long'
        Font.Charset = ARABIC_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 48
        Top = 72
        Width = 194
        Height = 16
        Caption = 'Universit'#233' de laghouat Amar Tlidji'
        Font.Charset = ARABIC_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 104
        Top = 96
        Width = 66
        Height = 16
        Caption = '12-05-2004'
        Font.Charset = ARABIC_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object OD: TOpenDialog
    Left = 176
  end
  object SD: TSaveDialog
    Left = 208
  end
end
