object FrmrelClientes: TFrmrelClientes
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Clientes'
  ClientHeight = 680
  ClientWidth = 1035
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 639
    Width = 1035
    Height = 41
    Align = alBottom
    TabOrder = 0
    object Btn_relatorio: TButton
      Left = 16
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Relat'#243'rio'
      TabOrder = 0
      OnClick = Btn_relatorioClick
    end
    object Btn_Fechar: TButton
      Left = 96
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = Btn_FecharClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1035
    Height = 177
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Rgb_Filtro: TRadioGroup
      Left = 16
      Top = 16
      Width = 205
      Height = 120
      Caption = 'Tipo de filtro'
      Items.Strings = (
        'Todos os clientes'
        'Clientes por Data de nascimento'
        'Clientes por Cidade'
        'Clientes por Estado')
      TabOrder = 0
      OnClick = Rgb_FiltroClick
    end
    object Gb_periodo: TGroupBox
      Left = 227
      Top = 16
      Width = 200
      Height = 120
      Caption = 'Data de nascimento'
      TabOrder = 1
      object lblDataInicial: TLabel
        Left = 16
        Top = 24
        Width = 61
        Height = 15
        Caption = 'Data Inicial:'
      end
      object lblDataFinal: TLabel
        Left = 16
        Top = 72
        Width = 55
        Height = 15
        Caption = 'Data Final:'
      end
      object dtpDataInicial: TDateTimePicker
        Left = 16
        Top = 40
        Width = 150
        Height = 21
        Date = 44897.000000000000000000
        Time = 0.500000000000000000
        TabOrder = 0
      end
      object dtpDataFinal: TDateTimePicker
        Left = 16
        Top = 88
        Width = 150
        Height = 21
        Date = 44927.000000000000000000
        Time = 0.500000000000000000
        TabOrder = 1
      end
    end
    object Gb_Cidades: TGroupBox
      Left = 436
      Top = 16
      Width = 200
      Height = 56
      Caption = 'Cidade'
      TabOrder = 2
      object lblCidade: TLabel
        Left = 12
        Top = 13
        Width = 40
        Height = 15
        Caption = 'Cidade:'
      end
      object CMB_cidades: TDBLookupComboBox
        Left = 12
        Top = 28
        Width = 167
        Height = 23
        KeyField = 'ID'
        ListField = 'Nome'
        TabOrder = 0
      end
    end
    object Gb_Estados: TGroupBox
      Left = 436
      Top = 78
      Width = 200
      Height = 58
      Caption = 'Estados'
      TabOrder = 3
      object CMB_Estado: TDBLookupComboBox
        Left = 12
        Top = 24
        Width = 167
        Height = 23
        KeyField = 'ID'
        ListField = 'Nome'
        TabOrder = 0
      end
    end
    object btn_filtrar: TButton
      Left = 16
      Top = 142
      Width = 75
      Height = 25
      Caption = 'Filtrar'
      TabOrder = 4
      OnClick = btn_filtrarClick
    end
  end
  object GrdClientes: TDBGrid
    Left = 0
    Top = 177
    Width = 1035
    Height = 462
    Align = alClient
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NOME_CLIENTE'
        Title.Caption = 'Nome'
        Width = 281
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CEP'
        Width = 119
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CPF_CNPJ'
        Title.Caption = 'CPF/CNPJ'
        Width = 136
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENDERECO'
        Title.Caption = 'Endere'#231'o'
        Width = 304
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMERO'
        Title.Caption = 'N'#250'mero'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COMPLEMENTO'
        Title.Caption = 'Complemento'
        Width = 349
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BAIRRO'
        Title.Caption = 'Bairro'
        Width = 186
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CIDADE'
        Title.Caption = 'Cidade'
        Width = 177
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_ESTADO'
        Title.Caption = 'Estado'
        Width = 187
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATANASCIMENTO'
        Title.Caption = 'Data de nascimento'
        Width = 133
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID'
        Visible = False
      end>
  end
  object ppDBPipeline1: TppDBPipeline
    UserName = 'DBPipeline1'
    Left = 920
    Top = 36
  end
  object ppReport1: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline1
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4 (210 x 297 mm)'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 9
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    EmailSettings.ConnectionSettings.MailService = 'SMTP'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RefreshTokenLifeSpan = 365
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RefreshTokenLifeSpan = 365
    EmailSettings.ConnectionSettings.EnableMultiPlugin = False
    EmailSettings.ConnectionSettings.ConnectionStatusInfo = [csiStatusBar]
    LanguageID = 'Default'
    OpenFile = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    ThumbnailSettings.PageHighlight.Width = 3
    ThumbnailSettings.ThumbnailSize = tsSmall
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.AllowExtract = True
    PDFSettings.EncryptSettings.AllowAssemble = True
    PDFSettings.EncryptSettings.AllowQualityPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.EncryptSettings.EncryptionType = etRC4
    PDFSettings.DigitalSignatureSettings.SignPDF = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    PDFSettings.PDFAFormat = pafNone
    PDFSettings.Layers = False
    PDFSettings.Outline = False
    PreviewFormSettings.PageBorder.mmPadding = 0
    PreviewFormSettings.WindowState = wsMaximized
    RTFSettings.AppName = 'ReportBuilder'
    RTFSettings.Author = 'ReportBuilder'
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    RTFSettings.Title = 'Report'
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<Texto a localizar>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    XLSSettings.WorksheetName = 'Report'
    CloudDriveSettings.DropBoxSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.DropBoxSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.DropBoxSettings.DirectorySupport = True
    CloudDriveSettings.DropBoxSettings.SharedResources = True
    CloudDriveSettings.GoogleDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.GoogleDriveSettings.DirectorySupport = False
    CloudDriveSettings.GoogleDriveSettings.SharedResources = False
    CloudDriveSettings.OneDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.OneDriveSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.OneDriveSettings.DirectorySupport = True
    CloudDriveSettings.OneDriveSettings.SharedResources = True
    Left = 920
    Top = 108
    Version = '23.01'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline1'
    object ppHeaderBand1: TppHeaderBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 33338
      mmPrintPosition = 0
      object lbtitulo: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lbtitulo'
        Border.mmPadding = 0
        Caption = 'Relat'#243'rio de Clientes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 24
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 9790
        mmLeft = 55827
        mmTop = 9525
        mmWidth = 85196
        BandType = 0
        LayerName = Foreground
      end
      object paginacao: TppSystemVariable
        DesignLayer = ppDesignLayer1
        UserName = 'paginacao'
        Border.mmPadding = 0
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 173832
        mmTop = 7144
        mmWidth = 18785
        BandType = 0
        LayerName = Foreground
      end
      object data: TppSystemVariable
        DesignLayer = ppDesignLayer1
        UserName = 'data'
        Border.mmPadding = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 178330
        mmTop = 1852
        mmWidth = 14287
        BandType = 0
        LayerName = Foreground
      end
      object ppLine1: TppLine
        DesignLayer = ppDesignLayer1
        UserName = 'Line1'
        Border.mmPadding = 0
        Weight = 0.750000000000000000
        mmHeight = 3969
        mmLeft = -265
        mmTop = 26480
        mmWidth = 198173
        BandType = 0
        LayerName = Foreground
      end
      object ppLine2: TppLine
        DesignLayer = ppDesignLayer1
        UserName = 'Line2'
        Border.mmPadding = 0
        Weight = 0.750000000000000000
        mmHeight = 5556
        mmLeft = 2
        mmTop = 32822
        mmWidth = 197643
        BandType = 0
        LayerName = Foreground
      end
      object lbId: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lbId'
        Border.mmPadding = 0
        Caption = 'Id'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 1588
        mmTop = 28067
        mmWidth = 2645
        BandType = 0
        LayerName = Foreground
      end
      object LbNome: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'LbNome'
        Border.mmPadding = 0
        Caption = 'Nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 11642
        mmTop = 28067
        mmWidth = 8466
        BandType = 0
        LayerName = Foreground
      end
      object LbCPF_CNPJ: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'LbCPF_CNPJ'
        Border.mmPadding = 0
        Caption = 'CPF/CNPJ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 55872
        mmTop = 28067
        mmWidth = 13758
        BandType = 0
        LayerName = Foreground
      end
      object LbCEP: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'LbCEP'
        Border.mmPadding = 0
        Caption = 'CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 88681
        mmTop = 28067
        mmWidth = 5556
        BandType = 0
        LayerName = Foreground
      end
      object LbBairro: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'LbBairro'
        Border.mmPadding = 0
        Caption = 'Bairro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 115404
        mmTop = 28067
        mmWidth = 8731
        BandType = 0
        LayerName = Foreground
      end
      object LbCidade: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'LbCidade'
        Border.mmPadding = 0
        Caption = 'Cidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 144508
        mmTop = 28067
        mmWidth = 10054
        BandType = 0
        LayerName = Foreground
      end
      object LbEstado: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label101'
        Border.mmPadding = 0
        Caption = 'Estado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 180491
        mmTop = 28067
        mmWidth = 9790
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 7144
      mmPrintPosition = 0
      object DtNome: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DtNome'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'NOME'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3704
        mmLeft = 11642
        mmTop = 1323
        mmWidth = 7673
        BandType = 4
        LayerName = Foreground
      end
      object Dtid: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'Dtid'
        Border.mmPadding = 0
        DataField = 'ID'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3704
        mmLeft = 0
        mmTop = 1323
        mmWidth = 5281
        BandType = 4
        LayerName = Foreground
      end
      object DtCPF_CNPJ: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DtCPF_CNPJ'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CPF_CNPJ'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3704
        mmLeft = 55827
        mmTop = 1323
        mmWidth = 13229
        BandType = 4
        LayerName = Foreground
      end
      object DtCEP: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DtCEP'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CEP'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3704
        mmLeft = 88636
        mmTop = 1323
        mmWidth = 5027
        BandType = 4
        LayerName = Foreground
      end
      object DtBairro: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DtBairro'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'Bairro'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3704
        mmLeft = 115359
        mmTop = 1323
        mmWidth = 7672
        BandType = 4
        LayerName = Foreground
      end
      object DtCidade: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DtCidade'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'Cidade'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3704
        mmLeft = 144463
        mmTop = 1323
        mmWidth = 8731
        BandType = 4
        LayerName = Foreground
      end
      object DtEstado: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DtEstado'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'Estado'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3704
        mmLeft = 180446
        mmTop = 1323
        mmWidth = 8731
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppFooterBand1: TppFooterBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 16933
      mmPrintPosition = 0
      object LbURL: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'LbURL'
        Border.mmPadding = 0
        Caption = 'https://github.com/TrajanoDeveloper/Projetos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 63236
        mmTop = 1588
        mmWidth = 66146
        BandType = 8
        LayerName = Foreground
      end
      object LbEndereco: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'LbEndereco'
        Border.mmPadding = 0
        Caption = 'www.linkedin.com/in/alexandre-trajano-b3417a39'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 61383
        mmTop = 7673
        mmWidth = 71174
        BandType = 8
        LayerName = Foreground
      end
    end
    object ppDesignLayers1: TppDesignLayers
      object ppDesignLayer1: TppDesignLayer
        UserName = 'Foreground'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
end
