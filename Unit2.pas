unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    ComboBox1: TComboBox;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    odlg1: TOpenDialog;
    sdlg1: TSaveDialog;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox1DropDown(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

procedure combox( combo: tComboBox );

implementation

uses unit1;

{$R *.dfm}

procedure TForm2.Button3Click(Sender: TObject);
begin
  sdlg1.initialdir := progdir;
  if sdlg1.execute then begin
    memo1.clear;
    combobox1.items.add( extractfilename( sdlg1.filename ) );
    combobox1.itemindex := combobox1.items.count - 1;
    sdlg1.filename := '';
  end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
 if odlg1.execute then begin
   memo1.lines.loadfromfile( odlg1.filename );
   combobox1.text := odlg1.filename;
   odlg1.filename := '';
 end;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  memo1.lines.savetofile( progdir + combobox1.text );
end;

procedure TForm2.ComboBox1Click(Sender: TObject);
begin
  if fileexists( progdir + combobox1.text ) then
  memo1.lines.loadfromfile( progdir + combobox1.text )
  else memo1.clear;
//  else messagedlg( 'File not exists!', mtError, [mbOk], 0 );
end;

procedure combox( combo: tComboBox );
var

  wfd: tWin32FindData;
  fh: longint;
  s: string;

begin
  combo.items.clear;
  s := progdir;
  fh := findfirstfile( pchar( s + '\*.txt' ), wfd );
  repeat
    if fh > 0 then begin
      s := wfd.cFileName;
      combo.items.add( s );
      combo.text := s;
    end;
  until not findnextfile( fh, wfd );
end;

procedure TForm2.ComboBox1DropDown(Sender: TObject);
begin
 combox( combobox1 );
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  sdlg1.initialdir := progdir;
  if sdlg1.execute then begin
    memo1.lines.savetofile( sdlg1.filename );
    combobox1.items.add( sdlg1.filename );
    sdlg1.filename := '';
  end;
end;

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_ESCAPE then close;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  if messagedlg( 'Biztos?', mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then begin
    deletefile( progdir + combobox1.text );
    ComboBox1DropDown( sender );
    memo1.clear;
  end;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  loadparams( form2 );
  ComboBox1Click( sender );
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if memo1.modified then
  case messagedlg( 'Megváltozott, mentsem?', mtConfirmation, [mbYes, mbNo, mbCancel], 0 ) of
    mrNo: begin
            saveparams( form2 );
            form1.ComboBox1DropDown( Sender );
          end;
    mrYes:  memo1.lines.savetofile( progdir + combobox1.text );
  else
    action := caNone;
  end;
end;

procedure TForm2.FormResize(Sender: TObject);
begin
  button1.left := form2.width  - 88;
  button2.left := form2.width  - 88;
  button3.left := form2.width  - 88;
  button4.left := form2.width  - 88;
  button5.left := form2.width  - 88;
  button6.left := form2.width  - 88;
  button6.top  := form2.height - 56;
  memo1.width  := form2.width  - 99;
  memo1.height := form2.height - 66
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
  close;
end;

end.
