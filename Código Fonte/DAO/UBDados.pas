unit UBDados;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, IniFiles, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Comp.UI, StrUtils,
  VCL.Dialogs, Vcl.Forms, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TBDados = class(TDataModule)
    BDados: TFDConnection;
    SQLiteDriver: TFDPhysSQLiteDriverLink;
    WaitCursor: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
  private
    function ConfigurarIni : TIniFile;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BDados: TBDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UFuncoes;

{$R *.dfm}

function TBDados.ConfigurarIni: TIniFile;
Var
   wIni: TIniFile;
   wDatabase : String;
begin
   wIni := TInifile.Create(ExtractFilePath(GetModuleName(0)) + 'Sistema.ini');
   wDatabase := wIni.ReadString('CONEXAO','DATABASE','');

   If wDatabase = '' Then
      wIni.WriteString('CONEXAO','DATABASE', ExtractFilePath(GetModuleName(0)) + 'Sistema.db3');

   Result := wIni;
end;

procedure TBDados.DataModuleCreate(Sender: TObject);
Var
   wIni: TIniFile;
begin
   wIni := ConfigurarIni;
   BDados.Params.Values['DATABASE'] := wIni.ReadString('CONEXAO','DATABASE','');
   FreeAndNil(wIni);

   if FileExists(BDados.Params.Values['DATABASE']) then
      BDados.Connected := True
   Else
      Begin
         ShowMessage('Falha na conexão, verifique o caminho do banco de dados no arquivo Sistema.ini');
         Application.Terminate;
         Abort;
      End;
end;

end.
