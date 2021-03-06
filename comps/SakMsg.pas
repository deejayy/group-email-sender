//===============================================================
//
//       SakMsg unit, part of SakEmail
//
//       Contains: TSakMsg, TSakMsgList
//
//---------------------------------------------------------------
//
//      Copyrigth (c) 1997, 1998, 1999, 2000 Sergio A. Kessler
//      and authors cited
//      http://sak.org.ar
//
//===============================================================


unit SakMsg;

interface

uses sysutils, Classes, SakAttFile, sak_util;

type

  TSakMsg = class;

  // Priority
  TPriority = (prHighest, prHigh, prNormal, prLow, prLowest);
  TTextEncoding = (te8Bit, teBase64);

// ---------------- SakMsg ----------------

  TSakMsg = class(TComponent)
  private
    { Private declarations }
    FPriority: TPriority;
    FUserName: string;
    FFrom: string;
    FSender: String;
    FMessageId: string;
    FInReplyTo: string;
    FReturnPath: string;
    FReplyTo: string;
    FSendTo: string;
    FCC: string;
    FBCC: string;
    FDate: string;
    FSubject: string;
    FText: TStringList;
    FExtraHeaders: TStringList;
    FAttachedFiles: TAttachedFiles;
    FContentType: string;
    FContentTransferEncoding: string;
    FHeaders: TStringList;
    FCharSet: string;
    FSizeInBytes: integer;
    FUIDL: string;
    FRawMail: TStringList;
    FClearRawMailAfterParse: boolean;
    FTextEncoding: TTextEncoding;
    FXMailer: string;
//    FDecodeProgress: word;
//    FDecodeProgressStep: word;

//    FOnDecodeStart: TOnCodeStartEvent;
//    FOnDecodeProgress: TOnCodeProgressEvent;
//    FOnDecodeEnd: TNotifyEvent;

    procedure SetText( Value: TStringList); {asem}
    procedure SetExtraHeaders( Value: TStringList); {Craig}
    procedure SetHeaders( Value: TStringList); {Craig}
    procedure SetRawMail( Value: TStringList);
    procedure GetBasicHeaders;
    procedure GetSubHeaders( const aPart: TStringList;
                             var ContentType: string;
                             var CTEncoding: string;
                             var FileName: string);
    procedure ProcessAttach( var aPart: TStringList;
                             const ContentType: string;
                             const CTEncoding: string;
                             FileName: string);
    procedure ExtractParts( var Partes: TList; PartText: string);
    function  FindUUAttachs( const strList: TStringList;
                             var line: integer;
                             var FileName: string): boolean;
//    procedure FDoDecodeStart( FileName: string; BytesCount: longint);
//    procedure FDoDecodeProgress( Percent: word);
//    procedure FDoDecodeEnd;
    procedure ParseMsg2( var StrListMsg: TStringList);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create( AOwner: TComponent); override;
    destructor Destroy; override;
{    procedure SaveToFile( fn: string);
    procedure LoadFromFile( fn: string);}
    procedure ParseMsg;
    property AttachedFiles: TAttachedFiles read FAttachedFiles write FAttachedFiles;
    property Date: string read FDate write FDate;
    property MessageId: string read FMessageId write FMessageId;
    property InReplyTo: string read FInReplyTo write FInReplyTo;
    property ReturnPath: string read FReturnPath write FReturnPath;
    property ContentType: string read FContentType write FContentType; // Added by Kaufman Alex
    property ContentTransferEncoding: string read FContentTransferEncoding
                                             write FContentTransferEncoding;
    property Headers: TStringList read FHeaders write SetHeaders;    // Added by Kaufman Alex
    Property Sender: String read FSender write FSender;
    property SizeInBytes: integer read FSizeInBytes write FSizeInBytes;
    property UIDL: string read FUIDL write FUIDL;
    property RawMail: TStringList read FRawMail write SetRawMail;
  published
    { Published declarations }
    property UserName: string read FUserName write FUserName;
    property From: string read FFrom write FFrom;
    property ReplyTo: string read FReplyTo write FReplyTo;
    property SendTo: string read FSendTo write FSendTo;
    property CC: string read FCC write FCC;
    property BCC: string read FBCC write FBCC;
    property Subject: string read FSubject write FSubject;
    property Text: TStringList read FText write SetText;
    property ExtraHeaders: TStringList read FExtraHeaders write SetExtraHeaders;
    property Priority: TPriority read FPriority write FPriority default prNormal;
    property CharSet: string read FCharSet write FCharSet;
    property ClearRawMailAfterParse: boolean read FClearRawMailAfterParse write FClearRawMailAfterParse default True;
    property TextEncoding: TTextEncoding read FTextEncoding write FTextEncoding default te8Bit;
    property XMailer: string read FXMailer write FXMailer;
    procedure FillRawMail;
