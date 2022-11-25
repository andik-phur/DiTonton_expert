// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

class SslPinning {
  static IOClient? _client;

  static IOClient get client => _client ?? IOClient();

  static Future<void> init() async {
    _client = await instance;
  }

  static Future<IOClient> get instance async => _client ??= await ioClient();

  static Future<IOClient> ioClient() async {
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);

    final sslCert = await rootBundle.load('certificate/certificate.pem');

    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

    HttpClient client = HttpClient(context: securityContext);

    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    return IOClient(client);
  }
}
