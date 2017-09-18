unit UProduto;

interface

Uses UValidador;

type
   TProduto = class
   private
      FCodigo : Integer;
      FNome : String;
      FAtivo : Boolean;
   public
      constructor Create;
      destructor Destroy; override;

      property Codigo : Integer read FCodigo write FCodigo;

      [TValidador('Nome do Produto')]
      property Nome : String read FNome write FNome;

      property Ativo : Boolean read FAtivo write FAtivo;
   end;

implementation

{ TProduto }

constructor TProduto.Create;
begin
   Self.Codigo := -1;
   Self.Nome   := '';
   Self.Ativo  := True;
end;

destructor TProduto.Destroy;
begin

  inherited;
end;

end.
