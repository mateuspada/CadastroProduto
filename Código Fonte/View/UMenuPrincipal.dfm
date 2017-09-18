object MenuPrincipal: TMenuPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Menu Principal'
  ClientHeight = 551
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu: TMainMenu
    Left = 40
    Top = 8
    object MenuCadastro: TMenuItem
      Caption = 'Cadastro'
      object MenuCadastroProduto: TMenuItem
        Caption = 'Produto'
        OnClick = MenuCadastroProdutoClick
      end
    end
  end
end
