import 'dart:convert';
import 'package:crypto/crypto.dart';

class Gravatar {
  static String generateEmailHash(String email) {
    String processedEmail = email.trim().toLowerCase();

    var bytes = utf8.encode(processedEmail);
    var digest = sha256.convert(bytes);

    return digest.toString();
  }
}
