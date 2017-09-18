object CadastroProdutoExemplo: TCadastroProdutoExemplo
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Cadastro de Produto'
  ClientHeight = 571
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 152
    Width = 794
    Height = 419
    Align = alBottom
    DataSource = DsProduto
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button2: TButton
    Left = 56
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Insere'
    TabOrder = 1
    OnClick = Button2Click
  end
  object EdtNome: TEdit
    Left = 56
    Top = 97
    Width = 673
    Height = 21
    TabOrder = 2
  end
  object DsProduto: TDataSource
    DataSet = QueryProduto
    OnDataChange = DsProdutoDataChange
    Left = 88
    Top = 16
  end
  object QueryProduto: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 24
    Top = 16
    object QueryProdutoCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object QueryProdutoNome: TStringField
      FieldName = 'Nome'
      Size = 120
    end
    object QueryProdutoAtivo: TIntegerField
      FieldName = 'Ativo'
    end
  end
end
