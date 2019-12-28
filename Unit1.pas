unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, IniFiles, SakSMTP, SakMsg, ComCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Elkld1: TMenuItem;
    Listk1: TMenuItem;
    ComboBox1: TComboBox;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Memo2: TMemo;
    odlg1: TOpenDialog;
    sdlg1: TSaveDialog;
    smtp: TSakSMTP;
    msgx: TSakMsg;
    Edit1: TEdit;
    Label1: TLabel;
    sb: TStatusBar;
    Segtsg1: TMenuItem;
    procedure Elkld1Click(Sender: TObject);
    procedure Listk1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox1DropDown(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure smtpError(Sender: TObject; Error: Integer; Msg: String);
    procedure Segtsg1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  progdir: string;

procedure saveparams( form: tForm );
procedure loadparams( form: tForm );

implementation

uses Unit2, Unit3, Unit4;

{$R *.dfm}

procedure saveparams( form: tForm );
var

  ini           : tinifile;
  s             : string;

begin
  s := extractfilename( paramstr( 0 ) );
  s := progdir + copy( s, 1, pos( '.', s ) ) + 'ini';
  ini := tinifile.create( s );
  ini.writeinteger( form.name, 'width',  form.width );
  ini.writeinteger( form.name, 'height', form.height );
  ini.writeinteger( form.name, 'top',    form.top );
  ini.writeinteger( form.name, 'left',   form.left );
  ini.Destroy;
end;

procedure loadparams( form: tForm );
var

  ini           : tinifile;
  s             : string;

begin
  s := extractfilename( paramstr( 0 ) );
  s := progdir + copy( s, 1, pos( '.', s ) ) + 'ini';
  ini := tinifile.create( s );
  form.width  := ini.readinteger( form.name, 'width',  form.width );
  form.height := ini.readinteger( form.name, 'height', form.height );
  form.top    := ini.readinteger( form.name, 'top',    form.top );
  form.left   := ini.readinteger( form.name, 'left',   form.left );
  ini.Destroy;
end;

procedure TForm1.Elkld1Click(Sender: TObject);
begin
  form3.showmodal;
end;

procedure TForm1.Listk1Click(Sender: TObject);
begin
  form2.showmodal;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if odlg1.execute then
    memo1.lines.loadfromfile( odlg1.filename );
  odlg1.filename := '';
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if odlg1.execute then
    memo2.lines.add( odlg1.filename );
  odlg1.filename := '';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if sdlg1.execute then
    memo1.lines.savetofile( sdlg1.filename );
  sdlg1.filename := '';
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  memo2.clear;
end;

procedure TForm1.ComboBox1DropDown(Sender: TObject);
begin
  combox( combobox1 );
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_ESCAPE then close;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if messagedlg( 'Tényleg?', mtConfirmation, [mbYes, mbNo], 0 ) <> mrYes then Action := caNone;
  saveparams( form1 );
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  loadparams( form1 );
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  memo1.width  := form1.width  - 110;
  memo1.height := form1.height - 230;
  memo2.width  := form1.width  - 290;
  button1.left := form1.width  -  90;
  button2.left := form1.width  -  90;
  button3.left := form1.width  - 280;
  button4.left := form1.width  - 280;
  button5.left := form1.width  - 180;

  memo2.top    := form1.height - 160;
  button3.top  := form1.height - 150;
  button4.top  := form1.height - 110;
  button5.top  := form1.height - 150;
end;

procedure TForm1.Button5Click(Sender: TObject);
var

  e             : integer;
  s             : string;

  f             : textfile;

begin
  if combobox1.text = '' then exit;
  assignfile( f, progdir + combobox1.text );
  reset( f );

  with msgx do begin
    date := datetimetostr( now );
    contenttype := 'text/plain';
    sender := form3.edit4.text;
    xmailer := 'Mailsender by DeeJayy';
    replyto := form3.edit5.text;
    subject := edit1.text;
    extraheaders.add( 'X-Company: ' + form3.edit3.text );
    from := form3.edit4.text + ' <' + form3.edit5.text + '>';
    text.addstrings( memo1.lines );
    attachedfiles.clear;
    for e := 0 to memo2.lines.count - 1 do
      if fileexists( memo2.lines.strings[e] ) then
        attachedfiles.add( memo2.lines.strings[e] );
  end;

  with smtp do begin
    host := form3.edit1.text;
    port := form3.edit2.text;
  end;

  button5.enabled := false;
  repeat
    readln( f, s );
    msgx.sendto := s;
    with smtp do begin
      sb.panels[0].text := 'connecting to ' + host;
      connect;
      if not smtperror then begin
        sb.panels[0].text := 'sending mail to ' + s;
        sendthemessage( msgx );
        sb.panels[0].text := 'disconnecting';
        disconnect;
      end
      else begin
        messagedlg( 'Nem lehet kapcsolódni a megadott SMTP szerverhez', mtError, [mbOk], 0 );
        break;
      end;
    end;
  until eof( f );
  button5.enabled := true;

  sb.panels[0].text := 'ready';
  closefile( f );
end;

procedure TForm1.smtpError(Sender: TObject; Error: Integer; Msg: String);
begin
  smtp.Disconnect;
  messagedlg( msg + inttostr( error ), mtError, [mbOk], 0 );
end;

procedure TForm1.Segtsg1Click(Sender: TObject);
begin
  form4.showmodal;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  progdir := extractfilepath( paramstr( 0 ) );
end;

end.
