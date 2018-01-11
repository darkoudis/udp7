unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer, StdCtrls,
  ExtCtrls, IDSocketHandle,  IdGlobal,Math;

type
  TSensors=packed record
    AccX,AccY,AccZ,
    GraX,GraY,GraZ,
    RotX,RotY,RotZ,
    OriX,OriY,OriZ:Single;
  end;
  PSensors=^TSensors;

{  X Acceleration, Y Acceleration, Z Acceleration,
  X Gravity, Y Gravity, Z Gravity,
  X Rotation Rate, Y Rotation Rate, Z Rotation Rate,
  X Orientation (Azimuth), Y Orientation (Pitch), Z Orientation (Roll),
  deprecated, deprecated, Ambient Light, Proximity, Keyboard Buttons 1 - 8]}

  TfrmUdp = class(TForm)
    udp: TIdUDPServer;
    btnStartStop: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    pnlAcc: TPanel;
    pnlGra: TPanel;
    pnlMaxAcc: TPanel;
    pnlMinAcc: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Panel3: TPanel;
    procedure btnStartStopClick(Sender: TObject);
    procedure udpUDPException(AThread: TIdUDPListenerThread; ABinding: TIdSocketHandle; const AMessage: String;  const AExceptionClass: TClass);
    procedure udpUDPRead(AThread: TIdUDPListenerThread; AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    ReadCount:Integer;
    T1,T2,sumLatency,LastLatency:Cardinal;
    BData:TIdBytes;
    accMax,accMin,RotMax,RotMin:Single;
    Procedure ReadData;
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
  ReadData;
end;


procedure TfrmUdp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  udp.OnUDPRead:=nil;
  if udp.Active then
    udp.Active :=False;
  SetLength(BData,0);
end;

procedure TfrmUdp.ReadData;
Var
  p:PSensors;
  str:String;
  x:Single;
begin
  P:=Pointer(BData);
  Str:=floattostr(round(p.AccX*100)/100)+' - '+floattostr(round(p.AccY*100)/100)+' - '+floattostr(round(p.AccZ*100)/100);
  If pnlAcc.Caption<>Str then
    pnlAcc.Caption:=Str;
  accmax:=max(accmax,p.AccX);  accmax:=max(accmax,p.AccY);  accmax:=max(accmax,p.AccZ);
  accMin:=min(accMin,p.AccX);  accMin:=min(accmin,p.AccY);  accMin:=min(accmin,p.AccZ);
  pnlMinAcc.Caption:=floattostr(round(AccMin*100)/100);
  pnlMaxAcc.Caption:=floattostr(round(AccMax*100)/100);
  Panel3.Width:=round((3+p.AccX)*100);

  Str:=floattostr(round(p.GraX*100)/100)+' | '+floattostr(round(p.GraY*100)/100)+' | '+floattostr(round(p.GraZ*100)/100);
  If pnlGra.Caption<>Str then
    pnlGra.Caption:=Str;


  x:=round(p.Accz*100);
  Canvas.Pen.Color:=clRed;
  canvas.MoveTo(0,200);
  Canvas.LineTo(400,200);

  Canvas.Pen.Color:=clYellow;
  canvas.MoveTo(200,200);
  Canvas.LineTo(200+round(x),200);

  Canvas.Pen.Color:=clBlack;
  canvas.MoveTo(199,200);
  Canvas.LineTo(201,200);



end;

end.
