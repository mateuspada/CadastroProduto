program Sistema;

uses
  Vcl.Forms,
  UMenuPrincipal in 'View\UMenuPrincipal.pas' {MenuPrincipal},
  UBDados in 'DAO\UBDados.pas' {BDados: TDataModule},
  UProduto in 'Model\UProduto.pas',
  UProdutoDAO in 'DAO\UProdutoDAO.pas',
  UProdutoController in 'Controller\UProdutoController.pas',
  UValidador in 'Helper\UValidador.pas',
  UFormularioPadrao in 'View\UFormularioPadrao.pas' {FormularioPadrao},
  UCadastroPadrao in 'View\UCadastroPadrao.pas' {CadastroPadrao},
  UFuncoes in 'Helper\UFuncoes.pas',
  UCadastroProduto in 'View\UCadastroProduto.pas' {CadastroProduto},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Sky');
  Application.CreateForm(TBDados, BDados);
  Application.CreateForm(TMenuPrincipal, MenuPrincipal);
  Application.Run;
end.
