unit view.principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Horse, Horse.Jhonson, controller.cliente, controller.produto;

type
  TfrmViewPrincipal = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewPrincipal: TfrmViewPrincipal;

implementation

{$R *.dfm}

procedure TfrmViewPrincipal.FormCreate(Sender: TObject);
begin
  THorse.Create;
  THorse.Use(Jhonson());

  controller.cliente.Cliente;
  controller.produto.produto;

  THorse.Listen(9001);
end;

end.
