import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PDFApi{
  late bool _isLoadingPdf;
  static Future<File> loadFromNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    return storeFile(url, bytes);

  }

  bool get isLoadingPdf => false;

  set isLoadingPdf(bool value) {
    _isLoadingPdf = value;
  }

  static Future<File> storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;

  }
}