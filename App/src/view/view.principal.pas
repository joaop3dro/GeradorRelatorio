unit view.principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Skia,
  FMX.Skia, FMX.Objects, FMX.Layouts, controller.pdf, System.Permissions, FMX.DialogService,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.IOUtils
{$IF Defined(ANDROID)}
  ,Androidapi.Helpers,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
  Androidapi.JNI.Provider,
  Androidapi.JNI.GraphicsContentViewText,
  FMX.Helpers.Android,
  Androidapi.JNI.Net,
  Androidapi.JNI.App,
  FMX.Platform.Android,
  Androidapi.JNI.Support,
  Androidapi.JNI.Util
{$ENDIF}
  ;

type
  TfrmViewPrincipal = class(TForm)
    Layout1: TLayout;
    SkLabel1: TSkLabel;
    Rectangle1: TRectangle;
    SkSvg1: TSkSvg;
    SkLabel2: TSkLabel;
    Layout2: TLayout;
    Rectangle2: TRectangle;
    SkSvg2: TSkSvg;
    SkLabel3: TSkLabel;
    SkAnimatedImage1: TSkAnimatedImage;
    Rectangle3: TRectangle;
    procedure Rectangle1Click(Sender: TObject);
    procedure Rectangle2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  {$IFDEF ANDROID}
    FPermissionReadExternalStorage: string;
    FPermissionWriteExternalStorage: string;
  {$ENDIF}

  {$IFDEF ANDROID}
    procedure DisplayRationale(Sender: TObject; const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
    procedure PermissionRequestResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
  {$ENDIF}

  public
    { Public declarations }
  end;

var
  frmViewPrincipal: TfrmViewPrincipal;

implementation

{$R *.fmx}

procedure TfrmViewPrincipal.FormCreate(Sender: TObject);
begin
//CASO PRECISA SOLICITAR PERMISSAO DO ANDROID
//{$IFDEF ANDROID}
//  FPermissionReadExternalStorage := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
//  FPermissionWriteExternalStorage := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
//{$ENDIF}
end;

procedure TfrmViewPrincipal.FormShow(Sender: TObject);
begin
//CASO PRECISA SOLICITAR PERMISSAO DO ANDROID
//{$IFDEF ANDROID}
//  PermissionsService.RequestPermissions
//    ([FPermissionReadExternalStorage, FPermissionWriteExternalStorage], PermissionRequestResult,
//    DisplayRationale);
//{$ENDIF}
end;

procedure TfrmViewPrincipal.Rectangle1Click(Sender: TObject);
begin
  Rectangle3.Visible := true;
  SkAnimatedImage1.Visible := true;

  TThread.CreateAnonymousThread(
    procedure
    begin

      controller.pdf.Baixar('relatorio clientes');
      controller.pdf.abrir('relatorio clientes');

      TThread.Synchronize(nil,
        procedure
        begin
          Rectangle3.Visible := false;
          SkAnimatedImage1.Visible := false;
        end);

    end).Start;

end;

procedure TfrmViewPrincipal.Rectangle2Click(Sender: TObject);
begin
  Rectangle3.Visible := true;
  SkAnimatedImage1.Visible := true;

  TThread.CreateAnonymousThread(
    procedure
    begin

      controller.pdf.Baixar('relatorio produtos');
      controller.pdf.abrir('relatorio produtos');

      TThread.Synchronize(nil,
        procedure
        begin
          Rectangle3.Visible := false;
          SkAnimatedImage1.Visible := false;
        end);

    end).Start;
end;

{$IFDEF ANDROID}
procedure TfrmViewPrincipal.PermissionRequestResult(Sender: TObject;
const APermissions: TClassicStringDynArray;
const AGrantResults: TClassicPermissionStatusDynArray);
begin
  if not((Length(AGrantResults) = 2) and (AGrantResults[0] = TPermissionStatus.Granted) and
    (AGrantResults[1] = TPermissionStatus.Granted)) then
    TDialogService.ShowMessage
      ('Você precisa liberar as permissões para utilizar o aplicativo')
  else
  begin
  end;
end;

procedure TfrmViewPrincipal.DisplayRationale(Sender: TObject;
const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
var
  i: integer;
  RationaleMsg: string;
begin

  for i := 0 to High(APermissions) do
  begin
{$IFDEF ANDROID}
    if APermissions[i] = FPermissionReadExternalStorage then
      RationaleMsg := RationaleMsg +
        'O aplicativo necessita de permissão para salvar relaórios no dispositivo' +
        SLineBreak
    else if APermissions[i] = FPermissionWriteExternalStorage then
      RationaleMsg := RationaleMsg +
        'O aplicativo necessita de para salvar relaórios no dispositivo';
{$ENDIF}
  end;

  TDialogService.ShowMessage(RationaleMsg,
    procedure(const AResult: TModalResult)
    begin
      APostRationaleProc;
    end)
end;
{$ENDIF}

end.
