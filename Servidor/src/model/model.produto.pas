unit model.produto;

interface

uses
  System.SysUtils, System.Classes, model.conexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, frxClass, frxDBSet, System.JSON, DataSet.Serialize,
  frxExportBaseDialog, frxExportPDF;

type
  TdmProduto = class(TdmConexao)
    qryProdutos: TFDQuery;
    qryProdutosIDPRODUTO: TIntegerField;
    qryProdutosDESCRICAO: TStringField;
    qryProdutosREFERENCIA: TStringField;
    frxProdutos: TfrxReport;
    dsProdutos: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
  private
    { Private declarations }
  public
    { Public declarations }
    function RelatorioProduto: TJSONObject;
  end;

var
  dmProduto: TdmProduto;

implementation

uses
  System.NetEncoding;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmProduto }

function TdmProduto.RelatorioProduto: TJSONObject;
var
  LStream: TBytesStream;
  LFile: TFileStream;
  Larq : string;
  LBase64:string;

  LJson:TJSONObject;
begin
  qryProdutos.Open;

  frxProdutos.PrintOptions.ShowDialog := False;
  frxProdutos.ShowProgress := false;

  frxProdutos.EngineOptions.SilentMode := True;
  frxProdutos.EngineOptions.EnableThreadSafe := True;
  frxProdutos.EngineOptions.DestroyForms := False;
  frxProdutos.EngineOptions.UseGlobalDataSetList := False;

  frxPDFExport1.Background := True;
  frxPDFExport1.ShowProgress := False;
  frxPDFExport1.ShowDialog := False;

  //AQUI PASSE O CAMINHO ONDE QUEIRA SALVAR O PDF
  frxPDFExport1.FileName := 'C:\Users\USUARIO\Desktop\aula terça\Gerador de relatorio\Servidor\exe\relatorios\relatorio produtos.pdf';
  frxPDFExport1.DefaultPath := 'C:\Users\USUARIO\Desktop\aula terça\Gerador de relatorio\Servidor\exe\relatorios';

  frxProdutos.PreviewOptions.AllowEdit := False;
  frxProdutos.PrepareReport;
  frxProdutos.Export(frxPDFExport1);

  //FORMA DE ENVIAR O PDF PEGANDO DO DIRETORIO, ALTERAR O VALOR DA VARIAVEL LARQ
  Larq := 'C:\Users\USUARIO\Desktop\aula terça\Gerador de relatorio\Servidor\exe\relatorios\relatorio produtos.pdf';

  if not FileExists(Larq) then
  begin
    LJson := TJSONObject.Create;
    try
      LJson.AddPair('arquivo', 'Arquivo não encontrado: ' + Larq);
      Result := LJson;
    finally
      FreeAndNil(LJson);
    end;
  end
  else
  begin
    LStream:= TBytesStream.Create;
    try
      LStream.LoadFromFile(Larq);
      LStream.Position:= 0;

      LBase64:= TNetEncoding.Base64.EncodeBytesToString(LStream.Bytes);

      LJson:= TJSONObject.Create;
      LJson.AddPair('arquivo', LBase64);

      Result := LJson;

    finally
      FreeAndNil(LStream);
    end;
  end;
end;

end.
