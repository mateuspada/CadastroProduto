unit UMenuPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TMenuPrincipal = class(TForm)
    MainMenu: TMainMenu;
    MenuCadastro: TMenuItem;
    MenuCadastroProduto: TMenuItem;
    procedure MenuCadastroProdutoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MenuPrincipal: TMenuPrincipal;

implementation

{$R *.dfm}

uses UCadastroProduto;

procedure TMenuPrincipal.MenuCadastroProdutoClick(Sender: TObject);
begin
   try
      CadastroProduto := TCadastroProduto.Create(Self);
      CadastroProduto.ShowModal;
   finally
      FreeAndNil(CadastroProduto);
   end;
end;

end.
