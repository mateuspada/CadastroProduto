unit UFormularioPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFormularioPadrao = class(TForm)
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetTitulo: String;Virtual;abstract;
  public
    { Public declarations }
  end;

var
  FormularioPadrao: TFormularioPadrao;

implementation

{$R *.dfm}

procedure TFormularioPadrao.FormCreate(Sender: TObject);
begin
   Self.Caption := GetTitulo;
end;

procedure TFormularioPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case key of
      VK_ESCAPE: Close;
      VK_RETURN:Perform(WM_NEXTDLGCTL,0,0);
   end;
end;

end.
