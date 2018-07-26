unit u_frmPrincipal;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, Vcl.Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton;

type
  TfrmPrincipal = class(TIWAppForm)
    IWTemplateProcessorHTML1: TIWTemplateProcessorHTML;
    BTNENCERRAR: TIWButton;
    procedure IWTemplateProcessorHTML1UnknownTag(const AName: string;
      var VValue: string);
    procedure BTNENCERRARClick(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}

uses ServerController, u_frmLogin;


procedure TfrmPrincipal.BTNENCERRARClick(Sender: TObject);
begin
  TIWAppForm(WebApplication.ActiveForm).Release;
  TFrmLogin.Create(WebApplication).Show;
end;

procedure TfrmPrincipal.IWTemplateProcessorHTML1UnknownTag(const AName: string;
  var VValue: string);
begin
  if AName = 'NomeUsuario' then
    VValue := UserSession.glbNomeUsuario;

  if AName = 'EmailUsuario' then
    VValue := UserSession.glbEmailUsuario;

  if AName = 'TipoUsuario' then
    VValue := UserSession.glbTipoUsuario;

  if AName = 'NomeEstab' then
    VValue := UserSession.glbNomeEstabelecimento;

  if AName = 'ApelidoEstab' then
    VValue := UserSession.glbApelidoEstabelecimento;
end;

end.
