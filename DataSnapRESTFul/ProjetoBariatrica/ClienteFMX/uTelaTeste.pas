unit uTelaTeste;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.DBScope,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  FMX.ListView, FMX.Controls.Presentation, FMX.StdCtrls, Data.Bind.Controls,
  FMX.Layouts, Fmx.Bind.Navigator, System.ImageList, FMX.ImgList, FMX.Objects,
  FMX.Edit, FMX.ScrollBox, FMX.Memo, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageBin, FMX.ListBox;

type
  TfrmTelaTeste = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Edit1: TEdit;
    Edit2: TEdit;
    Memo1: TMemo;
    ListView1: TListView;
    FDMemTable1: TFDMemTable;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    RESTClient3: TRESTClient;
    RESTRequest3: TRESTRequest;
    RESTResponse3: TRESTResponse;
    FDMemTable1CASO: TWideStringField;
    FDMemTable1NOME: TWideStringField;
    FDMemTable1ALTURA: TWideStringField;
    FDMemTable1PESOATUAL: TWideStringField;
    FDMemTable1PESOINICIAL: TWideStringField;
    FDMemTable1PESOIDEAL: TWideStringField;
    FDMemTable1IMC: TWideStringField;
    Layout1: TLayout;
    ToolBar1: TToolBar;
    Label3: TLabel;
    Layout2: TLayout;
    ToolBar2: TToolBar;
    Layout3: TLayout;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ToolBar3: TToolBar;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB1: TBindSourceDB;
    Layout4: TLayout;
    spbGet: TSpeedButton;
    spbPut: TSpeedButton;
    spbPost: TSpeedButton;
    spbDelete: TSpeedButton;
    NavigatorBindSourceDB1: TBindNavigator;
    LinkPropertyToFieldText: TLinkPropertyToField;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure spbGetClick(Sender: TObject);
    procedure spbPostClick(Sender: TObject);
    procedure spbPutClick(Sender: TObject);
    procedure spbDeleteClick(Sender: TObject);
    procedure Memo1DblClick(Sender: TObject);
  private
    procedure ConsultarLB;
    procedure Get;
    procedure Put;
    procedure Post;
    procedure Delete;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTelaTeste: TfrmTelaTeste;

implementation

uses
  System.JSON, System.JSON.Writers, System.JSON.Types,
  REST.Types, REST.Utils, System.JSON.Readers;

{$R *.fmx}


procedure TfrmTelaTeste.SpeedButton1Click(Sender: TObject);
begin
  ListView1.Items.Clear;
  ConsultarLB;
end;

procedure TfrmTelaTeste.ConsultarLB;
begin
  RESTRequest1.Params[0].Value := '0';
  RESTRequest1.Execute;
end;

procedure TfrmTelaTeste.spbGetClick(Sender: TObject);
begin
  Get;
end;

procedure TfrmTelaTeste.spbPostClick(Sender: TObject);
begin
  Post;
end;

procedure TfrmTelaTeste.spbPutClick(Sender: TObject);
begin
  Put;
end;

procedure TfrmTelaTeste.spbDeleteClick(Sender: TObject);
begin
  Delete;
end;

procedure TfrmTelaTeste.Get;
var
  SR: TStringReader;
  JR: TJsonTextReader;
begin
  if Edit1.Text = EmptyStr then
    Edit1.Text := '0';
  RESTClient3.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient3.AcceptCharset := 'UTF-8, *;q=0.8';
  RESTClient3.BaseURL := Format('http://%s:%s/datasnap/rest', ['localhost', '8080']);
  RESTClient3.ContentType := CONTENTTYPE_APPLICATION_JSON;
  RESTRequest3.Resource := 'TPaciente/Paciente/{id}';
  RESTClient3.HandleRedirects := True;
  RESTClient3.RaiseExceptionOn500 := False;
  RESTRequest3.Client := RESTClient3;
  RESTRequest3.Method := TRESTRequestMethod.rmGET;
  RESTRequest3.Params.AddItem('id', URIEncode(Edit1.Text), TRESTRequestParameterKind.pkURLSEGMENT);
  RESTRequest3.Execute;
  RESTResponse3.ContentType := CONTENTTYPE_APPLICATION_JSON;
  Memo1.Lines.Clear;
  Memo1.Lines.Append(RESTRequestMethodToString(RESTRequest3.Method));
  Memo1.Lines.Append(RESTResponse3.Content);

  //  Utilizando JSON READERS - System.JSON.Readers
  SR := TStringReader.Create(RESTResponse3.Content);
  JR := TJsonTextReader.Create(SR);
  try
    try
      while JR.Read do
        if JR.TokenType = TJsonToken.PropertyName then
        begin
          if JR.Value.ToString = 'NOME' then
          begin
            JR.Read;
            Edit2.Text := JR.Value.ToString;
          end;
        end;
    finally
      JR.Free;
    end;
  finally
    SR.Free;
  end;

end;

