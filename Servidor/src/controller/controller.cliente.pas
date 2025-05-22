unit controller.cliente;

interface

uses Horse, System.JSON, model.cliente;

procedure Cliente;
procedure GetRelatorio(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses
  System.SysUtils;

procedure Cliente;
begin
  THorse.Get('/relatorio/cliente',GetRelatorio);
end;

procedure GetRelatorio(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LdmCliente: TdmCliente;
begin
  LdmCliente := TdmCliente.Create(nil);
  try
    try
      Res.Send<TJSONObject>(LdmCliente.RelatorioCliente);
    finally
      Res.Status(200);
      FreeAndNil(LdmCliente);
    end;

  except
    on e: Exception do
    begin
      Res.Send(e.Message).Status(500);
      FreeAndNil(LdmCliente);
    end;
  end;
end;

end.
