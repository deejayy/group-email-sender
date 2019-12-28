object Form3: TForm3
  Left = 421
  Top = 120
  Width = 350
  Height = 150
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Be'#225'll'#237't'#225'sok'
  Color = clBtnFace
  Constraints.MaxHeight = 150
  Constraints.MinHeight = 150
  Constraints.MinWidth = 350
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 52
    Top = 16
    Width = 30
    Height = 13
    Caption = 'SMTP'
  end
  object Label2: TLabel
    Left = 28
    Top = 44
    Width = 54
    Height = 13
    Caption = 'X-Company'
  end
  object Label3: TLabel
    Left = 28
    Top = 72
    Width = 54
    Height = 13
    Caption = 'K'#252'ld'#337' neve'
  end
  object Label4: TLabel
    Left = 0
    Top = 100
    Width = 83
    Height = 13
    Caption = 'K'#252'ld'#337' e-mail c'#237'me'
  end
  object Edit1: TEdit
    Left = 88
    Top = 12
    Width = 150
    Height = 21
    Constraints.MinWidth = 150
    TabOrder = 0
    OnKeyDown = Edit1KeyDown
  end
  object Edit2: TEdit
    Left = 244
    Top = 12
    Width = 33
    Height = 21
    TabOrder = 1
    OnKeyDown = Edit1KeyDown
  end
  object Edit3: TEdit
    Left = 88
    Top = 40
    Width = 150
    Height = 21
    Constraints.MinWidth = 150
    TabOrder = 2
    OnKeyDown = Edit1KeyDown
  end
  object Edit4: TEdit
    Left = 88
    Top = 68
    Width = 150
    Height = 21
    Constraints.MinWidth = 150
    TabOrder = 3
    OnKeyDown = Edit1KeyDown
  end
  object Edit5: TEdit
    Left = 88
    Top = 96
    Width = 150
    Height = 21
    Constraints.MinWidth = 150
    TabOrder = 4
    OnKeyDown = Edit1KeyDown
  end
  object Button1: TButton
    Left = 250
    Top = 92
    Width = 75
    Height = 25
    Caption = 'Bez'#225'r'
    TabOrder = 5
    OnClick = Button1Click
  end
end
