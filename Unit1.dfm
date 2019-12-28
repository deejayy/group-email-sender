object Form1: TForm1
  Left = 358
  Top = 122
  Width = 590
  Height = 400
  Caption = 'Lista lev'#233'lk'#252'ld'#337
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 590
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 36
    Width = 30
    Height = 13
    Caption = 'T'#233'ma:'
  end
  object ComboBox1: TComboBox
    Left = 4
    Top = 4
    Width = 217
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnDropDown = ComboBox1DropDown
  end
  object Memo1: TMemo
    Left = 4
    Top = 60
    Width = 480
    Height = 170
    Constraints.MinHeight = 170
    Constraints.MinWidth = 480
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object Button1: TButton
    Left = 500
    Top = 60
    Width = 75
    Height = 25
    Caption = 'F'#225'jlb'#243'l...'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 500
    Top = 122
    Width = 75
    Height = 25
    Caption = 'F'#225'jlba...'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 310
    Top = 250
    Width = 95
    Height = 25
    Caption = 'Csatol'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 310
    Top = 290
    Width = 95
    Height = 25
    Caption = 'Csatol'#225'sokat t'#246'rli'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 414
    Top = 250
    Width = 73
    Height = 65
    Caption = 'Elk'#252'ld'#233's'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Memo2: TMemo
    Left = 4
    Top = 240
    Width = 300
    Height = 90
    Constraints.MinHeight = 90
    Constraints.MinWidth = 300
    ScrollBars = ssBoth
    TabOrder = 7
    WordWrap = False
  end
  object Edit1: TEdit
    Left = 44
    Top = 32
    Width = 353
    Height = 21
    TabOrder = 8
  end
  object sb: TStatusBar
    Left = 0
    Top = 335
    Width = 582
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object MainMenu1: TMainMenu
    Left = 452
    object Elkld1: TMenuItem
      Caption = 'Be'#225'll'#237't'#225'sok'
      OnClick = Elkld1Click
    end
    object Listk1: TMenuItem
      Caption = 'List'#225'k'
      OnClick = Listk1Click
    end
    object Segtsg1: TMenuItem
      Caption = 'Seg'#237'ts'#233'g'
      OnClick = Segtsg1Click
    end
  end
  object odlg1: TOpenDialog
    Filter = 'Any file|*.*'
    InitialDir = '.'
    Options = [ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 424
  end
  object sdlg1: TSaveDialog
    Filter = 'Any file|*.*'
    InitialDir = '.'
    Options = [ofPathMustExist, ofEnableSizing]
    Left = 396
  end
  object smtp: TSakSMTP
    Port = '25'
    SendProgressStep = 10
    OnError = smtpError
    TimeOut = 60000
    Left = 480
  end
  object msgx: TSakMsg
    CharSet = 'ISO-8859-1'
    Left = 508
  end
end
