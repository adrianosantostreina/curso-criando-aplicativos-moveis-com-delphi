unit u_frmLogin;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, Data.DB,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompListbox, IWDBStdCtrls,
  IWCompButton, Vcl.Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompEdit;

type
  TfrmLogin = class(TIWAppForm)
    Usuario: TIWEdit;
    btnConfirmar: TIWButton;
    IWTemplateProcessorHTML1: TIWTemplateProcessorHTML;
    Senha: TIWEdit;
    procedure btnConfirmarClick(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}

uses ServerController, UserSessionUnit, u_frmPrincipal;


procedure TfrmLogin.btnConfirmarClick(Sender: TObject);
begin
  UserSession.FDQQuery.Close;
  UserSession.FDQQuery.SQL.Clear;
  UserSession.FDQQuery.SQL.Add('select u.nome_completo, u.nome_usuario, u.email, u.tipo, e.id, e.fantasia, e.razao_social from usuarios u ');
  UserSession.FDQQuery.SQL.Add('       left join estabelecimentos e on e.id = u.id_estabelecimento ');
  UserSession.FDQQuery.SQL.Add('Where u.cpfcnpj = '''+Usuario.Text+''' and u.senha = '''+UserSession.MD5(Senha.Text)+'''');
  UserSession.FDQQuery.Open();

  if UserSession.FDQQuery.Eof then
  begin
    WebApplication.ShowMessage('Atenção!!! Usuário e/ou Senha Inválidos ou não Cadastrado...');
    Usuario.SetFocus;
    exit;
  end;

  //
  // Usuario Encontrado Guardo os dados do Usuario para usar nos forms seguintes
  //

  UserSession.glbUsuario := UserSession.FDQQuery.FieldByName('nome_usuario').AsString;
  UserSession.glbNomeUsuario := UserSession.FDQQuery.FieldByName('nome_completo').AsString;
  UserSession.glbEmailUsuario := UserSession.FDQQuery.FieldByName('email').AsString;

  UserSession.glbTipoUsuario := UserSession.FDQQuery.FieldByName('tipo').AsString;

  UserSession.glbIdEstabelecimento := UserSession.FDQQuery.FieldByName('id').AsInteger;
  UserSession.glbNomeEstabelecimento := UserSession.FDQQuery.FieldByName('razao_social').AsString;
  UserSession.glbApelidoEstabelecimento := UserSession.FDQQuery.FieldByName('fantasia').AsString;

  UserSession.FDQQuery.Close;

  Release;
  TFrmPrincipal.Create(WebApplication).Show;
end;

initialization
  TfrmLogin.SetAsMainForm;

end.
