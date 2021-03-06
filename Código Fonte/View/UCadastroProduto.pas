unit UCadastroProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCadastroPadrao, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask,
  Vcl.ExtCtrls, System.Generics.Collections, RTTI, UProduto, UProdutoController;

type
  TCadastroProduto = class(TCadastroPadrao)
    TabelaCodigo: TIntegerField;
    TabelaNome: TStringField;
    CampoNome: TEdit;
    Label1: TLabel;
    CampoAtivo: TCheckBox;
   function GetTitulo: String;Override;
    procedure FormShow(Sender: TObject);
    procedure DsTabelaDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure CmdConfirmaClick(Sender: TObject);
    procedure CmdNovoClick(Sender: TObject);
    procedure CmdCancelaClick(Sender: TObject);
    procedure TabDadosChanging(Sender: TObject; var AllowChange: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure CmdExcluiClick(Sender: TObject);
  private
    FListaProdutos: TObjectList<TProduto>;
    procedure PreencherLista;
    procedure AtualizaGrid(Produto : TProduto);
    procedure PreencherCampos(Produto: TProduto);
    function IncluirProduto(Dados: Array of Variant): TProduto;
  public
    { Public declarations }
  end;

var
  CadastroProduto: TCadastroProduto;

implementation

{$R *.dfm}

uses UBDados;

{ TCadastroProduto }

procedure TCadastroProduto.AtualizaGrid(Produto: TProduto);
begin
   if not (DsTabela.State in [dsInsert,dsEdit]) then
      (DsTabela.DataSet as TFDMemTable).Append;

   (DsTabela.DataSet as TFDMemTable).FieldByName('Codigo').AsInteger := Produto.Codigo;
   (DsTabela.DataSet as TFDMemTable).FieldByName('Nome').AsString    := Produto.Nome;
   (DsTabela.DataSet as TFDMemTable).Post;
end;

procedure TCadastroProduto.Button1Click(Sender: TObject);
begin
   inherited;
   ShowMessage(IntToStr(FListaProdutos.Last.Codigo));
end;

procedure TCadastroProduto.CmdCancelaClick(Sender: TObject);
begin
   inherited;
   If FListaProdutos.Last.Codigo = -1 then
      FListaProdutos.Remove(FListaProdutos.Last);

   PreencherCampos(FListaProdutos[(DsTabela.DataSet as TFDMemTable).RecNo - 1]);
end;

procedure TCadastroProduto.CmdConfirmaClick(Sender: TObject);
Var
   ProdutoController : TProdutoController;
   Prod : TProduto;
begin
   ProdutoController := TProdutoController.Create;

   If FListaProdutos.Last.Codigo = -1 Then
      Begin
         Prod := FListaProdutos.Last;
         (DsTabela.DataSet as TFDMemTable).Append;
      End
   Else
      Begin
         Prod := FListaProdutos[(DsTabela.DataSet as TFDMemTable).RecNo - 1];
         (DsTabela.DataSet as TFDMemTable).Edit;
      End;

   Prod.Nome  := CampoNome.Text;
   Prod.Ativo := CampoAtivo.Checked;

   try
      If ProdutoController.Salvar(Prod) Then
         AtualizaGrid(Prod)
      Else
         Begin
            ShowMessage('Falha ao salvar o Registro');
            CmdCancelaClick(Self);
         End;
   finally
      Begin
         FreeAndNil(ProdutoController);
      End;
   end;
  inherited;
end;

procedure TCadastroProduto.CmdExcluiClick(Sender: TObject);
Var
   ProdutoController : TProdutoController;
   Prod : TProduto;
begin
  inherited;
  If MessageDlg('Deseja realmente excluir o Produto?',mtConfirmation,[mbYes,mbNo],0,mbNo) = mrYes then
      Begin
         try
            ProdutoController := TProdutoController.Create;
            Prod := FListaProdutos[(DsTabela.DataSet as TFDMemTable).RecNo - 1];

            if ProdutoController.Deletar(Prod) then
               Begin
                  FListaProdutos.Remove(Prod);
                  Tabela.Delete;
               End
            Else
               ShowMessage('Falha ao excluir o Registro');
         finally
            FreeAndNil(ProdutoController);
         end;
      End;

   if (DsTabela.DataSet as TFDMemTable).RecordCount > 0 then
      PreencherCampos(FListaProdutos[(DsTabela.DataSet as TFDMemTable).RecNo - 1])
   Else
      Begin
         CampoCodigo.Text   := '';
         CampoNome.Text     := '';
         CampoAtivo.Checked := False;
      End;
end;

procedure TCadastroProduto.CmdNovoClick(Sender: TObject);
begin
   inherited;
   FListaProdutos.Add(TProduto.Create);
   PreencherCampos(FListaProdutos.Last);
end;

procedure TCadastroProduto.DsTabelaDataChange(Sender: TObject; Field: TField);
begin
  inherited;
   if (DsTabela.DataSet.RecordCount > 0) and not(DsTabela.State in [dsInsert,dsEdit]) then
      Begin
         PreencherCampos(FListaProdutos[(DsTabela.DataSet as TFDMemTable).RecNo - 1]);
      End;
end;

procedure TCadastroProduto.FormCreate(Sender: TObject);
begin
   AddCampoChave('CODIGO','C�digo');
   AddCampoChave('NOME','Nome Produto');

   inherited;
end;

procedure TCadastroProduto.FormShow(Sender: TObject);
begin
   inherited;
   FListaProdutos := TObjectList<TProduto>.Create;
   PreencherLista;
   (DsTabela.DataSet as TFDMemTable).First;
end;

function TCadastroProduto.GetTitulo: String;
begin
   Result := 'Cadastro de Produto';
end;

function TCadastroProduto.IncluirProduto(Dados: array of Variant): TProduto;
begin
   Result        := TProduto.Create;
   Result.Codigo := Dados[0];
   Result.Nome   := Dados[1];
   Result.Ativo  := Dados[2];
end;

procedure TCadastroProduto.PreencherCampos(Produto: TProduto);
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Valor: variant;
  Componente: TComponent;
begin
   Contexto := TRttiContext.Create;

   Tipo := Contexto.GetType(TProduto.ClassInfo);

   try
      for Propriedade in Tipo.GetProperties do
         begin
            Valor := Propriedade.GetValue(Produto).AsVariant;

            Componente := FindComponent('Campo' + Propriedade.Name);

            if Componente is TEdit then
              (Componente as TEdit).Text := Valor;

            if Componente is TCheckBox then
              (Componente as TCheckBox).Checked := Valor;
         end;
   finally
     Contexto.Free;
   end;
end;

procedure TCadastroProduto.PreencherLista;
Var
   Query : TFDQuery;
begin
   Query := TFDQuery.Create(Application);
   Query.Connection := BDados.BDados;

   try
      With Query Do
      Begin
         Open('SELECT * FROM Produto ORDER BY UPPER(NOME)');
         while not Eof do
            Begin
               FListaProdutos.Add(IncluirProduto([FieldByName('Codigo').AsInteger,
                                                  FieldByName('Nome').AsString,
                                                  FieldByName('Ativo').AsBoolean]));

               AtualizaGrid(FListaProdutos.Last);

               Next;
            End;

         Close;
      End;
   finally
      FreeAndNil(Query);
   end;
end;

procedure TCadastroProduto.TabDadosChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  if CmdConfirma.Enabled then
      AllowChange := False;
end;

end.
