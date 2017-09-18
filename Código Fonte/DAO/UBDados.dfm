object BDados: TBDados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 350
  Width = 621
  object BDados: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 48
    Top = 32
  end
  object SQLiteDriver: TFDPhysSQLiteDriverLink
    Left = 48
    Top = 88
  end
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 48
    Top = 144
  end
end
