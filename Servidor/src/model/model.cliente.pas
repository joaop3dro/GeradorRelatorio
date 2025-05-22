unit model.cliente;

interface

uses
  System.SysUtils, System.Classes, model.conexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, frxClass, frxDBSet, DataSet.Serialize, System.JSON,
  frxExportBaseDialog, frxExportPDF;

type
  TdmCliente = class(TdmConexao)
    qryClientes: TFDQuery;
    qryClientesIDPESSOAS: TIntegerField;
    qryClientesRAZAOSOCIAL: TStringField;
    qryClientesENDERECO: TStringField;
    qryClientesCEP: TStringField;
    frxClientes: TfrxReport;
    dsClientes: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
  private
    { Private declarations }
  public
    { Public declarations }
    function RelatorioCliente: TJSONObject;
  end;

var
  dmCliente: TdmCliente;

implementation

uses
  System.NetEncoding;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmCliente }

function TdmCliente.RelatorioCliente: TJSONObject;
var
  LStream: TBytesStream;
  LFile: TFileStream;
  Larq : string;
  LBase64:string;

  LJson:TJSONObject;

  LPDFStream: TMemoryStream;
  LPDFBase64: string;
begin
  qryClientes.Open;

  frxClientes.PrintOptions.ShowDialog := False;
  frxClientes.ShowProgress := false;

  frxClientes.EngineOptions.SilentMode := True;
  frxClientes.EngineOptions.EnableThreadSafe := True;
  frxClientes.EngineOptions.DestroyForms := False;
  frxClientes.EngineOptions.UseGlobalDataSetList := False;

  frxPDFExport1.Background := True;
  frxPDFExport1.ShowProgress := False;
  frxPDFExport1.ShowDialog := False;

  //AQUI PASSE O CAMINHO ONDE QUEIRA SALVAR O PDF
  frxPDFExport1.FileName := 'C:\Users\USUARIO\Desktop\aula terça\Gerador de relatorio\Servidor\exe\relatorios\relatorio clientes.pdf';
  frxPDFExport1.DefaultPath := 'C:\Users\USUARIO\Desktop\aula terça\Gerador de relatorio\Servidor\exe\relatorios';

  frxClientes.PreviewOptions.AllowEdit := False;
  frxClientes.PrepareReport;
  frxClientes.Export(frxPDFExport1);


  // FORMA DE ENVIAR O PDF CONVERTANDO PARA STREAM
  LPDFStream := TMemoryStream.Create;
  try
    frxPDFExport1.Stream := LPDFStream;
    frxClientes.Export(frxPDFExport1);
    LPDFStream.Position := 0;
    LPDFBase64 := TNetEncoding.Base64.EncodeBytesToString(LPDFStream.Memory, LPDFStream.Size);
    LJson:= TJSONObject.Create;
    LJson.AddPair('arquivo', LPDFBase64);

    Result := LJson;
  finally
    LPDFStream.Free;
  end;

  //FORMA DE ENVIAR O PDF PEGANDO DO DIRETORIO, ALTERAR O VALOR DA VARIAVEL LARQ
//  Larq := 'C:\Users\USUARIO\Desktop\aula terça\Gerador de relatorio\Servidor\exe\relatorios\relatorio clientes.pdf';
//
//  if not FileExists(Larq) then
//  begin
//    LJson := TJSONObject.Create;
//    try
//      LJson.AddPair('arquivo', 'Arquivo não encontrado: ' + Larq);
//      Result := LJson;
//    finally
//      FreeAndNil(LJson);
//    end;
//  end
//  else
//  begin
//    LStream:= TBytesStream.Create;
//    try
//      LStream.LoadFromFile(Larq);
//      LStream.Position:= 0;
//
//      LBase64:= TNetEncoding.Base64.EncodeBytesToString(LStream.Bytes);
//
//      LJson:= TJSONObject.Create;
//      LJson.AddPair('arquivo', LBase64);
//
//      Result := LJson;
//
//    finally
//      FreeAndNil(LStream);
//    end;
//  end;
end;

end.
