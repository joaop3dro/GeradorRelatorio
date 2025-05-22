program AppRelatorio;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Skia,
  view.principal in 'src\view\view.principal.pas' {frmViewPrincipal},
  controller.pdf in 'src\controller\controller.pdf.pas';

{$R *.res}

begin
  GlobalUseSkia := True;
  Application.Initialize;
  Application.CreateForm(TfrmViewPrincipal, frmViewPrincipal);
  Application.Run;
end.
