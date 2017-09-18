unit UValidador;

interface

uses RTTI, Variants, StrUtils, SysUtils;

type
  TValidador = class(TCustomAttribute)
  private
    FDescricao: string;
  public
    constructor Create(const Descricao: string);

    function ValidarValor(Propriedade: TRttiProperty; Objeto: TObject): boolean;

    property Descricao: string read FDescricao;
  end;

implementation

{ TValidador }

constructor TValidador.Create(const Descricao: string);
begin
   FDescricao := Descricao;
end;

function TValidador.ValidarValor(Propriedade: TRttiProperty;
  Objeto: TObject): boolean;
var
  Valor: variant;
begin
  Valor := Propriedade.GetValue(Objeto).AsVariant;

  Result := (VarToStr(Valor) <> EmptyStr) and (VarToStr(Valor) <> '0');
end;

end.
