inherited CadastroProduto: TCadastroProduto
  Caption = 'Cadastro de Produto'
  ClientHeight = 273
  OnCreate = FormCreate
  ExplicitHeight = 302
  PixelsPerInch = 96
  TextHeight = 13
  inherited LblTitulo: TLabel
    Width = 276
    Caption = 'Cadastro de Produto'
    ExplicitWidth = 276
  end
  inherited TabDados: TPageControl
    Height = 213
    OnChanging = TabDadosChanging
    ExplicitHeight = 213
    inherited TabSheet1: TTabSheet
      ExplicitHeight = 185
      inherited FraCadastro: TPanel
        Height = 97
        ExplicitHeight = 97
        inherited Label2: TLabel
          Left = 10
          Top = 17
          ExplicitLeft = 10
          ExplicitTop = 17
        end
        object Label1: TLabel [1]
          Tag = 1
          Left = 80
          Top = 17
          Width = 33
          Height = 16
          Caption = 'Nome'
          FocusControl = CampoNome
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        inherited CampoCodigo: TEdit
          Left = 10
          Top = 36
          ExplicitLeft = 10
          ExplicitTop = 36
        end
        object CampoNome: TEdit
          Tag = 2
          Left = 80
          Top = 36
          Width = 593
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnKeyPress = CampoCodigoKeyPress
        end
        object CampoAtivo: TCheckBox
          Tag = 2
          Left = 679
          Top = 40
          Width = 58
          Height = 17
          Anchors = [akTop, akRight]
          Caption = 'Ativo'
          TabOrder = 2
        end
      end
      inherited FraRodape: TPanel
        Top = 103
        ExplicitTop = 103
        inherited FraBotoes: TPanel
          inherited FraAlinhamento: TPanel
            inherited CmdExclui: TBitBtn
              Left = 430
              ExplicitLeft = 430
            end
            inherited CmdConfirma: TBitBtn
              Left = 282
              ExplicitLeft = 282
            end
          end
        end
      end
    end
    inherited TabSheet2: TTabSheet
      ExplicitHeight = 185
      inherited Panel2: TPanel
        Height = 185
        ExplicitHeight = 185
        inherited Label5: TLabel
          Top = 140
          ExplicitTop = 140
        end
        inherited Label4: TLabel
          Top = 140
          ExplicitTop = 140
        end
        inherited grdLista: TDBGrid
          Height = 130
          Columns = <
            item
              Alignment = taCenter
              Color = clInfoBk
              Expanded = False
              FieldName = 'Codigo'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'C'#243'digo'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = []
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Nome'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clNavy
              Title.Font.Height = -11
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = []
              Width = 633
              Visible = True
            end>
        end
        inherited cmbChave: TComboBox
          Top = 155
          ExplicitTop = 155
        end
        inherited TxtPesquisa: TEdit
          Top = 155
          ExplicitTop = 155
        end
        inherited DBNavigator1: TDBNavigator
          Top = 155
          ExplicitTop = 155
        end
      end
    end
  end
  inherited StatusBar1: TStatusBar
    Top = 254
    ExplicitTop = 254
  end
  inherited DsTabela: TDataSource
    OnDataChange = DsTabelaDataChange
  end
  inherited Tabela: TFDMemTable
    object TabelaCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object TabelaNome: TStringField
      FieldName = 'Nome'
      Size = 120
    end
  end
end
