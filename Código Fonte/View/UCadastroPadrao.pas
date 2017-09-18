unit UCadastroPadrao;

interface

//Cor Azul = $00D1621F
//azul claro = $00CE9E0F - $00DFAC11

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, System.Threading,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls, UFormularioPadrao,themes,
  Vcl.Menus;

type
  TCadastroPadrao = class(TFormularioPadrao)
    Shape1: TShape;
    TabDados: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    LblTitulo: TLabel;
    DsTabela: TDataSource;
    FraCadastro: TPanel;
    Label2: TLabel;
    Panel2: TPanel;
    grdLista: TDBGrid;
    cmbChave: TComboBox;
    TxtPesquisa: TEdit;
    Label5: TLabel;
    Label4: TLabel;
    DBNavigator1: TDBNavigator;
    StatusBar1: TStatusBar;
    FraRodape: TPanel;
    FraNav: TPanel;
    DBNavPadrao: TDBNavigator;
    FraBotoes: TPanel;
    FraAlinhamento: TPanel;
    CmdSair: TBitBtn;
    CmdExclui: TBitBtn;
    CmdConfirma: TBitBtn;
    CmdCancela: TBitBtn;
    CmdAltera: TBitBtn;
    CmdNovo: TBitBtn;
    Tabela: TFDMemTable;
    CampoCodigo: TEdit;
    procedure CmdNovoClick(Sender: TObject);
    procedure CmdAlteraClick(Sender: TObject);
    procedure CmdCancelaClick(Sender: TObject);
    procedure CmdExcluiClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure grdListaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CampoCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TxtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdListaDblClick(Sender: TObject);
    procedure CmdConfirmaClick(Sender: TObject);
    Procedure CarregaChaves;
    procedure cmbChaveClick(Sender: TObject);
    procedure TxtPesquisaChange(Sender: TObject);
    Procedure AddCampoChave(wCampo,wDescricao:String);
    procedure CmdSairClick(Sender: TObject);
  private
    { Private declarations }
  Protected
    wChave : Array of Array Of String;
  public
    { Public declarations }
  end;

var
  CadastroPadrao: TCadastroPadrao;

implementation

{$R *.dfm}

uses UMenuPrincipal, UBDados, UFuncoes;

procedure TCadastroPadrao.AddCampoChave(wCampo, wDescricao: String);
Var
   I : Integer;
begin
   I := Length(wChave);
   SetLength(wChave,I + 1);
   SetLength(wChave[I],2);
   wChave[I,0] := wCampo;
   wChave[I,1] := wDescricao;
end;

procedure TCadastroPadrao.CarregaChaves;
Var
   I : Integer;
begin
   for I := 0 to Length(wChave)-1 do
      Begin
         if wChave[I,1] <> '' then
            cmbChave.Items.Add(wChave[I,1]);
      End;
end;

procedure TCadastroPadrao.cmbChaveClick(Sender: TObject);
begin
   (DsTabela.DataSet as TFDMemTable).IndexFieldNames := wChave[cmbChave.ItemIndex ,0];
   TxtPesquisa.Text       := '';
   TxtPesquisa.SetFocus;
end;

procedure TCadastroPadrao.CmdAlteraClick(Sender: TObject);
begin
   If ((DsTabela.DataSet as TFDMemTable).Eof) and ((DsTabela.DataSet as TFDMemTable).Bof) then Abort;

   fAtivaCampos(Self, True, 2);
   fBotoes(Self,2);
end;

procedure TCadastroPadrao.CmdCancelaClick(Sender: TObject);
begin
   fAtivaCampos(Self, False, 1);
   fAtivaCampos(Self, False, 2);
   fBotoes(Self,1);
end;

procedure TCadastroPadrao.CmdConfirmaClick(Sender: TObject);
begin
   fAtivaCampos(Self, False, 1);
   fAtivaCampos(Self, False, 2);
   fBotoes(Self,1);
end;

