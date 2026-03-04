// lib/config/router/route_names.dart

class RouteNames {
  RouteNames._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String socialLogin = '/socialLogin';
  static const String home = '/home';
  static const String dua = '/dua';
  static const String fastingDiet = '/fastingDiet';
  static const String hadith = '/hadith';
  static const String noInternet = '/noInternet';
  static const String prayer = '/prayer';
  static const String quran = '/quran';
  static const String selfTalk = '/selfTalk';
  static const String sura = '/sura';
  static const String tasbih = '/tasbih';
  static const String trackFasting = '/trackFasting';
  static const String trackImaan = '/trackImaan';
  static const String chat = '/chat';
  static const String allahName = '/allahName';
  static const String mainScaffold = '/mainScaffold';

  // ============ HELPER METHODS ============

  /// Build Surah detail route
  static String buildSurahRoute(int surahId) {
    return '/quran/$surahId';
  }

  /// Build Verse detail route
  static String buildVerseRoute(int surahId, int verseId) {
    return '/quran/$surahId/verse/$verseId';
  }

  /// Build Deed detail route
  static String buildDeedRoute(String deedId) {
    return '/deeds/$deedId';
  }

  /// Build Dua detail route
  static String buildDuaRoute(String duaId) {
    return '/dua/$duaId';
  }

  /// Build Event detail route
  static String buildEventRoute(String eventId) {
    return '/community/$eventId';
  }
}
