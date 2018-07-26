object IWUserSession: TIWUserSession
  OldCreateOrder = False
  Height = 238
  Width = 385
  object ConexaoBD: TFDConnection
    Params.Strings = (
      'Server=tdevrocks.ddns.com.br'
      'Port=53306'
      'Database=curso'
      'User_Name=curso'
      'Password=s32]4]381a'
      'DriverID=MySQL')
    ResourceOptions.AssignedValues = [rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 8
  end
  object FDQQuery: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'Select * from Clientes')
    Left = 56
    Top = 72
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 144
    Top = 8
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 256
    Top = 8
  end
end
