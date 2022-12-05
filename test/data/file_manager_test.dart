import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:random_coffee/data/file_manager.dart';

import '../test_services.dart';

void main() {
  initializeServices();
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    const MethodChannel('plugins.flutter.io/path_provider_macos')
        .setMockMethodCallHandler((MethodCall methodCall) async {
          return '.';
        });
    HttpOverrides.global = null;
  });

  group('FileManager tests', () {
    test('readDirectory returns the list of files urls', () async {
      final files = await FileManager(services<Dio>()).readDirectory();
      expect(files.every((element) => element.startsWith('./')), true);
    });

    test('writes file and returns true', () async {
      final result = await FileManager(services<Dio>())
          .downloadAndWriteImageFile(fakeUri);
      expect(result, true);
    });

    test('deletes file and returns true', () async {
      final result = await FileManager(services<Dio>()).deleteImage(fakeUri);
      expect(result, true);
    });
  });
}