procedure TfrmTelaTeste.Memo1DblClick(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TfrmTelaTeste.Post;
//Update na ótica do Delphi e Insert no REST *Universal
var
  t: TStringWriter;
  Jw: TJsonTextWriter;
begin
  if Edit1.Text = EmptyStr then
    Edit1.Text := '0';
  t := TStringWriter.Create;
  //  Utilizando JSON WRITER - System.JSON.Writers
  Jw := TJsonTextWriter.Create(t);
  jw.Formatting := TJsonFormatting.None;     //Indented;
  jw.WriteStartObject;
  jw.WritePropertyName('CASO');
  jw.WriteValue(Edit1.Text);
  jw.WritePropertyName('NOME');
  jw.WriteValue(Edit2.Text);
  jw.WriteEndObject;
  Memo1.Lines.Clear;
  Memo1.Lines.Append(t.ToString);
  RESTClient3.ResetToDefaults;
  RESTRequest3.ResetToDefaults;
  RESTResponse3.ResetToDefaults;
  RESTClient3.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient3.AcceptCharset := 'UTF-8, *;q=0.8';
  RESTClient3.BaseURL := Format('http://%s:%s/datasnap/rest', ['localhost', '8080']);
  RESTClient3.ContentType := 'application/json';
  RESTClient3.HandleRedirects := True;
  RESTClient3.RaiseExceptionOn500 := False;
  RESTRequest3.Client := RESTClient3;
  RESTRequest3.Method := rmPOST;
  RESTRequest3.Params.AddItem('JPaciente', t.ToString,
        TRESTRequestParameterKind.pkREQUESTBODY,
        [poDoNotEncode],
        ctAPPLICATION_JSON);
  RESTRequest3.Resource := 'TPaciente/Paciente';
  RESTRequest3.Response := RESTResponse3;
  RESTRequest3.SynchronizedEvents := False;
  RESTRequest3.Execute;
  Memo1.Lines.Clear;
  Memo1.Lines.Append(RESTRequestMethodToString(RESTRequest3.Method));
  Memo1.Lines.Append(RESTResponse3.Content);

end;

procedure TfrmTelaTeste.Put;
//Insert na ótica do Delphi e Update no REST *Universal
var
  JO: TJSONObject;
begin
  RESTClient3.ResetToDefaults;
  RESTRequest3.ResetToDefaults;
  RESTResponse3.ResetToDefaults;
  JO := TJSONObject.Create;
  JO.AddPair('CASO', Edit1.Text);
  JO.AddPair('NOME', Edit2.Text);
  RESTClient3.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient3.AcceptCharset := 'UTF-8, *;q=0.8';
  RESTClient3.BaseURL := Format('http://%s:%s/datasnap/rest', ['localhost', '8080']);
  RESTClient3.ContentType := 'application/json';
  RESTRequest3.Resource := 'TPaciente/Paciente';
  RESTClient3.HandleRedirects := True;
  RESTClient3.RaiseExceptionOn500 := False;
  RESTRequest3.Client := RESTClient3;
  RESTRequest3.Method := TRESTRequestMethod.rmPut;
  RESTRequest3.Body.Add(JO.ToString, ContentTypeFromString('application/json'));
  RESTRequest3.Execute;
  Memo1.Lines.Clear;
  Memo1.Lines.Append(RESTRequestMethodToString(RESTRequest3.Method));
  Memo1.Lines.Append(JO.ToJSON);
  Memo1.Lines.Append(RESTResponse3.Content);
end;

procedure TfrmTelaTeste.Delete;
begin
  if Edit1.Text = EmptyStr then
    Edit1.Text := '0';
  Memo1.Lines.Clear;
  RESTClient3.ResetToDefaults;
  RESTRequest3.ResetToDefaults;
  RESTResponse3.ResetToDefaults;
  RESTClient3.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient3.AcceptCharset := 'UTF-8, *;q=0.8';
  RESTClient3.BaseURL := Format('http://%s:%s/datasnap/rest', ['localhost', '8080']);
  RESTClient3.ContentType := 'application/json';
  RESTRequest3.Resource := 'TPaciente/Paciente/{id}';
  RESTClient3.HandleRedirects := True;
  RESTClient3.RaiseExceptionOn500 := False;
  RESTRequest3.SynchronizedEvents := False;
  RESTRequest3.Client := RESTClient3;
  RESTRequest3.Response := RESTResponse3;
  RESTRequest3.Method := rmDELETE;
  RESTRequest3.Params.AddItem('id',
        URIEncode(Edit1.Text),
        TRESTRequestParameterKind.pkURLSEGMENT, [],
        ctAPPLICATION_JSON);
  RESTRequest3.Execute;
  Memo1.Lines.Clear;
  Memo1.Lines.Append(RESTRequestMethodToString(RESTRequest3.Method));
  Memo1.Lines.Append(RESTRequest3.Params.ParameterByName('id').ToString);
end;

procedure TfrmTelaTeste.Edit1KeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = Ord(#13) then
    spbGet.OnClick(Self);
end;

procedure TfrmTelaTeste.FormActivate(Sender: TObject);
begin
  ConsultarLB;
end;


end.
