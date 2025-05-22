program gerador_relatorio;

uses
  Vcl.Forms,
  view.principal in 'src\view\view.principal.pas' {frmViewPrincipal},
  model.conexao in 'src\model\model.conexao.pas' {dmConexao: TDataModule},
  model.cliente in 'src\model\model.cliente.pas' {dmCliente: TDataModule},
  model.produto in 'src\model\model.produto.pas' {dmProduto: TDataModule},
  controller.cliente in 'src\controller\controller.cliente.pas',
  controller.produto in 'src\controller\controller.produto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmViewPrincipal, frmViewPrincipal);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TdmCliente, dmCliente);
  Application.CreateForm(TdmProduto, dmProduto);
  Application.Run;
end.