procedure TCadastroPadrao.CmdExcluiClick(Sender: TObject);
begin
   If ((DsTabela.DataSet as TFDMemTable).Eof) and ((DsTabela.DataSet as TFDMemTable).Bof) then Abort;
end;

procedure TCadastroPadrao.CmdNovoClick(Sender: TObject);
begin
   fAtivaCampos(Self, True, 1);
   fAtivaCampos(Self, True, 2);
   fBotoes(Self,2);
end;

procedure TCadastroPadrao.CmdSairClick(Sender: TObject);
begin
  inherited;
   Close;
end;

procedure TCadastroPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   (DsTabela.DataSet as TFDMemTable).Close;
   wChave := Nil;
end;

procedure TCadastroPadrao.FormShow(Sender: TObject);
begin
   CarregaChaves;

   (DsTabela.DataSet as TFDMemTable).Open;
   TabDados.ActivePageIndex := 0;
   fAtivaCampos(Self, False, 1);
   fAtivaCampos(Self, False, 2);
   fBotoes(Self, 1);
   LblTitulo.Caption := GetTitulo;
   Self.Caption      := '';
end;

procedure TCadastroPadrao.grdListaDblClick(Sender: TObject);
begin
   TabDados.TabIndex := 0;
end;

procedure TCadastroPadrao.grdListaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   If Key = 27 Then
      Close;
end;

procedure TCadastroPadrao.TabSheet1Show(Sender: TObject);
begin
   if cmdNovo.Visible then
      cmdNovo.SetFocus;
end;

procedure TCadastroPadrao.TabSheet2Show(Sender: TObject);
begin
   if cmbChave.ItemIndex = -1 then
      cmbChave.ItemIndex := 1;

   TxtPesquisa.Text   := '';
   TxtPesquisa.SetFocus;
end;

procedure TCadastroPadrao.CampoCodigoKeyPress(Sender: TObject; var Key: Char);
begin
   If Key = #13 Then
      Key := #0;
end;

procedure TCadastroPadrao.TxtPesquisaChange(Sender: TObject);
begin
   If TxtPesquisa.Text <> '' Then
      Begin
         If Tabela.FieldByName(wChave[cmbChave.ItemIndex,0]).DataType  = ftDateTime then
            Begin
               if (Length(TxtPesquisa.Text) = 7) or (Length(TxtPesquisa.Text) = 9) then
                  (DsTabela.DataSet as TFDMemTable).Locate(wChave[cmbChave.ItemIndex,0],TxtPesquisa.Text,[loPartialKey,loCaseInsensitive]);
            End
         Else If Tabela.FieldByName(wChave[cmbChave.ItemIndex,0]).DataType = ftInteger then
            Begin
               if IsInt(TxtPesquisa.Text) then
                  (DsTabela.DataSet as TFDMemTable).Locate(wChave[cmbChave.ItemIndex,0],TxtPesquisa.Text,[loPartialKey,loCaseInsensitive])
               Else
                  TxtPesquisa.Text := '';
            End
         Else If Tabela.FieldByName(wChave[cmbChave.ItemIndex,0]).DataType = ftBCD then
            Begin
               if IsInt(TxtPesquisa.Text) then
                  (DsTabela.DataSet as TFDMemTable).Locate(wChave[cmbChave.ItemIndex,0],TxtPesquisa.Text,[loPartialKey,loCaseInsensitive])
               Else
                  TxtPesquisa.Text := '';
            End
         Else
            (DsTabela.DataSet as TFDMemTable).Locate(wChave[cmbChave.ItemIndex,0],TxtPesquisa.Text,[loPartialKey,loCaseInsensitive]);
      End
   Else
      (DsTabela.DataSet as TFDMemTable).First;
end;

procedure TCadastroPadrao.TxtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   If Key = 27 Then
      Close
   Else if(key=vk_return)or(key=vk_down)then TabDados.TabIndex := 0;
end;

end.
