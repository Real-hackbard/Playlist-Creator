unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, FileCtrl, CheckLst, Vcl.Menus, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Clipbrd;

Type
  TID3Tag = record
    ID: string[3];
    Titel: string[30];
    Artist: string[30];
    Album: string[30];
    Year: string[4];
    Comment: string[30];
    Genre: byte;
    length: longint; //in sekunden;
    sample: integer;
    bits: byte;
    vers: byte;
    layers: byte;
end;

type
  TCheckListBox = class(Vcl.CheckLst.TCheckListBox)
  published
    property Multiselect;
  end;

type
  TForm1 = class(TForm)
    CheckListBox1: TCheckListBox;
    SaveDialog1: TSaveDialog;
    ListBox1: TListBox;
    PopupMenu1: TPopupMenu;
    Remove1: TMenuItem;
    Clear1: TMenuItem;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Reload1: TMenuItem;
    Label6: TLabel;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit2: TEdit;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    ComboBox3: TComboBox;
    Edit3: TEdit;
    Edit4: TEdit;
    OpenDialog1: TOpenDialog;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit5: TEdit;
    Label11: TLabel;
    Edit6: TEdit;
    Label12: TLabel;
    Edit7: TEdit;
    Label13: TLabel;
    Edit8: TEdit;
    N1: TMenuItem;
    Paste1: TMenuItem;
    CheckBox2: TCheckBox;
    Panel3: TMenuItem;
    N2: TMenuItem;
    Create1: TMenuItem;
    Checkall1: TMenuItem;
    Button2: TButton;
    Open1: TMenuItem;
    FontDialog1: TFontDialog;
    Font1: TMenuItem;
    N3: TMenuItem;
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Remove1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure CheckListBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Reload1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit8KeyPress(Sender: TObject; var Key: Char);
    procedure Paste1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure Create1Click(Sender: TObject);
    procedure Checkall1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Font1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  SearchRec: TSearchRec;
  ID3Tag: TID3Tag;

const
  MPEG_BIT_RATES : array[1..3] of array[1..3] of array[0..15] of word =
  { Version 1, Layer I }
    (((0,32,64,96,128,160,192,224,256,288,320,352,384,416,448,0),
  { Version 1, Layer II }
    (0,32,48,56, 64, 80, 96,112,128,160,192,224,256,320,384,0),
  { Version 1, Layer III }
    (0,32,40,48, 56, 64, 80, 96,112,128,160,192,224,256,320,0)),
  { Version 2, Layer I }
    ((0,32,48, 56, 64, 80, 96,112,128,144,160,176,192,224,256,0),
  { Version 2, Layer II }
    (0, 8,16,24, 32, 40, 48, 56, 64, 80, 96, 112,128,144,160,0),
  { Version 2, Layer III }
    (0, 8,16,24, 32, 40, 48, 56, 64, 80, 96, 112,128,144,160,0)),
  { Version 2.5, Layer I }
    ((0,32,48, 56, 64, 80, 96,112,128,144,160,176,192,224,256,0),
  { Version 2.5, Layer II }
    (0, 8,16,24, 32, 40, 48, 56, 64, 80, 96, 112,128,144,160,0),
  { Version 2.5, Layer III }
    (0, 8,16,24, 32, 40, 48, 56, 64, 80, 96, 112,128,144,160,0)));

  sample_rates: array[1..3] of array [0..3] of word=
    ((44100,48000,32000,0),
    (22050,24000,16000,0),
    (11025,12000,8000,0));

implementation

{$R *.dfm}
function Get_File_Size4(const S: string): Int64;
var
  FD: TWin32FindData;
  FH: THandle;
begin
  FH := FindFirstFile(PChar(S), FD);
  if FH = INVALID_HANDLE_VALUE then Result := 0
  else
    try
      Result := FD.nFileSizeHigh;
      Result := Result shl 32;
      Result := Result + FD.nFileSizeLow;
    finally
      //CloseHandle(FH);
    end;
end;

procedure Lese_ID3Tag(Filename: string);
var
  Buffer: array[1..128] of char;
  F: File;
  mp3hdrread: array[1..4] of byte;
  mp3hdr: longint absolute mp3hdrread;
  tempbyte, bitrateindex, versionindex: byte;
  bitrate, version, layer, size: longint;