//    property DecodeProgressStep: word read FDecodeProgressStep write FDecodeProgressStep;
//    property OnDecodeStart: TOnCodeStartEvent read FOnDecodeStart write FOnDecodeStart;
//    property OnDecodeProgress: TOnCodeProgressEvent read FOnDecodeProgress write FOnDecodeProgress;
//    property OnDecodeEnd: TNotifyEvent read FOnDecodeEnd write FOnDecodeEnd;
  end;


// ---------------- SakMsgList ----------------

  TSakMsgList = class(TComponent)
  private
    { Private declarations }
    Flist: TList;
    function GetCount: integer;
  protected
    { Protected declarations }
    function  Get(Index: Integer): TsakMsg;
    procedure Put(Index: Integer; Item: TsakMsg);
  public
    { Public declarations }
    constructor Create( AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    function  Add(Item: TSakMsg): Integer;
    procedure Delete(Index: Integer);
    function  First: TSakMsg;
    function  IndexOf(Item: TSakMsg): Integer;
    procedure Insert(Index: Integer; Item: TSakMsg);
    function  Last: TSakMsg;
    function  Remove(Item: TSakMsg): Integer;
    property  Items[ index: integer]: TSakMsg read Get write Put; default;
    property  Count: integer read GetCount;
  end;


implementation

uses SakMIME, Forms;

const
  crlf = #13#10;



// ***************** TSakMsg *****************

constructor TSakMsg.Create( AOwner: TComponent);
begin
  inherited create( AOwner);
  FAttachedFiles := TAttachedFiles.create;
  FText := TStringList.create;
  FExtraHeaders := TStringList.create;
  FHeaders := TStringList.create;
  FPriority := prNormal;
  FCharSet := 'ISO-8859-1';  // you can change this
//  FDecodeProgressStep := 10;
  FRawMail := TStringList.create;
  ClearRawMailAfterParse := true;
  SizeInBytes := 0;
end;

destructor TSakMsg.Destroy;
begin
  FRawMail.Free;
  FAttachedFiles.Clear;
  FAttachedFiles.free;
  FText.Clear;
  FText.Free;
  FExtraHeaders.Clear;
  FExtraHeaders.Free;
  FHeaders.Clear;
  FHeaders.Free;
  inherited destroy;
end;

{procedure TSakMsg.SaveToFile( fn: string);
--> commented out, as is not saving attachs and many things ...
begin
  with TFileStream.Create( fn, fmCreate) do
  try
    WriteComponent (Self);
  finally
    Free;
  end;
end;}

{procedure TSakMsg.LoadFromFile( fn: string);
--> commented out, as saving is not working like I expect ...
begin
  with TFileStream.Create( fn, fmOpenRead) do
  try
    ReadComponent (Self);
  finally
    Free;
  end;
end;}

procedure TSakMsg.SetText(Value: TStringList);
begin
  FText.Assign(Value);
end;

procedure TSakMsg.SetExtraHeaders(Value: TStringList);
begin
  FExtraHeaders.Assign(Value);
end;

procedure TSakMsg.SetHeaders(Value: TStringList);
begin
  FHeaders.Assign(Value);
end;

procedure TSakMsg.SetRawMail(Value: TStringList);
begin
  FRawMail.Assign(Value);
  ParseMsg;
end;

procedure TSakMsg.ParseMsg;
var
  i: integer;
  StrListMsg: TStringList;
begin
  if (FRawMail = nil) or (FRawMail.Count = 0) then
  begin
    exit;
  end;
  i := 0;
  while (i < FRawMail.Count) and (FRawMail[ i] <> '') do
  begin
    Headers.Add( FRawMail[ i]);
    inc( i);
  end;
  GetBasicHeaders;
//  SizeInBytes := FRawMail.???;
  StrListMsg := TStringList.Create;
  StrListMsg.Assign( FRawMail);
  try
     ParseMsg2( StrListMsg);
   finally
     StrListMsg.Free;
  end;
  if ClearRawMailAfterParse then
  begin
    FRawMail.Clear;
  end;
end;

procedure TSakMsg.ParseMsg2( var StrListMsg: TStringList);
const
  EOM = crlf+'.'+crlf;
var
  p, line: integer;
  ContentType, CTEncoding, FileName: string;
  aPart: TStringList;
  Partes: TList;
  b64Decode: TBase64DecodingStream;
  Dest: TMemoryStream;
begin
  GetSubHeaders( StrListMsg, ContentType, CTEncoding, FileName);

  // a normal email message, maybe with a uucoded attach
  if (pos( 'TEXT', ContentType) > 0) then
  begin
    sak_DeleteHeaders( StrListMsg);

    // if there is a filename then it is an attachment, even in Text/*
    if (FileName <> '') or (ContentType = 'TEXT/HTML') then
    begin
      ProcessAttach( StrListMsg, ContentType, CTEncoding, FileName);
      exit;
    end;

    // search for UUcoded files
    while FindUUAttachs( StrListMsg, line, FileName) do
    begin
       aPart := TStringList.create;
       while lowercase( trim( StrListMsg[ line])) <> 'end' do
       begin
          if StrListMsg[ line] <> '' then aPart.Add( StrListMsg[ line]);
          StrListMsg.Delete( line);
       end;
       ContentType := 'APPLICATION/OCTET-STREAM'; CTEncoding := 'X-UUENCODE';
       ProcessAttach( aPart, ContentType, CTEncoding, FileName);
       aPart.Free;
    end;

    if CTEncoding = 'QUOTED-PRINTABLE' then
    begin
      StrListMsg.Text := sak_QuotedPrintableDecode( PChar( StrListMsg.Text));
    end else
    begin
      if CTEncoding = 'BASE64' then
      begin
        Dest := TMemoryStream.Create;

        b64Decode := TBase64DecodingStream.Create( Dest);
        b64Decode.Write( pointer(StrListMsg.Text)^, length( StrListMsg.Text));
        b64Decode.Free;

        Dest.Position := 0;
        StrListMsg.Clear;
        StrListMsg.LoadFromStream( Dest);
        Dest.Free;
      end;
    end;
    Text.AddStrings( StrListMsg);
    exit;
  end;

  // a multipart email, very commom this days thanks to the fu* emailers
  // that send html
  if (pos( 'MULTIPART', ContentType) > 0) then
  begin
    Partes := TList.create;
    ExtractParts( Partes, StrListMsg.Text);

    for p := 0 to Partes.count-1 do
    begin
      aPart := TStringList( Partes[ p]);
      ParseMsg2( aPart);
      aPart.Free; // this is releasing the list putting Nils
    end;
    Partes.Free;
    exit;
  end;

  // an attached part
  if (CTEncoding = 'X-UUENCODE') or
     (FileName <> '') then
  begin
    sak_DeleteHeaders( StrListMsg);
    ProcessAttach( StrListMsg, ContentType, CTEncoding, FileName);
    exit;
  end;

  // a encapsulated email
  if ContentType = 'MESSAGE/RFC822' then
  begin
    sak_DeleteHeaders( StrListMsg);
    ParseMsg2( StrListMsg);
    exit;
  end;

  // this is a msg whitout any text, just an attached file
  // codified in base64, quoted-printable or uucode, somewhat rare
  if (CTEncoding = 'BASE64') or
    (CTEncoding = 'QUOTED-PRINTABLE') or
    (CTEncoding = 'X-UUENCODE') then
  begin
    sak_DeleteHeaders( StrListMsg);
    ProcessAttach( strListMsg, ContentType, CTEncoding, FileName);
    exit;
  end;

  // Otherwise, hmmm, what is going on here ?...
  sak_DeleteHeaders( StrListMsg);
  Text.AddStrings( StrListMsg);
end;

procedure TSakMsg.GetSubHeaders( const aPart: TStringList;
                                 var ContentType: string;
                                 var CTEncoding: string;
                                 var FileName: string);
var
  i: integer;
  line: string;
begin
  if sak_FindFieldInHeaders( 'CONTENT-TYPE:', aPart, line) then
  begin
    ContentType := UpperCase( sak_GetFieldValueFromLine( 'CONTENT-TYPE:', line));
    FileName := sak_GetFieldValueFromLine( 'NAME', line);
  end else
  begin
    ContentType := 'TEXT/PLAIN';
  end;

  if sak_FindFieldInHeaders( 'CONTENT-TRANSFER-ENCODING:', aPart, line) then
  begin
    CTEncoding := UpperCase( sak_GetFieldValueFromLine( 'CONTENT-TRANSFER-ENCODING:', line));
  end else
  begin
    CTEncoding := '7BIT';
  end;

  if FileName = '' then
  begin
    if sak_FindFieldInHeaders( 'CONTENT-DISPOSITION:', aPart, line) then
    begin
      FileName := sak_GetFieldValueFromLine( 'FILENAME', line);
    end else
    begin
      FileName := '';
    end;
  end;

  if FileName <> '' then
  begin
    delete( FileName, 1, 1); // remove the =
    i := pos( ';', FileName);
    if i > 0 then
    begin
      FileName := trim( copy( FileName, 1, i-1));
    end;
    FileName := sak_ConvertCharSet( sak_UnQuote( FileName));
  end;
  FileName := trim(FileName);
end;

procedure TSakMsg.ExtractParts( var Partes: TList; PartText: string);
var
  found: boolean;
  boundary, endOfMsg, s: string;
  aPart, subPart: TStringList;
  line: integer;
begin
  aPart := TStringList.create;
  aPart.Text := PartText;

  found := sak_FindFieldInHeaders( 'CONTENT-TYPE:', aPart, s);

  if (not found) or (pos( 'MULTIPART', UpperCase( s)) = 0) then
  begin
    Partes.add( aPart);
    exit;
  end;

  // I know is multipart so ...
  sak_DeleteHeaders( aPart);

  boundary := sak_GetBoundaryOutOfLine( s);
  endOfMsg := boundary + '--';

  // delete all until the boundary
  while (aPart.Count > 0) and (aPart[0] <> boundary) do
  begin
    aPart.Delete( 0);
  end;

  subPart := TStringList.create;
  line := 1;   // line 0 is the boundary
  while (line < aPart.Count) and (aPart[ line] <> endOfMsg) do
  begin
    if aPart[ line] = boundary then
    begin
      // go recursive ...
      ExtractParts( Partes, subPart.Text);
      subPart.Clear;
      inc( line);
    end;
    subPart.add( aPart[ line]);
    inc( line);
  end;
  // this add the last part that is not added in the while loop
  ExtractParts( Partes, subPart.Text);
  SubPart.Free;
  aPart.Free;
end;

procedure TSakMsg.GetBasicHeaders;
var
  lines: string;
begin
  if Headers.Count = 0 then
    exit;

  From := copy( Headers.Strings[0], length( 'From ') + 1, 72);

  if sak_FindFieldInHeaders( 'FROM:', Headers, lines) then
    From := sak_ConvertCharSet( sak_GetFieldValueFromLine( 'FROM:', lines));

  if sak_FindFieldInHeaders( 'SENDER:', Headers, lines) then
    Sender := sak_FormatAddress( sak_GetFieldValueFromLine( 'SENDER:', lines));

  if sak_FindFieldInHeaders( 'MESSAGE-ID:', Headers, lines) then
    MessageId := sak_GetFieldValueFromLine( 'MESSAGE-ID:', lines);

  if sak_FindFieldInHeaders( 'IN-REPLY-TO:', Headers, lines) then
    InReplyTo := sak_GetFieldValueFromLine( 'IN-REPLY-TO:', lines);

  if sak_FindFieldInHeaders( 'RETURN-PATH:', Headers, lines) then
    ReturnPath := sak_GetFieldValueFromLine( 'RETURN-PATH:', lines);

  if sak_FindFieldInHeaders( 'REPLY-TO:', Headers, lines) then
    ReplyTo := sak_FormatAddress( sak_GetFieldValueFromLine( 'REPLY-TO:', lines));

  if sak_FindFieldInHeaders( 'TO:', Headers, lines) then
    SendTo := sak_FormatAddress( sak_GetFieldValueFromLine( 'TO:', lines));

  if sak_FindFieldInHeaders( 'CC:', Headers, lines)  then
    CC := sak_FormatAddress( sak_GetFieldValueFromLine( 'CC:', lines));

  if sak_FindFieldInHeaders( 'DATE:', Headers, lines)  then
    Date := sak_GetFieldValueFromLine( 'DATE:', lines);

  if sak_FindFieldInHeaders( 'SUBJECT:', Headers, lines) then
    Subject := sak_ConvertCharSet( sak_GetFieldValueFromLine( 'SUBJECT:', lines));

  if sak_FindFieldInHeaders( 'CONTENT-TYPE:', Headers, lines) then
  begin
    ContentType := UpperCase( sak_GetFieldValueFromLine( 'CONTENT-TYPE:', lines));
  end else
  begin
    ContentType := 'TEXT/PLAIN';
  end;

  if sak_FindFieldInHeaders( 'CONTENT-TRANSFER-ENCODING:', Headers, lines) then
  begin
    ContentTransferEncoding := UpperCase( sak_GetFieldValueFromLine( 'CONTENT-TRANSFER-ENCODING:', lines));
  end else
  begin
    ContentTransferEncoding := '7BIT';
  end;
end;

procedure TSakMsg.ProcessAttach( var aPart: TStringList;
                                 const ContentType: string;
                                 const CTEncoding: string;
                                 FileName: string);
const
  NoValidChars = '\/:*?"<>|';
var
  i: integer;
  AttFile: TAttachedFile;
begin
  if (FileName = '') then
  begin
    FileName := Subject;
    if (ContentType = 'TEXT/HTML') then
      FileName := ChangeFileExt( FileName, '.html')
    else
    if (ContentType = 'IMAGE/JPEG') then
      FileName := ChangeFileExt( FileName, '.jpeg')
    else
    if (ContentType = 'IMAGE/GIF') then
      FileName := ChangeFileExt( FileName, '.gif');
  end;

  for i := 1 to length(NoValidChars) do
  begin
    FileName := sak_DelFromStr( FileName, NoValidChars[i]);
  end;

  AttFile := AttachedFiles.Add( FileName);

  if CTEncoding ='BASE64' then
  begin
    AttFile.BodyEncoded.Assign( aPart);
    AttFile.Base64Decode;
    AttFile.BodyEncoded.Clear;
  end else
  begin
    if CTEncoding ='X-UUENCODE' then
    begin
      AttFile.BodyEncoded.Assign( aPart);
      AttFile.UUDecode;
      AttFile.BodyEncoded.Clear;
    end else
    begin
      if CTEncoding ='QUOTED-PRINTABLE' then
      begin
        aPart.Text := sak_QuotedPrintableDecode( PChar( aPart.Text));
        AttFile.BodyBin.Write( Pointer( aPart.text)^, length( aPart.text)-2);
        // -2 because .Text introduces a final crlf
      end else
      begin
        AttFile.BodyBin.Write( Pointer( aPart.text)^, length( aPart.text)-2);
        // -2 because .Text introduces a final crlf
      end;
    end;
  end;
end;



function TSakMsg.FindUUAttachs( const strList: TStringList;
                                var line: integer;
                                var FileName: string): boolean;
var
  s, t, permiss: string;
  intPermiss: integer;
begin
  result := false;
  if StrList.Count = 0 then exit;
  line := 0;
  repeat
    s := strList[ line];
    if length( s) > 10 then  // begin 600 n
    begin
      t := s[1] + s[2] + s[3] + s[4] + s[5];
      if lowerCase( t) = 'begin' then
      begin
        permiss := copy( s, 7, 3);
        intPermiss := StrToIntDef( permiss, -1);
        if (intPermiss > 0) and (intPermiss < 777) then
        begin
          FileName := copy( strList[ line], 11, 64);
          result := true;
          break;
        end;
      end;
    end;
    inc( line);
  until line = strList.count;
end;

procedure TSakMsg.FillRawMail;
var
  i: integer;
  boundary, CTF, fn: string;
  body, Headers: TStringList;
  AttFile: TAttachedFile;
  TextCoded: TMemoryStream;
  b64Encode: TBase64EncodingStream;
  c: char;
begin
  RawMail.Clear;

  Headers := TStringList.Create;
  Body := TStringList.Create;

  Body.Text := Text.Text;

  Headers.Add('Message-Id: ' + sak_MakeUniqueId( 'a.b.c'));//FSocket.Socket.LocalHost));

  Headers.Add('Date: ' + Date);
  Headers.Add('X-Priority: ' + IntToStr(Integer(Priority) + 1));

  if (pos( '@', From) = 0) then
    raise Exception.Create( '"From" address not complete.');

  if UserName <> '' then
    Headers.Add('From: ' + '"' + UserName + '" <' + From + '>')
  else
    Headers.Add('From: ' + From);

  if InReplyTo <> '' then
    Headers.Add('In-Reply-To: ' + InReplyTo);

  if ReplyTo <> '' then
    Headers.Add('Reply-To: ' + ReplyTo);

  Headers.Add('X-Mailer: ' + XMailer);
  Headers.Add('To: ' + SendTo);

  if CC <> '' then
    Headers.Add('CC: ' + CC);

  Headers.Add('MIME-Version: 1.0');

  CTF := '8Bit';
  if TextEncoding = te8Bit then
  begin
    i := 0;
    while i < Body.Count do
    begin
      if pos( '.', Body[i]) = 1 then
        Body[i] := '.' + Body[i];      // add transparency
      i := i + 1;
    end;
  end else
  begin   // TextEncoding = teBase64
    // encode the subject
    TextCoded := TMemoryStream.Create;
    b64Encode := TBase64EncodingStream.Create( TextCoded);
    b64Encode.Write( pointer( Subject)^, length( Subject));
    b64Encode.Free;  // first, to flush the remaining bytes

    Subject := '';
    TextCoded.Position := 0;
    for i:= 1 to TextCoded.Size do
    begin
      TextCoded.Read( c, 1);
      Subject := Subject + c;
    end;
    Subject := '=?' + CharSet + '?B?' + Subject + '?=';
    TextCoded.Free;

    // encode the body
    TextCoded := TMemoryStream.Create;
    b64Encode := TBase64EncodingStream.Create( TextCoded);
    b64Encode.Write( pointer( Body.Text)^, length( Body.Text));
    b64Encode.Free;  // first, to flush the remaining bytes
    Body.Clear;
    TextCoded.Position := 0;
    Body.LoadFromStream( TextCoded);
    TextCoded.Free;
    CTF := 'base64';
  end;

  Headers.Add('Subject: ' + Subject);

  if AttachedFiles.count = 0 then
  begin
    Headers.Add( 'Content-Type: text/plain; charset=' + CharSet);
    Headers.Add( 'Content-Transfer-Encoding: ' + CTF);
  end else
  begin
    boundary := sak_GenerateBoundary;
    Headers.Add( 'Content-Type: multipart/mixed; boundary="' + boundary + '"');
    boundary := '--' + boundary;
    Body.Insert( 0, boundary);
    Body.Insert( 1, 'Content-Type: text/plain; charset=' + CharSet);
    Body.Insert( 2, 'Content-Transfer-Encoding: ' + CTF);
    Body.Insert( 3, '');
    for i := 0 to AttachedFiles.count-1 do
    begin
      AttFile := AttachedFiles[ i];
      AttFile.Base64Encode;
      fn := AttFile.FileName;

      Body.Add( boundary);
      Body.Add( 'Content-Type: ' + AttFile.MIMEType + '; name="' + fn + '"');
      Body.Add( 'Content-Transfer-Encoding: base64');
      Body.Add( 'Content-Disposition: attachment; filename="' + fn + '"');
      Body.Add( '');

      Application.ProcessMessages;

{      if FCanceled then
      begin
        Headers.Clear; Headers.Free;
        Body.Clear; Body.Free;
        exit;
      end;}

      Body.AddStrings( AttFile.BodyEncoded);
    end;
    Body.Add( '');
    Body.Add( boundary + '--');
    Body.Add( '');
  end;

  Headers.AddStrings( ExtraHeaders);

  RawMail.AddStrings( Headers);
  RawMail.Add( '');
  RawMail.AddStrings( Body);

  Headers.Clear; Headers.Free;
  Body.Clear; Body.Free;
end;

{procedure TSakMsg.FDoDecodeStart( FileName: string; BytesCount: longint);
begin
  if assigned( FOnDecodeStart) then
     FOnDecodeStart( self, FileName, BytesCount);
end;

procedure TSakMsg.FDoDecodeProgress( Percent: word);
begin
  if assigned( FOnDecodeProgress) then
     FOnDecodeProgress( self, Percent);
end;

procedure TSakMsg.FDoDecodeEnd;
begin
  if assigned( FOnDecodeEnd) then
     FOnDecodeEnd( self);
end;}


// ***************** TSakMsgList *****************

constructor TSakMsgList.create( AOwner: TComponent);
begin
  inherited create( AOwner);
  if not ( csDesigning in ComponentState) then
    FList := TList.create;
end;

destructor TSakMsgList.destroy;
begin
  if not ( csDesigning in ComponentState) then
  begin
    FList.Clear;
    FList.Free;
  end;
  inherited destroy;
end;

function  TSakMsgList.Get(Index: Integer): TsakMsg;
begin
  result := TSakMsg( FList.Items[ index]);
end;

procedure TSakMsgList.Put(Index: Integer; Item: TsakMsg);
begin
  FList.Items[ index] := Item;
end;

procedure TSakMsgList.Clear;
var
  i: integer;
begin
  for i := FList.Count-1 downto 0 do
  begin
    Delete( i);
  end;
  FList.Clear;
end;

function  TSakMsgList.Add(Item: TsakMsg): Integer;
begin
  result := FList.Add( Item);
end;

procedure TSakMsgList.Delete(Index: Integer);
begin
  TObject(FList.Items[index]).Free;
  FList.Delete( index);
end;

function  TSakMsgList.IndexOf(Item: TsakMsg): Integer;
begin
  result := FList.IndexOf( Item);
end;

procedure TSakMsgList.Insert(Index: Integer; Item: TsakMsg);
begin
  FList.Insert( Index, Item);
end;

function  TSakMsgList.Remove(Item: TsakMsg): Integer;
var
  index: Integer;
begin
  index := FList.IndexOf(item);
  if index > -1 then
  begin
    Delete(index);
  end;
  Result := Index;
end;

function  TSakMsgList.First: TSakMsg;
begin
  result := TSakMsg( FList.first);
end;

function  TSakMsgList.Last: TSakMsg;
begin
  result := TSakMsg( FList.Last);
end;

function  TSakMsgList.GetCount: integer;
begin
  result := FList.Count;
end;



end.
