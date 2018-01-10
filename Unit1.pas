unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer, StdCtrls,
  ExtCtrls, IDSocketHandle,  IdGlobal;

type
  TSensors=packed record

  end;

  TfrmUdp = class(TForm)
    udp: TIdUDPServer;
    btnStartStop: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    procedure btnStartStopClick(Sender: TObject);
    procedure udpUDPException(AThread: TIdUDPListenerThread; ABinding: TIdSocketHandle; const AMessage: String;  const AExceptionClass: TClass);
    procedure udpUDPRead(AThread: TIdUDPListenerThread; AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    ReadCount:Integer;
    T1,T2,sumLatency,LastLatency:Cardinal;
    BData:TIdBytes;
  end;

var
  frmUdp: TfrmUdp;

implementation

{$R *.dfm}
procedure TfrmUdp.FormCreate(Sender: TObject);
begin
  ReadCount:=0;
  T1:=0;
  SetLength(BData,1000);
end;

procedure TfrmUdp.btnStartStopClick(Sender: TObject);
begin
  if udp.Active then begin
    udp.Active :=False;
    btnStartStop.Caption:='Start UDP Server';
  end
  else begin
    udp.Active :=True;
    btnStartStop.Caption:='Stop UDP Server';
  end;
end;

procedure TfrmUdp.udpUDPException(AThread: TIdUDPListenerThread; ABinding: TIdSocketHandle; const AMessage: String; const AExceptionClass: TClass);
begin
  self.Caption:=AMessage;
end;

procedure TfrmUdp.udpUDPRead(AThread: TIdUDPListenerThread; AData: TIdBytes; ABinding: TIdSocketHandle);
type
  tp=Array[1..20] of single;
Var
  Poi:Pointer;
  p:^Tp;
  i,j,Size:Integer;
  k,l:Single;
begin
  T2:=T1;
  T1:=GetTickCount();
  If T2<>0 then
    sumLatency:=sumLatency+(T1-T2);
  Inc(ReadCount);
  If LastLatency<> (sumLatency div ReadCount) then Begin
    LastLatency:=sumLatency div ReadCount;
    Panel2.Caption:=inttostr(LastLatency) +'ms';
  end;
  if ReadCount mod 100=0 then Panel1.Caption:=inttostr(ReadCount);
  size:=length(AData);
  for i:=0 to Size-1 do Begin
    J:=(i div 4)*4+(3-(i mod 4));
    BData[i]:=Adata[j];
  End;
  poi:=bdata;
  P:=poi;
  k:=p[8];

end;


procedure TfrmUdp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  udp.OnUDPRead:=nil;
  if udp.Active then
    udp.Active :=False;
  SetLength(BData,0);
end;

procedure TfrmUdp.Button1Click(Sender: TObject);
var
  adata:TIdBytes;
  poi:Pointer;
  p:^Single;
begin
  SetLength(adata,4);
  adata[0]:=66;
  adata[1]:=137;
  adata[2]:=207;
  adata[3]:=81;
  poi:=Adata;
  p:=poi;

  adata[3]:=66;
  adata[2]:=137;
  adata[1]:=207;
  adata[0]:=81;
  poi:=Adata;
  p:=poi;
  
end;

end.
