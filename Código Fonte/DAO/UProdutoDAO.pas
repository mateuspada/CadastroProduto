unit UProdutoDAO;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, UProduto;

type
   TProdutoDAO = Class
   public
      constructor Create;
      destructor Destroy; override;

      function InsereProduto  (Query : TFDQuery; Produto : TProduto) : Boolean;
      function AlteraProduto  (Query : TFDQuery; Produto : TProduto) : Boolean;
      function ExcluirProduto (Query : TFDQuery; Produto : TProduto) : Boolean;
   End;

implementation

uses
   StrUtils, SysUtils, Dialogs;


{ TProdutoDAO }

function TProdutoDAO.AlteraProduto(Query: TFDQuery; Produto: TProduto): Boolean;
begin
   Result := False;

   try
      Query.ExecSQL('UPDATE Produto SET Nome = :wNome, Ativo = :Ativo WHERE codigo = :wCodigo',[Produto.Nome, Produto.Ativo, Produto.Codigo]);
   except
      Exit;
   end;

   Result := True;
end;

constructor TProdutoDAO.Create;
begin
//
end;

destructor TProdutoDAO.Destroy;
begin

  inherited;
end;

function TProdutoDAO.ExcluirProduto(Query: TFDQuery;
  Produto: TProduto): Boolean;
begin
   Result := False;

   try
      Query.ExecSQL('DELETE FROM Produto WHERE codigo = :wCodigo',[Produto.Codigo]);
   except
      Exit;
   end;

   Result := True;
end;

function TProdutoDAO.InsereProduto(Query: TFDQuery; Produto: TProduto): Boolean;
begin
   Result := False;

   try
      Query.ExecSQL('INSERT INTO Produto(Nome, Ativo) VALUES (:Nome,:Ativo)',[Produto.Nome, Produto.Ativo]);
      Query.Open('SELECT last_insert_rowid() Codigo');
      Produto.Codigo := Query.FieldByName('Codigo').AsInteger;
      Query.Close;
   except
      Exit;
   end;

   Result := True;
end;

end.
