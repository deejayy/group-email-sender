unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Inifiles;

type
  TForm3 = class(TForm)
    Label1      : TLabel;
    Edit1       : TEdit;
    Edit2       : TEdit;
    Edit3       : TEdit;
    Edit4       : TEdit;
    Edit5       : TEdit;
    Label2      : TLabel;
    Label3      : TLabel;
    Label4      : TLabel;
    Button1: TButton;
    procedure     FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure     FormShow(Sender: TObject);
    procedure     FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3         : TForm3;

implementation

uses unit1;

{$R *.dfm}

procedure TForm3.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_ESCAPE then close;
end;

procedure loadfromini;
var

  ini           : tinifile;
  s             : string;

begin
  s := extractfilename( paramstr( 0 ) );
  s := extractfilepath( paramstr( 0 ) ) + copy( s, 1, pos( '.', s ) ) + 'ini';
  ini := tinifile.create( s );
  form3.edit1.text := ini.readstring( 'mail', 'smtp',    ''   );
  form3.edit2.text := ini.readstring( 'mail', 'port',    '25' );
  form3.edit3.text := ini.readstring( 'mail', 'company', ''   );
  form3.edit4.text := ini.readstring( 'mail', 'name',    ''   );
  form3.edit5.text := ini.readstring( 'mail', 'email',   ''   );
  ini.Destroy;
end;

procedure savetoini;
var

  ini           : tinifile;
  s             : string;

begin
  s := extractfilename( paramstr( 0 ) );
  s := extractfilepath( paramstr( 0 ) ) + copy( s, 1, pos( '.', s ) ) + 'ini';
  ini := tinifile.create( s );
  ini.writestring( 'mail', 'smtp',    form3.edit1.text );
  ini.writestring( 'mail', 'port',    form3.edit2.text );
  ini.writestring( 'mail', 'company', form3.edit3.text );
  ini.writestring( 'mail', 'name',    form3.edit4.text );
  ini.writestring( 'mail', 'email',   form3.edit5.text );
  ini.Destroy;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  loadfromini;
  loadparams( form3 );
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  savetoini;
  saveparams( form3 );
end;

procedure TForm3.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then close;
end;

procedure TForm3.FormResize(Sender: TObject);
begin
  edit1.width  := form3.width - 200;
  edit3.width  := form3.width - 200;
  edit4.width  := form3.width - 200;
  edit5.width  := form3.width - 200;
  edit2.left   := form3.width - 106;
  button1.left := form3.width - 100;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  loadfromini;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  close;
end;

end.
