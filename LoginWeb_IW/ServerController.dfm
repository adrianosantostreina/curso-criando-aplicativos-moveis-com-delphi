object IWServerController: TIWServerController
  OldCreateOrder = False
  AppName = 'MyApp'
  Description = 'My IntraWeb Application'
  DisplayName = 'IntraWeb Application'
  Port = 8888
  ServerResizeTimeout = 0
  ShowLoadingAnimation = True
  SessionTimeout = 10
  SSLOptions.NonSSLRequest = nsAccept
  SSLOptions.Port = 0
  SSLOptions.SSLVersions = []
  Version = '14.2.2'
  AllowMultipleSessionsPerUser = False
  SecurityOptions.CheckSameIP = False
  RestartExpiredSession = True
  OnNewSession = IWServerControllerBaseNewSession
  Height = 310
  Width = 342
end
