program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {frmUdp};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmUdp, frmUdp);
  Application.Run;
end.
