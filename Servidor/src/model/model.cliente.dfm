inherited dmCliente: TdmCliente
  object qryClientes: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select'
      '  IDPESSOAS, RAZAOSOCIAL, ENDERECO, CEP'
      'from PESSOAS')
    Left = 64
    Top = 112
    object qryClientesIDPESSOAS: TIntegerField
      FieldName = 'IDPESSOAS'
      Origin = 'IDPESSOAS'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryClientesRAZAOSOCIAL: TStringField
      FieldName = 'RAZAOSOCIAL'
      Origin = 'RAZAOSOCIAL'
      Size = 100
    end
    object qryClientesENDERECO: TStringField
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 100
    end
    object qryClientesCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 50
    end
  end
  object frxClientes: TfrxReport
    Version = '2022.1.3'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45575.020890486100000000
    ReportOptions.LastChange = 45575.024648217590000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 64
    Top = 184
    Datasets = <
      item
        DataSet = dsClientes
        DataSetName = 'dsClientes'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo5: TfrxMemoView
          Align = baCenter
          AllowVectorExport = True
          Left = 243.779685000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELAT'#211'RIO DE CLIENTES')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 162.519790000000000000
        Width = 718.110700000000000000
        DataSet = dsClientes
        DataSetName = 'dsClientes'
        RowCount = 0
        object dsClientesIDPESSOAS: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 3.779530000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataField = 'IDPESSOAS'
          DataSet = dsClientes
          DataSetName = 'dsClientes'
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[dsClientes."IDPESSOAS"]')
        end
        object dsClientesRAZAOSOCIAL: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 56.692950000000000000
          Top = 3.779530000000000000
          Width = 257.008040000000000000
          Height = 18.897650000000000000
          DataField = 'RAZAOSOCIAL'
          DataSet = dsClientes
          DataSetName = 'dsClientes'
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsClientes."RAZAOSOCIAL"]')
        end
        object dsClientesENDERECO: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 325.039580000000000000
          Top = 3.779530000000000000
          Width = 260.787570000000000000
          Height = 18.897650000000000000
          DataField = 'ENDERECO'
          DataSet = dsClientes
          DataSetName = 'dsClientes'
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsClientes."ENDERECO"]')
        end
        object dsClientesCEP: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 597.165740000000000000
          Top = 3.779530000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'CEP'
          DataSet = dsClientes
          DataSetName = 'dsClientes'
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsClientes."CEP"]')
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 215.433210000000000000
        Width = 718.110700000000000000
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 109.606370000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 7.559060000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'C'#243'd.')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 56.692950000000000000
          Top = 7.559060000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Nome')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 325.039580000000000000
          Top = 7.559060000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Endere'#231'o')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 597.165740000000000000
          Top = 7.559060000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CEP')
          ParentFont = False
        end
      end
    end
  end
  object dsClientes: TfrxDBDataset
    UserName = 'dsClientes'
    CloseDataSource = False
    FieldAliases.Strings = (
      'IDPESSOAS=IDPESSOAS'
      'RAZAOSOCIAL=RAZAOSOCIAL'
      'ENDERECO=ENDERECO'
      'CEP=CEP')
    DataSet = qryClientes
    BCDToCurrency = False
    DataSetOptions = []
    Left = 160
    Top = 184
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EmbedFontsIfProtected = False
    InteractiveFormsFontSubset = 'A-Z,a-z,0-9,#43-#47 '
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    Creator = 'FastReport'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 264
    Top = 184
  end
end
