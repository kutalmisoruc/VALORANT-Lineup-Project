import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-id";
    } else if (Platform.isIOS) {
      return "ca-app-pub-your app / id";
    } else {
      throw new UnsupportedError("Unsupported Platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-id";
    } else if (Platform.isIOS) {
      return "ca-app-pub-your app / id";
    } else {
      throw new UnsupportedError("Unsupported Platform");
    }
  }
}