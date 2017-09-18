unit UCadastroProdutoExemplo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, UProduto, System.Generics.Collections,
  System.Rtti;

type
  TCadastroProdutoExemplo = class(TForm)
    DBGrid1: TDBGrid;
    DsProduto: TDataSource;
    Button2: TButton;
    EdtNome: TEdit;
    QueryProduto: TFDMemTable;
    QueryProdutoCodigo: TIntegerField;
    QueryProdutoNome: TStringField;
    QueryProdutoAtivo: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DsProdutoDataChange(Sender: TObject; Field: TField);
    procedure FormDestroy(Sender: TObject);
  private
    FListaProdutos: TObjectList<TProduto>;
    procedure PreencherLista;
    //procedure PreencherDataSet;
    procedure PreencherCampos(Produto: TProduto);
    procedure AdicionarNaLista(Produto : TProduto);
    function IncluirProduto(Dados: Array of Variant): TProduto;
  public
    { Public declarations }
  end;

var
  CadastroProdutoExemplo: TCadastroProdutoExemplo;

implementation

{$R *.dfm}

uses UBDados, UProdutoController;

procedure TCadastroProdutoExemplo.AdicionarNaLista(Produto: TProduto);
begin
   FListaProdutos.Add(Produto);

   QueryProduto.Append;
   QueryProduto.FieldByName('Codigo').AsInteger := Produto.Codigo;
   QueryProduto.FieldByName('Nome').AsString    := Produto.Nome;
   QueryProduto.FieldByName('Ativo').AsBoolean  := Produto.Ativo;
   QueryProduto.Post;
end;

procedure TCadastroProdutoExemplo.Button2Click(Sender: TObject);
Var
   ProdutoController : TProdutoController;
   Prod : TProduto;
begin 
   ProdutoController := TProdutoController.Create;
   Prod := TProduto.Create;

   Prod.Nome := EdtNome.Text;

   try
      If ProdutoController.Salvar(Prod) Then
         Begin
            AdicionarNaLista(Prod);
         End;
   finally
      Begin
         FreeAndNil(ProdutoController);
      End;
   end;
end;

procedure TCadastroProdutoExemplo.DsProdutoDataChange(Sender: TObject; Field: TField);
begin
  if (DsProduto.DataSet.RecordCount > 0) and not(DsProduto.State in [dsInsert,dsEdit]) then
   Begin
      PreencherCampos(FListaProdutos[QueryProduto.RecNo - 1]);
   End;
end;

procedure TCadastroProdutoExemplo.FormCreate(Sender: TObject);
begin
   FListaProdutos := TObjectList<TProduto>.Create;
   QueryProduto.Open;
   PreencherLista;
   QueryProduto.First;
end;

procedure TCadastroProdutoExemplo.FormDestroy(Sender: TObject);
begin
   FListaProdutos.Free;
end;

function TCadastroProdutoExemplo.IncluirProduto(Dados: array of Variant): TProduto;
begin
   Result        := TProduto.Create;
   Result.Codigo := Dados[0];
   Result.Nome   := Dados[1];
   Result.Ativo  := Dados[2];
end;

procedure TCadastroProdutoExemplo.PreencherCampos(Produto: TProduto);
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

            Componente := FindComponent('Edt' + Propriedade.Name);

            if Componente is TEdit then
              (Componente as TEdit).Text := Valor;

            if Componente is TCheckBox then
              (Componente as TCheckBox).Checked := Valor;
         end;
   finally
     Contexto.Free;
   end;
end;

(*procedure TCadastroProduto.PreencherDataSet;
var
  Contexto        : TRttiContext;
  Tipo            : TRttiType;
  PCodigo, PNome, PAtivo : TRttiProperty;
  Prod            : TProduto;
  //Values          : Array of TVarRec;
begin
  Contexto := TRttiContext.Create;
  try
    Tipo := Contexto.GetType(TProduto.ClassInfo);

    PCodigo := Tipo.GetProperty('Codigo');
    PNome   := Tipo.GetProperty('Nome');
    PAtivo  := Tipo.GetProperty('Ativo');

    for Prod in FListaProdutos do
      QueryProduto.AppendRecord([PCodigo.GetValue(Prod).AsInteger,
                                 PNome.GetValue(Prod).AsString,
                                 PAtivo.GetValue(Prod).AsInteger]);


    {for Prod in FListaProdutos do
      Begin
        for Propriedade in Tipo.GetProperties do
          Begin
             SetLength(Values,Length(Values) + 1);
             Values[Length(Values) - 1] := Propriedade.GetValue(Prod).AsVarRec;
          End;

        QueryProduto.AppendRecord(Values);
        SetLength(Values,0);
      End;}

    QueryProduto.First;
  finally
    Contexto.Free;
  end;
end;*)

procedure TCadastroProdutoExemplo.PreencherLista;
Var
   Query : TFDQuery;
begin
   Query := TFDQuery.Create(Application);
   Query.Connection := BDados.BDados;

   try
      With Query Do
      Begin
         Open('SELECT * FROM Produto ORDER BY CODIGO');
         while not Eof do
            Begin
               AdicionarNaLista(IncluirProduto([FieldByName('Codigo').AsInteger,
                                                  FieldByName('Nome').AsString,
                                                  FieldByName('Ativo').AsInteger]));

               Next;
            End;

         Close;
      End;
   finally
      FreeAndNil(Query);
   end;
end;

end.
