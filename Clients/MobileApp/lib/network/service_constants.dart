class ServiceConstants {
  // Debug-mode
  static bool testBackend = true;

  //AuthService
  static String authPort = "9800";
  // TODO: Change to the correct url
  static String authLiveURL = "116.203.234.111:" + authPort;
  static String authTestURL = "127.0.0.1:" + authPort;
  static String baseAuthUrl = testBackend ? authTestURL : authLiveURL;

  //GameService
  static String gamePort = "9700";
  // TODO: Change to the correct url
  static String gameLiveURL = "116.203.234.111:" + gamePort;
  static String gameTestURL = "127.0.0.1:" + gamePort;
  static String baseGameUrl = testBackend ? gameTestURL : gameLiveURL;
}
