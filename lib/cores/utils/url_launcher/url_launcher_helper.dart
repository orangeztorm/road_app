import 'package:url_launcher/url_launcher.dart';

import '../__utils.dart';

class UrlLauncherHelper {
  static void launchTelegram() async {
    try {
      final Uri url = Uri.parse("https://t.me/Recon_Africa");
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e, s) {
      LoggerHelper.log(e, s);
    }
  }

  static void launchDiscord() async {
    try {
      final Uri url = Uri.parse("https://discord.gg/fnJ9PWw8DE");
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e, s) {
      LoggerHelper.log(e, s);
    }
  }

  static void launchEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'email@example.com',
      // query: 'subject=App Feedback&body=App Version 3.23',
      query: 'subject=App Feedback',
    );

    try {
      if (await canLaunchUrl(params)) {
        await launchUrl(params, mode: LaunchMode.externalApplication);
      }
    } catch (e, s) {
      LoggerHelper.log(e, s);
    }
  }

  static Future<void> launchURL(String s) async {
    try {
      if (await canLaunchUrl(Uri.parse(s))) {
        await launchUrl(Uri.parse(s), mode: LaunchMode.externalApplication);
      }
    } catch (e, s) {
      LoggerHelper.log(e, s);
    }
  }
}
