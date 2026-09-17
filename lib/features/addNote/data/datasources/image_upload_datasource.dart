import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ImageUploadDataSource {
  final String apiKey;

  ImageUploadDataSource({
    required this.apiKey,
  });

  Future<String?> uploadImage(
    String imagePath,
  ) async {
    if (apiKey.isEmpty) {
      throw Exception(
        'ImgBB API key is not configured',
      );
    }

    final file = File(imagePath);

    if (!await file.exists()) {
      return null;
    }

    final url = Uri.parse(
      'https://api.imgbb.com/1/upload?key=$apiKey',
    );

    try {
      final request = http.MultipartRequest(
        'POST',
        url,
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imagePath,
        ),
      );

      final response = await request.send();

      if (response.statusCode != 200) {
        debugPrint(
          'ImgBB upload failed: ${response.statusCode}',
        );

        return null;
      }

      final responseData =
          await response.stream.bytesToString();

      final jsonResponse =
          jsonDecode(responseData);

      return jsonResponse['data']?['url']
          as String?;
    } catch (e) {
      debugPrint(
        'ImgBB upload error: $e',
      );

      return null;
    }
  }
}