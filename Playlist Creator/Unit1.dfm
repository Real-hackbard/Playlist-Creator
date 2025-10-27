object Form1: TForm1
  Left = 1719
  Top = 248
  Caption = 'Playlist Creator 1.0 Source'
  ClientHeight = 545
  ClientWidth = 908
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 13
  object CheckListBox1: TCheckListBox
    Left = 0
    Top = 85
    Width = 908
    Height = 340
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemHeight = 13
    ParentCtl3D = False
    ParentFont = False
    PopupMenu = PopupMenu1
    Style = lbOwnerDrawFixed
    TabOrder = 0
    OnClick = CheckListBox1Click
    ExplicitWidth = 904
    ExplicitHeight = 339
  end
  object ListBox1: TListBox
    Left = 384
    Top = 105
    Width = 138
    Height = 104
    ItemHeight = 13
    TabOrder = 1
    Visible = False
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 526
    Width = 908
    Height = 19
    Panels = <
      item
        Text = 'Count :'
        Width = 50
      end
      item
        Text = '0'
        Width = 50
      end
      item
        Text = 'Checked :'
        Width = 60
      end
      item
        Text = '0'
        Width = 50
      end
      item
        Text = 'List :'
        Width = 40
      end
      item
        Width = 50
      end>
    ExplicitTop = 525
    ExplicitWidth = 904
  end
  object Panel1: TPanel
    Left = 0
    Top = 425
    Width = 908
    Height = 101
    Align = alBottom
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 3
    ExplicitTop = 424
    ExplicitWidth = 904
    object CheckBox1: TCheckBox
      Left = 822
      Top = 15
      Width = 69
      Height = 17
      TabStop = False
      Caption = 'Check All'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object Button1: TButton
      Left = 822
      Top = 67
      Width = 75
      Height = 25
      Caption = 'Create'
      TabOrder = 1
      TabStop = False
      OnClick = Button1Click
    end
    object GroupBox1: TGroupBox
      Left = 9
      Top = 6
      Width = 439
      Height = 86
      Caption = ' File :'
      TabOrder = 2
      object Label5: TLabel
        Left = 179
        Top = 30
        Width = 22
        Height = 13
        Caption = 'File :'
      end
      object Label4: TLabel
        Left = 25
        Top = 57
        Width = 26
        Height = 13
        Caption = 'Link :'
        Enabled = False
      end
      object Label3: TLabel
        Left = 13
        Top = 30
        Width = 38
        Height = 13
        Caption = 'Playlist :'
      end
      object Label7: TLabel
        Left = 279
        Top = 30
        Width = 46
        Height = 13
        Caption = 'Unicode :'
      end
      object Label13: TLabel
        Left = 344
        Top = 57
        Width = 25
        Height = 13
        Caption = 'Port :'
        Enabled = False
      end
      object ComboBox1: TComboBox
        Left = 57
        Top = 27
        Width = 111
        Height = 21
        Style = csDropDownList
        DropDownCount = 11
        TabOrder = 0
        TabStop = False
        OnChange = ComboBox1Change
        Items.Strings = (
          'M3U Playlist'
          'M3U Extended'
          'M3U Server'
          'M3U Website'
          'M3U8 Stream'
          'M3A'
          'PLS Playlist'
          'PLS Website'
          'PLS Stream'
          'XSPF Playlist'
          'XSPF Stream')
      end
      object ComboBox2: TComboBox
        Left = 207
        Top = 27
        Width = 60
        Height = 21
        Style = csDropDownList
        DropDownCount = 12
        TabOrder = 1
        TabStop = False
        Items.Strings = (
          '.mp3'
          '.wav'
          '.flac'
          '.ogg'
          '.aac'
          '.ttf'
          '.mp4'
          '.mkv'
          '.avi'
          '*-*')
      end
      object Edit2: TEdit
        Left = 57
        Top = 54
        Width = 270
        Height = 21
        TabStop = False
        Enabled = False
        TabOrder = 2
      end
      object ComboBox3: TComboBox
        Left = 333
        Top = 27
        Width = 90
        Height = 21
        Style = csDropDownList
        TabOrder = 3
        TabStop = False
        Items.Strings = (
          'UTF-8'
          'UTF-8 Boom'
          'UTF-16 LE'
          'UTF-16 BE'
          'Ansi')
      end
      object Edit8: TEdit
        Left = 375
        Top = 54
        Width = 48
        Height = 21
        TabStop = False
        Enabled = False
        MaxLength = 5
        TabOrder = 4
        Text = '80'
        OnKeyPress = Edit8KeyPress
      end
    end
    object GroupBox2: TGroupBox
      Left = 454
      Top = 6
      Width = 346
      Height = 86
      Caption = ' Extended only M3A :'
      TabOrder = 3
      object Label8: TLabel
        Left = 19
        Top = 30
        Width = 76
        Height = 13
        Caption = 'Play List Name :'
      end
      object Label9: TLabel
        Left = 225
        Top = 31
        Width = 35
        Height = 13
        Caption = 'Group :'
      end
      object Label10: TLabel
        Left = 22
        Top = 57
        Width = 35
        Height = 13
        Caption = 'Album :'
      end
      object Label11: TLabel
        Left = 136
        Top = 57
        Width = 19
        Height = 13
        Caption = 'Art :'
      end
      object Label12: TLabel
        Left = 225
        Top = 57
        Width = 35
        Height = 13
        Caption = 'Genre :'
      end
      object Edit3: TEdit
        Left = 101
        Top = 27
        Width = 115
        Height = 21
        TabOrder = 0
      end
      object Edit4: TEdit
        Left = 266
        Top = 27
        Width = 68
        Height = 21
        TabOrder = 1
      end
      object Edit5: TEdit
        Left = 63
        Top = 54
        Width = 58
        Height = 21
        TabOrder = 2
      end
      object Edit6: TEdit
        Left = 161
        Top = 54
        Width = 55
        Height = 21
        TabOrder = 3
      end
      object Edit7: TEdit
        Left = 266
        Top = 54
        Width = 68
        Height = 21
        TabOrder = 4
      end
    end
    object CheckBox2: TCheckBox
      Left = 822
      Top = 38
      Width = 65
      Height = 17
      Caption = 'Stay Top'
      TabOrder = 4
      OnClick = CheckBox2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 908
    Height = 85
    Align = alTop
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 4
    ExplicitWidth = 904
    DesignSize = (
      908
      85)
    object Label1: TLabel
      Left = 15
      Top = 58
      Width = 82
      Height = 13
      Caption = 'Search Directory:'
    end
    object Label2: TLabel
      Left = 34
      Top = 11
      Width = 199
      Height = 39
      Caption = 'Playlist Creator'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Impact'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 235
      Top = 32
      Width = 287
      Height = 13
      Caption = 'Create Song, Video && Web Streams Playlist with simple clicks'
    end
    object Edit1: TEdit
      Left = 103
      Top = 56
      Width = 761
      Height = 19
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 0
      ExplicitWidth = 757
    end
    object Button2: TButton
      Left = 870
      Top = 54
      Width = 27
      Height = 23
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object SaveDialog1: TSaveDialog
    Title = 'Save Playlist'
    Left = 244
    Top = 101
  end
  object PopupMenu1: TPopupMenu
    Left = 143
    Top = 98
    object Open1: TMenuItem
      Caption = 'Open'
      OnClick = Open1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Paste1: TMenuItem
      Caption = 'Paste'
      OnClick = Paste1Click
    end
    object Remove1: TMenuItem
      Caption = 'Remove'
      OnClick = Remove1Click
    end
    object Clear1: TMenuItem
      Caption = 'Clear'
      OnClick = Clear1Click
    end
    object Checkall1: TMenuItem
      AutoCheck = True
      Caption = 'Check all'
      OnClick = Checkall1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Reload1: TMenuItem
      Caption = 'Reload'
      OnClick = Reload1Click
    end
    object Create1: TMenuItem
      Caption = 'Create'
      OnClick = Create1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Font1: TMenuItem
      Caption = 'Font'
      OnClick = Font1Click
    end
    object Panel3: TMenuItem
      AutoCheck = True
      Caption = 'Panel'
      Checked = True
      OnClick = Panel3Click
    end
  end
  object OpenDialog1: TOpenDialog
    Title = 'Load Link list'
    Left = 141
    Top = 170
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Left = 240
    Top = 164
  end
end