begin
  AssignFile(F, Filename);

  Reset(F,1);
  size := filesize(f);
  blockread(f,mp3hdrread,4);
  tempbyte:=mp3hdrread[1];
  mp3hdrread[1]:=mp3hdrread[4];
  mp3hdrread[4]:=tempbyte;
  tempbyte:=mp3hdrread[2];
  mp3hdrread[2]:=mp3hdrread[3];
  mp3hdrread[3]:=tempbyte;

  reset(f,1);
  Seek(F,FileSize(F)-128);
  BlockRead(F, Buffer, SizeOf(@Buffer));
  CloseFile(F);
  bitrateindex:=((mp3hdr shr 12) and $F);
  versionindex:=((mp3hdr shr 19) and $3);

  case versionindex of
    0: version:=3;
    1: version:=0; //unbekannt
    2: version:=2;
    3: version:=1;
  end;

  layer:=4-((mp3hdr shr 17) and $3);

  if version<>0 then
    bitrate:=MPEG_BIT_RATES[version][layer][bitrateindex]
  else
    bitrate:=128;

  with ID3Tag do
  begin
    ID:=copy(Buffer,1,3);
    Titel:=copy(Buffer,4,30);
    Artist:=copy(Buffer,34,30);
    Album:=copy(Buffer,64,30);
    Year:=copy(Buffer,94,4);
    Comment:=copy(Buffer,98,30);
    Genre:=ord(Buffer[128]);
    sample:=sample_rates[version][((mp3hdr shr 10) and $3)];
    length:=(size) div ((bitrate)*1000);
    bits:=bitrate;
    vers:=version;
    layers:=layer;
  end;
end;

function GetCheckedCount(CheckListBox:TCheckListBox):Integer;
var I:Integer;
begin
   Result := 0;
    for i := 0 to CheckListBox.Items.Count - 1 do
      if CheckListBox.Checked[i] then inc(result);
end;

procedure Refreshlist;
var
  i: integer;
begin
  try
    I := FindFirst(Form1.edit1.text + '\*' + Form1.ComboBox2.Text, 0, SearchRec);
      while I = 0 do
      begin
      Form1.checklistbox1.items.Add(SearchRec.Name);
        I := FindNext(SearchRec);
      end;
  except
      raise;
  end;
    FindClose(SearchRec);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i, a, c: integer;
