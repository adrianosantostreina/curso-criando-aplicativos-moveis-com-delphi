object Paciente: TPaciente
  OldCreateOrder = False
  Height = 309
  Width = 579
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\lande\Documents\Embarcadero\Studio\Projects\Ba' +
        'ria\BD\ACBar.GDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Port=3052'
      'Server=localhost'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 72
    Top = 32
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorLib = 'C:\Windows\System32\fbclient.dll'
    Left = 152
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 336
    Top = 32
  end
  object fdqDados: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select caso, nome, altura, pesoatual, pesoinicial, '
      'pesoideal, imc from dados ')
    Left = 64
    Top = 88
    object fdqDadosCASO: TIntegerField
      FieldName = 'CASO'
      Origin = 'CASO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object fdqDadosNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
    object fdqDadosALTURA: TBCDField
      FieldName = 'ALTURA'
      Origin = 'ALTURA'
      Precision = 18
      Size = 2
    end
    object fdqDadosPESOATUAL: TBCDField
      FieldName = 'PESOATUAL'
      Origin = 'PESOATUAL'
      Precision = 18
      Size = 2
    end
    object fdqDadosPESOINICIAL: TBCDField
      FieldName = 'PESOINICIAL'
      Origin = 'PESOINICIAL'
      Precision = 18
      Size = 2
    end
    object fdqDadosPESOIDEAL: TBCDField
      FieldName = 'PESOIDEAL'
      Origin = 'PESOIDEAL'
      Precision = 18
      Size = 2
    end
    object fdqDadosIMC: TBCDField
      FieldName = 'IMC'
      Origin = 'IMC'
      Precision = 18
      Size = 2
    end
  end
  object FDUpdateSQL1: TFDUpdateSQL
    Connection = FDConnection1
    InsertSQL.Strings = (
      'INSERT INTO DADOS'
      '(CASO, NOME)'
      'VALUES (:NEW_CASO, :NEW_NOME)'
      'RETURNING CASO, NOME')
    ModifySQL.Strings = (
      'UPDATE DADOS'
      'SET CASO = :NEW_CASO, NOME = :NEW_NOME'
      'WHERE CASO = :OLD_CASO'
      'RETURNING CASO, NOME')
    DeleteSQL.Strings = (
      'DELETE FROM DADOS'
      'WHERE CASO = :OLD_CASO')
    FetchRowSQL.Strings = (
      
        'SELECT CASO, NOME, IDADE, DATANASC, SEXO, RACA, RG, PESOINICIAL,' +
        ' ALTURA, '
      '  PESOATUAL, TEMPOOBES, PESOIDEAL, CINTURA, QUADRIL, DIABETES, '
      '  INSUFCARDIACA, ARRITIMIAS, APNEIASONO, FASE, ARTROSEJOELHOS, '
      '  PATOLOGIACOLUNA, DISMENORREIA, HIPOTIROIDISMO, VARIZESMMII, '
      
        '  DEPRESSSAO, COLELITIASE, ESTERILIDADE, HIPERTARTERIAL, CORONAR' +
        'IOPATIA, '
      
        '  DISPNEIA, BRONQUITEASMA, ARTOSETORNOZELO, DOENCAHEMORROIDARIA,' +
        ' '
      
        '  HIRSUTISMO, HIPERTIROIDISMO, DRGE, TRANSTCOMERCOMP, ANTECCIRUR' +
        'COLECISTECTOMIA, '
      
        '  ANTECCIRURDERMOLIPECTOMIA, ANTECCIRURMAMOPLASTIA, ANTECCIRURCE' +
        'SARIA, '
      
        '  ANTECCIRURCESARIAQUANTAS, ANTECCIRUROUTRAS, TENTTRATCLINDIETA,' +
        ' '
      '  TENTTRATCLINDIETAQUAIS, TENTTRATCLINEXERC, TENTTRATCLINMEDIC, '
      
        '  TENTTRATCLINMEDICQUAIS, TENTTRATCLINMEDICQUANTAS, TENTTRATCLIN' +
        'MEDICINTOL, '
      
        '  TENTTRATCLINMEDICINTOLQUAIS, TENTTRATCLINSPA, TENTTRATCLINSPAQ' +
        'UANTAS, '
      '  PESOMAXIMOATINGIDO, PESOANTES, DATAULTCONS, EMAGRECMAXIMOKG, '
      '  EMAGRECMAXIMOTEMPO, EXAME, IMC, IMCMAXIMO'
      'FROM DADOS'
      'WHERE CASO = :CASO')
    Left = 72
    Top = 160
  end
  object fdqExames: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select caso,data,glicemia,'
      'colesteroltotal,hdl,ldl, triglicerides '#13#10#10
      'from exames '
      'where caso=:parCaso'
      'order by data')
    Left = 136
    Top = 88
    ParamData = <
      item
        Name = 'PARCASO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object fdqExamesCASO: TIntegerField
      FieldName = 'CASO'
      Origin = 'CASO'
      Required = True
    end
    object fdqExamesDATA: TDateField
      FieldName = 'DATA'
      Origin = '"DATA"'
      Required = True
    end
    object fdqExamesGLICEMIA: TBCDField
      FieldName = 'GLICEMIA'
      Origin = 'GLICEMIA'
      Precision = 18
      Size = 2
    end
    object fdqExamesCOLESTEROLTOTAL: TBCDField
      FieldName = 'COLESTEROLTOTAL'
      Origin = 'COLESTEROLTOTAL'
      Precision = 18
      Size = 2
    end
    object fdqExamesHDL: TBCDField
      FieldName = 'HDL'
      Origin = 'HDL'
      Precision = 18
      Size = 2
    end
    object fdqExamesLDL: TBCDField
      FieldName = 'LDL'
      Origin = 'LDL'
      Precision = 18
      Size = 2
    end
    object fdqExamesTRIGLICERIDES: TBCDField
      FieldName = 'TRIGLICERIDES'
      Origin = 'TRIGLICERIDES'
      Precision = 18
      Size = 2
    end
  end
end
