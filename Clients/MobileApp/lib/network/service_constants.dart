class ServiceConstants {
  // Debug-mode
  static bool testBackend = false;

  /*
  ** GAMESERVICE URLS ARE ALWAYS OVERRIDDEN BY THE URL FROM AUTH-SERVICE AS STANDARD
  */

  //AuthService
  static String authPort = "9800";
  static String authLiveURL = "87.61.85.141:" + authPort;
  static String authTestURL = "127.0.0.1:" + authPort;
  static String baseAuthUrl = testBackend ? authTestURL : authLiveURL;

  //GameService
  static String gamePort = "9700";
  static String gameLiveURL = "94.130.183.32:" + gamePort;
  static String gameTestURL = "127.0.0.1:" + gamePort;
  static String baseGameUrl = testBackend ? gameTestURL : gameLiveURL;
}
