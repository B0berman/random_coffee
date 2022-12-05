import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  FileManager(this._client);

  late final Dio _client;

  Future<String> get _directoryPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<bool> downloadAndWriteImageFile(String url) async {
    final response = await _client.get<Uint8List>(url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
      ),
    );

    if (response.statusCode != 200) {
      return false;
    }

    try {
      final bytes = response.data!.toList();
      final name = url.split('/').last;
      final path = '${await _directoryPath}/$name';

      final file = File(path);
      await file.writeAsBytes(bytes);
    } catch (e) {
      log('Error deleting file with path "path": $e');
      return false;
    }
    return true;
  }

  Future<List<String>> readDirectory() async {
    final path = await _directoryPath;

    final list = Directory(path).listSync();
    return list.map((e) => e.path).toList();
  }

  Future<bool> deleteImage(String url) async {
    final name = url.split('/').last;
    final path = '${await _directoryPath}/$name';

    final file = File(path);
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      log('Error deleting file with path "path": $e');
      return false;
    }
    return true;
  }
}