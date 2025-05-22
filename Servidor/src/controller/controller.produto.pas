unit controller.produto;

interface

uses Horse, System.JSON, model.produto;

procedure Produto;
procedure GetRelatorio(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses
  System.SysUtils;

procedure Produto;
begin
  THorse.Get('/relatorio/produto', GetRelatorio);
end;

procedure GetRelatorio(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDmProduto: TdmProduto;
begin
  LDmProduto := TdmProduto.Create(nil);
  try
    try
      Res.Send<TJSONObject>(LDmProduto.RelatorioProduto);
    finally
      Res.Status(200);
      FreeAndNil(LDmProduto);
    end;

  except
    on e: Exception do
    begin
      Res.Send(e.Message).Status(500);
      FreeAndNil(LDmProduto);
    end;
  end;
end;

end.
