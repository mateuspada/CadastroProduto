unit UFuncoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Math, StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, Mask, ComCtrls, Buttons,
  Spin, Menus, IniFiles;

   Procedure Mensagem(wMensagem:String);
   Function IsInt(Texto:String): Boolean;
   Function fAtivaCampos(wForm:TForm; wState:Boolean; wTag:Integer):Boolean;
   Procedure fBotoes(wForm:tForm;wEstado:Integer);

implementation

Procedure Mensagem(wMensagem:String);
Begin
   MessageDlg(wMensagem,mtInformation,[Mbok],0);
End;

Function IsInt(Texto:String): Boolean;
var
   i:integer;
begin
   try
      i := StrToInt(Texto);
      Result := True;
   except
      Result := False;
   end;
end;

Function fAtivaCampos(wForm:TForm;wState:Boolean;wTag:Integer):Boolean;
Var
   I, J : Integer;
begin
   for I := 0 to wForm.ComponentCount -1 do
      Begin
          If wForm.Components[i].Tag = wTag then
             begin
                if wForm.Components[i] is TLabel then
                   TLabel(wForm.Components[i]).Enabled := wState
                Else if wForm.Components[i] is TGroupBox then
                   Begin
                      TGroupBox(wForm.Components[i]).Enabled    := wState;
                      If wState = False Then
                         TGroupBox(wForm.Components[i]).Font.Color := clGrayText
                      Else
                         TGroupBox(wForm.Components[i]).Font.Color := clNavy;
                   End
                else if wForm.Components[i] is TRadioGroup then
                   Begin
                      TRadioGroup(wForm.Components[i]).Enabled := wState;
                      If wState = False Then
                         TRadioGroup(wForm.Components[i]).Font.Color := clGrayText
                      Else
                         TRadioGroup(wForm.Components[i]).Font.Color := clNavy;
                   End
                else if wForm.Components[i] is TDBRadioGroup then
                   Begin
                      TDBRadioGroup(wForm.Components[i]).Enabled := wState;
                      If wState = False Then
                         TDBRadioGroup(wForm.Components[i]).Font.Color := clGrayText
                      Else
                         TDBRadioGroup(wForm.Components[i]).Font.Color := clNavy;
                   End
                else if wForm.Components[i] is TEdit then
                   TEdit(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TDBEdit then
                   TDBEdit(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TDBMemo then
                   TDBMemo(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TMemo then
                   TMemo(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TDBComboBox then
                   TDBComboBox(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TDBLookupComboBox then
                   TDBLookupComboBox(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TComboBox then
                   TComboBox(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TMaskEdit then
                   TMaskEdit(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TListBox then
                   TListBox(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TBitBtn then
                   TBitBtn(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TRadioButton then
                   tRadioButton(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TDateTimePicker then
                   tDateTimePicker(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TCheckBox then
                   tCheckBox(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TDBCheckBox then
                   tDBCheckBox(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TDBGrid then
                   tDBGrid(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TSpinEdit then
                   tSpinEdit(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TSpeedButton then
                   TBitBtn(wForm.Components[i]).Enabled := wState
                else if wForm.Components[i] is TButton then
                   TBitBtn(wForm.Components[i]).Enabled := wState;
             end;
      End;
end;

Procedure fBotoes(wForm:tForm;wEstado:Integer);
Var
   i:Integer;
begin
   For i := 0 to wForm.ComponentCount -1 do
      Begin
         If wEstado = 1 then  //Estado Normal
            Begin
               If wForm.Components[i] is TBitBtn then
                  Begin
                     If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDNOVO' then
                        TBitBtn(wForm.Components[i]).Enabled    := True
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDALTERA' then
                        TBitBtn(wForm.Components[i]).Enabled := True
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDCANCELA' then
                        TBitBtn(wForm.Components[i]).Enabled := False
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDCONFIRMA' then
                        TBitBtn(wForm.Components[i]).Enabled := False
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDEXCLUI' then
                        TBitBtn(wForm.Components[i]).Enabled := True
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDALTERASENHA' then
                        TBitBtn(wForm.Components[i]).Enabled := True
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDUSUARIOEMPRESA' then
                        TBitBtn(wForm.Components[i]).Enabled := True
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDSAIR' then
                        TBitBtn(wForm.Components[i]).Cancel := True
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDUSUARIO' then
                        TBitBtn(wForm.Components[i]).Enabled := True
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDIMPRIMIR' then
                        TBitBtn(wForm.Components[i]).Enabled := True;
                  End
               Else If wForm.Components[i] is TDBNavigator then
                  TDBNavigator(wForm.Components[i]).Enabled := True;
            End
         Else If wEstado = 2 then  //Estado Alteração
            Begin
               If wForm.Components[i] is TBitBtn then
                  Begin
                     If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDNOVO' then
                        TBitBtn(wForm.Components[i]).Enabled    := False
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDALTERA' then
                        TBitBtn(wForm.Components[i]).Enabled := False
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDCANCELA' then
                        Begin
                           TBitBtn(wForm.Components[i]).Enabled := True;
                           TBitBtn(wForm.Components[i]).Cancel  := True;
                        End
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDCONFIRMA' then
                        TBitBtn(wForm.Components[i]).Enabled := True
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDEXCLUI' then
                        TBitBtn(wForm.Components[i]).Enabled := False
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDALTERASENHA' then
                        TBitBtn(wForm.Components[i]).Enabled := False
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDUSUARIOEMPRESA' then
                        TBitBtn(wForm.Components[i]).Enabled := False
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDSAIR' then
                        TBitBtn(wForm.Components[i]).Cancel := False
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDUSUARIO' then
                        TBitBtn(wForm.Components[i]).Enabled := False
                     Else If UpperCase(TBitBtn(wForm.Components[i]).Name) = 'CMDIMPRIMIR' then
                        TBitBtn(wForm.Components[i]).Enabled := False;
                  End
               Else If wForm.Components[i] is TDBNavigator then
                  TDBNavigator(wForm.Components[i]).Enabled := False;
            End;
      End;
end;

end.

