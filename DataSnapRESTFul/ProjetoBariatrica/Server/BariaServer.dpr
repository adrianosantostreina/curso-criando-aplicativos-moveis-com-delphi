program BariaServer;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  frmServerUnt in 'frmServerUnt.pas' {Form1},
  smPacienteUnt in 'smPacienteUnt.pas' {Paciente: TDSServerModule},
  scContainerUnt in 'scContainerUnt.pas' {ServerContainer1: TDataModule},
  wmWebModuleUnt in 'wmWebModuleUnt.pas' {WebModule1: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
