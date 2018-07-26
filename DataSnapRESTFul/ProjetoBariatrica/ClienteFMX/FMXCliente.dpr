program FMXCliente;

uses
  System.StartUpCopy,
  FMX.Forms,
  uTelaTeste in 'uTelaTeste.pas' {frmTelaTeste};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTelaTeste, frmTelaTeste);
  Application.Run;
end.
