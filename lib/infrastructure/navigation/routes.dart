class Routes {
  static Future<String> get initialRoute async {
    return SPLASH_SCREEN;
  }

  static const CALL_ACTIVITIES = '/call-activities';
  static const DOCUMENT_ACTIVITIES = '/document-activities';
  static const FACE_SCAN = '/face-scan';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const SNA_FORM = '/sna-form';
  static const SPLASH_SCREEN = '/splash-screen';
  static const CHECK_IN = '/check-in';
}
