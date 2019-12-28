object Form2: TForm2
  Left = 392
  Top = 106
  Width = 320
  Height = 270
  Caption = 'List'#225'k szerkeszt'#233'se'
  Color = clBtnFace
  Constraints.MinHeight = 270
  Constraints.MinWidth = 320
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ComboBox1: TComboBox
    Left = 4
    Top = 8
    Width = 221
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = ComboBox1Click
    OnDropDown = ComboBox1DropDown
  end
  object Memo1: TMemo
    Left = 4
    Top = 36
    Width = 221
    Height = 204
    BevelInner = bvLowered
    BevelOuter = bvRaised
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object Button1: TButton
    Left = 232
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Megnyit'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 232
    Top = 92
    Width = 75
    Height = 25
    Caption = 'Ment'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 232
    Top = 36
    Width = 75
    Height = 25
    Caption = #218'j'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 232
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Ment'#233's mint...'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 232
    Top = 150
    Width = 75
    Height = 25
    Caption = 'F'#225'jl t'#246'rl'#233'se'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 232
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Bez'#225'r'
    TabOrder = 7
    OnClick = Button6Click
  end
  object odlg1: TOpenDialog
    DefaultExt = 'TXT'
    Filter = '*.txt|*.txt'
    InitialDir = '.'
    Options = [ofPathMustExist, ofFileMustExist, ofEnableSizing, ofForceShowHidden]
    Left = 272
    Top = 4
  end
  object sdlg1: TSaveDialog
    DefaultExt = 'TXT'
    Filter = '*.txt|*.txt'
    InitialDir = '.'
    Options = [ofPathMustExist, ofEnableSizing]
    Left = 244
    Top = 4
  end
end
