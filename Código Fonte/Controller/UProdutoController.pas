unit UProdutoController;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Forms, UProduto,
  UProdutoDAO, TypInfo, Variants, RTTI;

type
  TProdutoController = class
  public
    Function Salvar(Produto: TProduto) : Boolean;
    function Deletar(Produto : TProduto) : Boolean;
    procedure ValidarDados(Produto : TProduto);
  end;

implementation

uses
   StrUtils, SysUtils, Dialogs, UBDados, UValidador;

{ TProdutoController }

function TProdutoController.Deletar(Produto: TProduto): Boolean;
Var
   Query : TFDQuery;
   ProdutoDAO : TProdutoDAO;
begin
   Result := False;

   try
      Query := TFDQuery.Create(Application);
      Query.Connection := BDados.BDados;

      ProdutoDAO := TProdutoDAO.Create;

      if (ProdutoDAO.ExcluirProduto(Query,Produto)) then
         Result := True;
   finally
      Begin
         FreeAndNil(ProdutoDAO);
         FreeAndNil(Query);
      End;
   end;
end;

Function TProdutoController.Salvar(Produto: TProduto) : Boolean;
Var
   Query : TFDQuery;
   ProdutoDAO : TProdutoDAO;
begin
   Result := False;

   ValidarDados(Produto);

   try
      Query := TFDQuery.Create(Application);
      Query.Connection := BDados.BDados;

      ProdutoDAO := TProdutoDAO.Create;

      if (Produto.Codigo = -1) and (ProdutoDAO.InsereProduto(Query,Produto)) then
         Result := True
      Else if (ProdutoDAO.AlteraProduto(Query, Produto)) then
         Result := True;
   finally
      Begin
         FreeAndNil(ProdutoDAO);
         FreeAndNil(Query);
      End;
   end;
end;

procedure TProdutoController.ValidarDados(Produto : TProduto);
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
begin
   Contexto := TRttiContext.Create;

   Tipo := Contexto.GetType(TProduto.ClassInfo);

   for Propriedade in Tipo.GetProperties do
      begin
         for Atributo in Propriedade.GetAttributes do
            if Atributo is TValidador then
               if not TValidador(Atributo).ValidarValor(Propriedade, Produto) then
                  begin
                     ShowMessage('Valor não preenchido: ' + (Atributo as TValidador).Descricao);
                     Abort;
                  end;
      end;
end;

end.
