unit controller.pdf;

interface

uses System.SysUtils, System.Classes, System.JSON, REST.Types, REST.Client,
  System.IOUtils, System.NetEncoding
  {$IFDEF ANDROID}
   , Androidapi.JNI.GraphicsContentViewText,
   Androidapi.JNI.JavaTypes, Androidapi.Helpers
  {$ENDIF};


 function Baixar(ATipoRelatorio: string): boolean;
 procedure Abrir(ATipoRelatorio: string);

implementation

uses FMX.Dialogs;

{ TConnection }


function Baixar(ATipoRelatorio: string): boolean;
var
  LArqLocal: string;
  LResult: string;
  LRESTClient: TRESTClient;
  LRESTRequest: TRESTRequest;
  LRESTResponse: TRESTResponse;
begin

  {$IFDEF MSWINDOWS}
  LArqLocal := GetCurrentDir + '\relatorios\' + ATipoRelatorio + '.pdf';
  {$ELSE}
  LArqLocal := TPath.Combine(TPath.GetDocumentsPath, ATipoRelatorio + '.pdf');
  {$ENDIF}


  if FileExists(LArqLocal) then
    DeleteFile(LArqLocal);

  LRESTClient:= TRESTClient.Create(nil);
  LRESTRequest:= TRESTRequest.Create(nil);
  LRESTResponse:= TRESTResponse.Create(nil);

  try
    LRESTRequest.Client:= LRESTClient;
    LRESTRequest.Response:= LRESTResponse;

    try

      if ATipoRelatorio = 'relatorio clientes' then
        LRESTClient.BaseURL := 'http://192.168.1.102:9001/relatorio/cliente'
      else
        LRESTClient.BaseURL := 'http://192.168.1.102:9001/relatorio/produto';

      LRESTRequest.Method := rmGET;
      LRESTRequest.Execute;

      LResult:= LRESTResponse.Content;
      Result:= LRESTResponse.StatusCode = 200;

      try

        TThread.Synchronize(nil,
        procedure
        var
          LJson: TJSONObject;
          LBase64:string;
          LStream: TBytesStream;

        begin

          LJson := TJSONObject.ParseJSONValue(LResult) as TJSONObject;

          LStream:= TBytesStream.Create(TNetEncoding.Base64.DecodeStringToBytes(LJson.GetValue<string>('arquivo')));
          try
            if Assigned(LStream) then
            begin
              LStream.Position := 0;
              LStream.SaveToFile(LArqLocal);
            end;

          finally
            FreeAndNil(LStream);
          end;

        end);

      finally
        result:= true;
      end;

    except
      on e: exception do
      begin
        Result := false;
      end;

    end;

  finally
    FreeAndNil(LRESTClient);
    FreeAndNil(LRESTRequest);
    FreeAndNil(LRESTResponse);
  end;

end;

procedure Abrir(ATipoRelatorio:string);
var
{$IFDEF ANDROID}
  LIntentJ : JIntent;
  LJArq : JFile;
{$ENDIF}
  LArqLocal:string;
begin
  {$IFDEF MSWINDOWS}
  LArqLocal := GetCurrentDir + '\relatorios\' + ATipoRelatorio + '.pdf';
  {$ELSE}
  LArqLocal := TPath.Combine(TPath.GetDocumentsPath, ATipoRelatorio + '.pdf');
  {$ENDIF}

  if not FileExists(LArqLocal) then
    ShowMessage('Arquivo não encontrado: ' + LArqLocal)
  else
  begin
    {$IFDEF ANDROID}
    LJArq := TJFile.JavaClass.init(StringToJString(LArqLocal));
    LIntentJ := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW);
    LIntentJ.setDataAndType(TAndroidHelper.JFileToJURI(LJArq), StringToJString('application/pdf'));
    LIntentJ.setFlags(TJIntent.JavaClass.FLAG_GRANT_READ_URI_PERMISSION);
    TAndroidHelper.Activity.startActivity(LIntentJ);
    {$ENDIF}
  end;
end;


end.
