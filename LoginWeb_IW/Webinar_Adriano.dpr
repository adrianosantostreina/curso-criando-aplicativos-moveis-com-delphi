program Webinar_Adriano;

uses
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  Forms,
  IWStart,
  ServerController in 'ServerController.pas' {IWServerController: TIWServerControllerBase},
  UserSessionUnit in 'UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase},
  u_frmLogin in 'u_frmLogin.pas' {frmLogin: TIWAppForm},
  u_frmPrincipal in 'u_frmPrincipal.pas' {frmPrincipal: TIWAppForm};

{$R *.res}

begin
  TIWStart.Execute(True);
end.
