unit smPacienteUnt;

interface

uses System.SysUtils, System.Classes, System.Json,
  DataSnap.DSProviderDataModuleAdapter,
  DataSnap.DSServer, DataSnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase, Web.HttpApp, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  REST.Client;

type
  TPaciente = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    fdqDados: TFDQuery;
    FDUpdateSQL1: TFDUpdateSQL;
    fdqDadosCASO: TIntegerField;
    fdqDadosNOME: TStringField;
    fdqDadosALTURA: TBCDField;
    fdqDadosPESOATUAL: TBCDField;
    fdqDadosPESOINICIAL: TBCDField;
    fdqDadosPESOIDEAL: TBCDField;
    fdqDadosIMC: TBCDField;
    fdqExames: TFDQuery;
    fdqExamesCASO: TIntegerField;
    fdqExamesDATA: TDateField;
    fdqExamesGLICEMIA: TBCDField;
    fdqExamesCOLESTEROLTOTAL: TBCDField;
    fdqExamesHDL: TBCDField;
    fdqExamesLDL: TBCDField;
    fdqExamesTRIGLICERIDES: TBCDField;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function Paciente(id: integer): TJSONArray;                // Get
    function UpdatePaciente(JPaciente: TJSONObject): boolean;  // Post
    function AcceptPaciente(JPaciente: TJSONObject): boolean;  // Put
    function CancelPaciente(id: integer): boolean;             // Delete
    function Exame (id: integer) : TJSONArray;
  end;

implementation

{$R *.dfm}

uses System.StrUtils;

function TPaciente.AcceptPaciente(JPaciente: TJSONObject): boolean;
//  Mapeamento padrão do Delphi para PUT
begin
//INSERT INTO DADOS
//(CASO, NOME)
//VALUES (:NEW_CASO, :NEW_NOME)
//RETURNING CASO, NOME
  Result := False;
  if not FDUpdateSQL1.Commands[arInsert].Prepared then
    FDUpdateSQL1.Commands[arInsert].Prepare;

  FDUpdateSQL1.Commands[arInsert].ParamByName('NEW_CASO').AsInteger :=
    JPaciente.GetValue('CASO').Value.ToInteger;
  FDUpdateSQL1.Commands[arInsert].ParamByName('NEW_NOME').AsString :=
    JPaciente.GetValue('NOME').Value;
  Result := FDUpdateSQL1.Commands[arInsert].OpenOrExecute();
end;

function TPaciente.CancelPaciente(id: integer): boolean;
//  Mapeamento padrão do Delphi para Delete
begin
  Result := False;
  if not FDUpdateSQL1.Commands[arDelete].Prepared then
    FDUpdateSQL1.Commands[arDelete].Prepare;

  FDUpdateSQL1.Commands[arDelete].ParamByName('OLD_CASO').AsInteger := id;
  Result := FDUpdateSQL1.Commands[arDelete].OpenOrExecute();
end;

function TPaciente.Exame(id: integer): TJSONArray;
//  Mapeamento padrão do Delphi para Get
var
  o : TJSONObject;
  I: integer;
begin
  fdqExames.Close;
  if id <= 0  then
    fdqExames.SQL.Text := 'select caso,data,glicemia,colesteroltotal,hdl,ldl, ' +
      'triglicerides from exames order by data'
  else
    begin
      fdqExames.SQL.Text := 'select caso,data,glicemia, colesteroltotal, hdl, ' +
        'ldl, triglicerides from exames where caso = :parCaso order by data';
      fdqExames.Params.Add('parCaso', ftInteger, ptInput);
      fdqExames.Params[0].AsInteger := id;
    end;
    fdqExames.Open();
    if fdqExames.Active then
      begin
        if fdqExames.RecordCount > 0 then
        begin
          Result := TJSONArray.Create;
          try
            fdqExames.First;
            while not(fdqExames.Eof) do
            begin
              o := TJSONObject.Create;
              for I := 0 to fdqExames.FieldCount - 1 do
                begin
                  if (fdqExames.Fields[I].IsNull) then
                    //Tratando valores nulos para não "quebrar" a aplicação
                    o.AddPair(fdqExames.Fields[I].DisplayName, 'nulo')
                  else
                    o.AddPair(fdqExames.Fields[I].DisplayName, fdqExames.Fields[I].Value);
                end;
              Result.AddElement(o);
              fdqExames.Next;
            end;
          finally

          end;
        end;
      end;
end;

function TPaciente.Paciente(id: integer): TJSONArray;
//  Mapeamento padrão do Delphi para Get
var
  o: TJSONObject;
  I: integer;
begin
  fdqDados.Close;
  if id <= 0 then
    fdqDados.SQL.Text := 'select caso, nome, altura, pesoatual, pesoinicial, ' +
                        'pesoideal, imc from dados order by caso '
  else
    begin
      fdqDados.SQL.Text := 'select caso, nome, altura, pesoatual, pesoinicial, ' +
       'pesoideal, imc from dados where caso = :parCaso ';
      fdqDados.Params.Add('parCaso', ftInteger, ptInput);
      fdqDados.Params[0].AsInteger := id;
    end;

  fdqDados.Open();
  if fdqDados.Active then
    begin
      if fdqDados.RecordCount > 0 then
        begin
          Result := TJSONArray.Create;
          try
            fdqDados.First;
            while not(fdqDados.Eof) do
            begin
              o := TJSONObject.Create;
              for I := 0 to fdqDados.FieldCount - 1 do
              begin
                if fdqDados.Fields[I].IsNull then
                  //Tratando valores nulos para não "quebrar" a aplicação
                  o.AddPair(fdqDados.Fields[I].DisplayName, 'nulo')
                else
                  o.AddPair(fdqDados.Fields[I].DisplayName, fdqDados.Fields[I].Value);

              end;
              Result.AddElement(o);
              fdqDados.Next;
            end;
          finally

          end;
        end
      else
        begin
          Result := TJSONArray.Create;
          o := TJSONObject.Create;
          o.AddPair('result', 'Não há dados para exibição');
          Result.AddElement(o);
        end;
    end;

end;

function TPaciente.UpdatePaciente(JPaciente: TJSONObject): boolean;
//  Mapeamento padrão do Delphi para POST
begin
  Result := False;
  if not(FDUpdateSQL1.Commands[arUpdate].Prepared) then
    FDUpdateSQL1.Commands[arUpdate].Prepare;

  FDUpdateSQL1.Commands[arUpdate].ParamByName('OLD_CASO').AsInteger :=
    JPaciente.GetValue('CASO').Value.ToInteger();
  FDUpdateSQL1.Commands[arUpdate].ParamByName('NEW_CASO').AsInteger :=
    FDUpdateSQL1.Commands[arUpdate].ParamByName('OLD_CASO').Value;
  FDUpdateSQL1.Commands[arUpdate].ParamByName('NEW_NOME').AsString :=
    JPaciente.GetValue('NOME').Value;
  Result := FDUpdateSQL1.Commands[arUpdate].OpenOrExecute();
end;

function TPaciente.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TPaciente.EchoString(Value: string): string;
begin
  Result := Value;
end;

end.