begin
  if CheckListBox1.Items.Count = 0 then begin
    Beep;
    MessageDlg('No List found!',mtInformation, [mbOK], 0);
    Exit;
  end;

  if StrToInt(StatusBar1.Panels[3].Text) = 0 then
  begin
    Beep;
    MessageDlg('No item Selected!',mtInformation, [mbOK], 0);
    Exit;
  end;

  a := 0;
  ListBox1.Clear;

  if (ComboBox1.ItemIndex = 9) or (ComboBox1.ItemIndex = 10) then
  begin
    ListBox1.Items.Add('<?xml version="1.0" encoding="' + ComboBox3.Text  + '"?>');
    ListBox1.Items.Add('<playlist version="1" xmlns="http://xspf.org/ns/0/">');
    ListBox1.Items.Add('<trackList>');
  end;

  if (ComboBox1.ItemIndex = 0) or (ComboBox1.ItemIndex = 1) or
    (ComboBox1.ItemIndex = 2) or (ComboBox1.ItemIndex = 3) or
    (ComboBox1.ItemIndex = 4) then
  begin
    ListBox1.Items.Add('#EXTM3U');
  end;

  if (ComboBox1.ItemIndex = 5) then
  begin
    ListBox1.Items.Add('#EXTM3U');
    ListBox1.Items.Add('#PLAYLIST:' + Edit3.Text);
    ListBox1.Items.Add('#EXTGRP:' + Edit4.Text);
    ListBox1.Items.Add('#EXTALB:' + Edit5.Text);
    ListBox1.Items.Add('#EXTART:' + Edit6.Text);
    ListBox1.Items.Add('#EXTGENRE:' + Edit7.Text);
  end;

  if (ComboBox1.ItemIndex = 6) or (ComboBox1.ItemIndex = 7) or
     (ComboBox1.ItemIndex = 8) then begin
     ListBox1.Items.Add('[Playlist]');
     Listbox1.Items.Add('NumberOfEntries=' + IntToStr(CheckListbox1.Items.Count)+#13);
  end;

  if SaveDialog1.Execute then begin
    Screen.Cursor := crHourGlass;
    for I := 0 to CheckListbox1.Count-1 do
    begin

      // m3u playlist
      if ComboBox1.ItemIndex = 0 then begin
        if CheckListbox1.Checked[I] = true then begin
          Listbox1.Items.Add(Edit1.text + '\' + CheckListbox1.Items.Strings[i]);
        end;
      end;

      // extended m3u playlist
      if ComboBox1.ItemIndex = 1 then begin
        if CheckListbox1.Checked[I] = true then begin

          if ComboBox2.ItemIndex = 0 then  // only mp3
          begin
            Lese_ID3Tag(Edit1.Text + '\' + CheckListbox1.Items.Strings[i]);
            Listbox1.Items.Add('#EXTINF:' + IntToStr(id3tag.length) + ',' +
                               CheckListbox1.Items.Strings[i]  );
          end;

          a := a + 1;
          ListBox1.Items.Add('Titel ' + IntToStr(a));
          Listbox1.Items.Add(Edit1.text + '\' + CheckListbox1.Items.Strings[I]);
        end;
      end;

      // extended m3u Server playlist
      if ComboBox1.ItemIndex = 2 then begin
        if CheckListbox1.Checked[I] = true then begin

          if ComboBox2.ItemIndex = 0 then  // only mp3
          begin
          Lese_ID3Tag(Edit1.Text + '\' + CheckListbox1.Items.Strings[i]);
          Listbox1.Items.Add('#EXTINF:' + IntToStr(id3tag.length) + ',' +
                             CheckListbox1.Items.Strings[i]  );
          end;

          a := a + 1;
          ListBox1.Items.Add('Titel ' + IntToStr(a));
          Listbox1.Items.Add(Edit2.text + CheckListbox1.Items.Strings[I]);
        end;
      end;

      // extended m3u Website playlist
      if ComboBox1.ItemIndex = 3 then begin
        if CheckListbox1.Checked[I] = true then begin
          a := a + 1;
          ListBox1.Items.Add('Titel ' + IntToStr(a));
          ListBox1.Items.Add('#EXTINF:-1,' + Edit2.Text);

          Listbox1.Items.Add(Edit2.text + CheckListbox1.Items.Strings[I]);
          Listbox1.Items.Add('Length' + IntToStr(a) + '=' + '-1');
        end;
      end;

      // m3u8 Webstream playlist
      if ComboBox1.ItemIndex = 4 then begin
        if CheckListbox1.Checked[I] = true then begin
          a := a + 1;
          ListBox1.Items.Add('Titel ' + IntToStr(a));
          Listbox1.Items.Add(Edit2.text + CheckListbox1.Items.Strings[I]);
        end;
      end;

      // extended m3a playlist
      if ComboBox1.ItemIndex = 5 then begin
        if CheckListbox1.Checked[I] = true then begin

        ListBox1.Items.Add('#EXTBYT:' + IntToStr(Get_File_Size4(Edit1.Text +
                           '\' + CheckListbox1.Items.Strings[i])));

          if ComboBox2.ItemIndex = 0 then  // only mp3
          begin
            Lese_ID3Tag(Edit1.Text + '\' + CheckListbox1.Items.Strings[i]);
            Listbox1.Items.Add('#EXTINF:' + IntToStr(id3tag.length) + ',' +
                               CheckListbox1.Items.Strings[i]  );
          end;
          a := a + 1;
          ListBox1.Items.Add('Titel ' + IntToStr(a));
          Listbox1.Items.Add(Edit1.text + '\' + CheckListbox1.Items.Strings[I]);
        end;
      end;

      // pls playlist
      if ComboBox1.ItemIndex = 6 then begin
        if CheckListbox1.Checked[I] = true then begin
          a := a + 1;
          Listbox1.Items.Add('File' + IntToStr(a) + '=' +
                             Edit1.text + '\' + CheckListbox1.Items.Strings[I]);
          Listbox1.Items.Add('Title' + IntToStr(a) + '=' +
                             CheckListbox1.Items.Strings[I]);

          if ComboBox2.ItemIndex = 0 then  // only mp3
          begin
            Lese_ID3Tag(Edit1.Text + '\' + CheckListbox1.Items.Strings[i]);
            Listbox1.Items.Add('Length' + IntToStr(a) + '=' +
                               IntToStr(id3tag.length));
          end;

          ListBox1.Items.Add(#13);
        end;
      end;

      // pls Website playlist
      if ComboBox1.ItemIndex = 7 then begin
        if CheckListbox1.Checked[I] = true then begin
          a := a + 1;
          Listbox1.Items.Add('File' + IntToStr(a) + '=' +
                             Edit2.text + '\' + CheckListbox1.Items.Strings[I]);
          Listbox1.Items.Add('Title' + IntToStr(a) + '=' +
                             CheckListbox1.Items.Strings[I]);
          Listbox1.Items.Add('Length' + IntToStr(a) + '=' + '-1');
          ListBox1.Items.Add(#13);
        end;
      end;

      // pls stream playlist
      if ComboBox1.ItemIndex = 8 then begin
        if CheckListbox1.Checked[i] = true then begin
          a := a + 1;
          Listbox1.Items.Add('File' + IntToStr(a) + '=' + CheckListbox1.Items.Strings[I] +
                              ':' + Edit8.Text);
          Listbox1.Items.Add('Title' + IntToStr(a) + '=' +
                             CheckListbox1.Items.Strings[i]);
          Listbox1.Items.Add('Length' + IntToStr(a) + '=' + '-1');
          ListBox1.Items.Add(#13);
        end;
      end;

      // xspf file playlist
      if ComboBox1.ItemIndex = 9 then begin
        if CheckListbox1.Checked[i] = true then begin
          ListBox1.Items.Add('  <track>');
          Listbox1.Items.Add('    <title>' + CheckListbox1.Items.Strings[I] + '</title>');
          Listbox1.Items.Add('      <creator>' + Form1.Caption + '</creator>');
          Listbox1.Items.Add('    <location>' + Edit1.Text + '\' +
                             CheckListbox1.Items.Strings[i] + '</location>');
          Listbox1.Items.Add('  </track>');
        end;
      end;

      // xspf stream playlist
      if ComboBox1.ItemIndex = 10 then begin
        if CheckListbox1.Checked[i] = true then begin
          ListBox1.Items.Add('  <track>');
          Listbox1.Items.Add('    <title>' + CheckListbox1.Items.Strings[I] + '</title>');
          Listbox1.Items.Add('      <creator>' + Form1.Caption + '</creator>');
          Listbox1.Items.Add('    <location>' + CheckListbox1.Items.Strings[i] + '</location>');
          Listbox1.Items.Add('  </track>');
        end;
      end;


    end;

    if (ComboBox1.ItemIndex = 9) or (ComboBox1.ItemIndex = 10) then
    begin
      ListBox1.Items.Add('</trackList>');
      ListBox1.Items.Add('</playlist>');
    end;

    if ComboBox1.ItemIndex = 6 then
    begin
      ListBox1.Items.Add(#13 + 'Version=2');
    end;

    if i = CheckListbox1.Count then
    begin
      if (ComboBox1.ItemIndex = 0) or (ComboBox1.ItemIndex = 1) or
         (ComboBox1.ItemIndex = 2) or (ComboBox1.ItemIndex = 3) then
         begin
          if ComboBox3.ItemIndex = 0 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.m3u', TEncoding.ASCII);
          if ComboBox3.ItemIndex = 1 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.m3u', TEncoding.UTF8);
          if ComboBox3.ItemIndex = 2 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.m3u', TEncoding.Unicode);
          if ComboBox3.ItemIndex = 3 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.m3u', TEncoding.BigEndianUnicode);
          if ComboBox3.ItemIndex = 4 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.m3u', TEncoding.ANSI);
          end;

      if (ComboBox1.ItemIndex = 4) then
         begin
          if ComboBox3.ItemIndex = 0 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.m3u8', TEncoding.ASCII);
          if ComboBox3.ItemIndex = 1 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.m3u8', TEncoding.UTF8);
          if ComboBox3.ItemIndex = 2 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.m3u8', TEncoding.Unicode);
          if ComboBox3.ItemIndex = 3 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.m3u8', TEncoding.BigEndianUnicode);
          if ComboBox3.ItemIndex = 4 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.m3u8', TEncoding.ANSI);
          end;

      if (ComboBox1.ItemIndex = 5) then
         begin
          if ComboBox3.ItemIndex = 0 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.m3a', TEncoding.ASCII);
          if ComboBox3.ItemIndex = 1 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.m3a', TEncoding.UTF8);
          if ComboBox3.ItemIndex = 2 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.m3a', TEncoding.Unicode);
          if ComboBox3.ItemIndex = 3 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.m3a', TEncoding.BigEndianUnicode);
          if ComboBox3.ItemIndex = 4 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.m3a', TEncoding.ANSI);
          end;

      if (ComboBox1.ItemIndex = 6) or (ComboBox1.ItemIndex = 7) or
         (ComboBox1.ItemIndex = 8) then
         begin
          if ComboBox3.ItemIndex = 0 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.pls', TEncoding.ASCII);
          if ComboBox3.ItemIndex = 1 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.pls', TEncoding.UTF8);
          if ComboBox3.ItemIndex = 2 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.pls', TEncoding.Unicode);
          if ComboBox3.ItemIndex = 3 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.pls', TEncoding.BigEndianUnicode);
          if ComboBox3.ItemIndex = 4 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.pls', TEncoding.ANSI);
          end;

      if (ComboBox1.ItemIndex = 9) or (ComboBox1.ItemIndex = 10) then
         begin
          if ComboBox3.ItemIndex = 0 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.xspf', TEncoding.ASCII);
          if ComboBox3.ItemIndex = 1 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.xspf', TEncoding.UTF8);
          if ComboBox3.ItemIndex = 2 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.xspf', TEncoding.Unicode);
          if ComboBox3.ItemIndex = 3 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.xspf', TEncoding.BigEndianUnicode);
          if ComboBox3.ItemIndex = 4 then Listbox1.Items.SaveToFile(SaveDialog1.FileName + '.xspf', TEncoding.ANSI);
          end;

    end;

  StatusBar1.Panels[5].Text := 'Playlist ' + ComboBox1.Text + ' created.';
  end;
  Screen.Cursor := crDefault;
  StatusBar1.SetFocus;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  s, b: string;
  Line: string;
  a : widestring;
  F: TextFile;
begin
  if (ComboBox1.ItemIndex = 3) or (ComboBox1.ItemIndex = 4) or
     (ComboBox1.ItemIndex = 7) or (ComboBox1.ItemIndex = 8) or
     (ComboBox1.ItemIndex = 10) then begin
    if OpenDialog1.Execute  then begin
    CheckListBox1.Clear;
    Edit1.text := ExtractFileDir(OpenDialog1.FileName);

    AssignFile(F, OpenDialog1.FileName);
    Reset(F);
    try
      while not Eof(F) do
      begin
        ReadLn(F, Line);
        CheckListBox1.Items.Add(Line);
      end;
    finally
      CloseFile(F);
    end;

    CheckBox1.OnClick(sender);
    StatusBar1.Panels[1].Text := IntToStr(CheckListBox1.Items.Count);
    Exit;
    end;
  end;

  if (ComboBox1.ItemIndex = 0) or(ComboBox1.ItemIndex = 1) or (ComboBox1.ItemIndex = 2) or
     (ComboBox1.ItemIndex = 5) or (ComboBox1.ItemIndex = 6) or (ComboBox1.ItemIndex = 9)
     then begin
    if SelectDirectory(S,A, B) then  begin
      CheckListBox1.Clear;
      Edit1.text := B;
      Refreshlist;
      CheckBox1.OnClick(sender);
      StatusBar1.Panels[1].Text := IntToStr(CheckListBox1.Items.Count);
    end;
  end;

  StatusBar1.SetFocus;
end;


procedure TForm1.Checkall1Click(Sender: TObject);
begin
  CheckBox1.Checked := not CheckBox1.Checked;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
var
  i,o: integer;
begin
  i := 0;
  o := 0;
  if Checkbox1.Checked = true then begin
  for I := 0 to checklistbox1.Count-1 do
          if Checklistbox1.Checked[I] = false then
          Checklistbox1.Checked[I] := true;
          Checkall1.Checked := true;
  end;

  if Checkbox1.Checked = false then begin
  for O := 0 to checklistbox1.Count-1 do
          if checklistbox1.Checked[O] = true then
          Checklistbox1.Checked[O] := false;
          Checkall1.Checked := false;
  end;

  CheckListBox1.Invalidate;
  StatusBar1.Panels[3].Text := IntToStr(  GetCheckedCount(CheckListBox1));
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked = true then begin
  SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end else begin
  SetWindowPos(Handle, HWND_NOTOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CheckListBox1.Multiselect := True;
  ComboBox1.ItemIndex := 0;
  ComboBox2.ItemIndex := 0;
  ComboBox3.ItemIndex := 0;
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  Button2.Click;
end;

procedure TForm1.Panel3Click(Sender: TObject);
begin
  Panel1.Visible := Panel3.Checked;
end;

procedure TForm1.Paste1Click(Sender: TObject);
var
  Lines: TStringList;
  i: Integer;
begin
  if Clipboard.HasFormat(CF_TEXT) then
  begin
    Lines := TStringList.Create;
    try
      Lines.Text := Clipboard.AsText;
      for i := 0 to Lines.Count - 1 do
      begin
        CheckListBox1.Items.Add(Lines[i]);
      end;
    finally
      Lines.Free;
    end;
  end
  else
  begin
    ShowMessage('Clipboard does not contain text.');
  end;
end;

procedure TForm1.Reload1Click(Sender: TObject);
var
  Line: string;
  F: TextFile;
begin
  CheckListBox1.Clear;

  if (ComboBox1.ItemIndex = 3) or (ComboBox1.ItemIndex = 4) or
     (ComboBox1.ItemIndex = 7)  then begin
    //if OpenDialog1.Execute  then begin
    CheckListBox1.Clear;
    //Edit1.text := ExtractFileDir(OpenDialog1.FileName);

    AssignFile(F, OpenDialog1.FileName);
    Reset(F);
    try
      while not Eof(F) do
      begin
        ReadLn(F, Line);
        CheckListBox1.Items.Add(Line);
      end;
    finally
      CloseFile(F);
    end;

    CheckBox1.OnClick(sender);
    StatusBar1.Panels[1].Text := IntToStr(CheckListBox1.Items.Count);
    Exit;
    end;

  try
    Refreshlist;
  finally
    StatusBar1.Panels[1].Text := IntToStr(CheckListBox1.Items.Count);
    StatusBar1.Panels[3].Text := IntToStr(GetCheckedCount(CheckListBox1));
    StatusBar1.SetFocus;
  end;
end;

procedure TForm1.Remove1Click(Sender: TObject);
var
  i : integer;
begin
  i := 0;
  CheckListBox1.Items.BeginUpdate;
  try
    for i := CheckListBox1.Items.Count -1 downto 0 do
    begin
      if CheckListBox1.Selected[i]  then CheckListBox1.DeleteSelected;
    end;
  except
  end;

  CheckListBox1.Items.EndUpdate;
  StatusBar1.Panels[1].Text := IntToStr(CheckListBox1.Items.Count);
  StatusBar1.Panels[3].Text := IntToStr(GetCheckedCount(CheckListBox1));
end;

procedure TForm1.CheckListBox1Click(Sender: TObject);
begin
  StatusBar1.Panels[3].Text := IntToStr(GetCheckedCount(CheckListBox1));
  CheckBox1.Invalidate;
end;

procedure TForm1.Clear1Click(Sender: TObject);
begin
  CheckListBox1.Clear;
  StatusBar1.Panels[1].Text := IntToStr(CheckListBox1.Items.Count);
  StatusBar1.Panels[3].Text := IntToStr(GetCheckedCount(CheckListBox1));
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  CheckListBox1.Clear;
  case ComboBox1.ItemIndex of
  2 : begin
      Edit2.Text := '\\ftp-server\';
      Label4.Enabled := true;
      Edit2.Enabled := true;
      ComboBox3.ItemIndex := 0;
      end;

  3 : begin
      Edit2.Text := 'https://www.radio.at/country/usa';
      Label4.Enabled := true;
      Edit2.Enabled := true;
      ComboBox3.ItemIndex := 0;
      end;

  7 : begin
      Edit2.Text := 'https://example.com/song.mp3';
      Label4.Enabled := true;
      Edit2.Enabled := true;
      ComboBox3.ItemIndex := 0;
      end;

  8 : begin
      Edit2.Text := 'https://example.com/song.mp3';
      Label4.Enabled := true;
      Edit2.Enabled := true;
      Label13.Enabled := true;
      Edit8.Enabled := true;
      ComboBox3.ItemIndex := 0;
      end;

  9 : begin
      Label4.Enabled := true;
      Edit2.Enabled := false;
      Label13.Enabled := false;
      Edit8.Enabled := false;
      ComboBox3.ItemIndex := 0;
      end;

  10 :begin
      Label4.Enabled := true;
      Edit2.Enabled := false;
      Label13.Enabled := false;
      Edit8.Enabled := false;
      ComboBox3.ItemIndex := 0;
      end;

  else
    Label4.Enabled := false;
    Edit2.Enabled := false;
    Label13.Enabled := false;
    Edit8.Enabled := false;
    Edit2.Clear;
  end;
  StatusBar1.SetFocus;
end;

procedure TForm1.Create1Click(Sender: TObject);
begin
  Button1.Click;
end;

procedure TForm1.Edit8KeyPress(Sender: TObject; var Key: Char);
begin
  if NOT (Key in [#08, '0'..'9']) then
    Key := #0;
end;

procedure TForm1.Font1Click(Sender: TObject);
begin
  if FontDialog1.Execute then begin
  CheckListBox1.Font := FontDialog1.Font;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.free;
end;

end.
