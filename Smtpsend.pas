unit Smtpsend;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Winsock;

type

  smtprec       = record
    host        : string;
    port        : integer;
  end;

  msgrec        = record
    date        : string;
    contenttype : string;
    sender      : string;
    xmailer     : string;
    replyto     : string;
    subject     : string;
    from        : string;
    sendto      : string;
    extraheaders: tstrings;
    text        : tstrings;
    attachedfiles: tstrings;
  end;

var

  smtp          : smtprec;

procedure SMTPconnect;
procedure SMTPSendMsg( message: msgrec );
procedure SMTPdisconnect;

implementation

var

  socket: TSocket;

procedure SMTPconnect;
var

  inaddr: tSockAddr;

begin
  gethostbyname( pchar( smtp.host ) );
//  connect( socket,
end;

procedure SMTPSendMsg( message: msgrec );
begin
end;

procedure SMTPdisconnect;
begin
end;

end.
