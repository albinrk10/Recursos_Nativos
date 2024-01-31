import 'package:share_plus/share_plus.dart';

class SharedPlugin {
  static void sharedLink(String link, String subject) {
    Share.share(link, subject: subject);
  }
}
