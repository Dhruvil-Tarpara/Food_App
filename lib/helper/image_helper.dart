import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProductImage {
  ProductImage._();

  static final ProductImage productImage = ProductImage._();

  Future<Uint8List?> getImage({required String productName, required String category}) async {
    http.Response image = await http.get(
      Uri.parse(
          "https://source.unsplash.com/random/${1}?$productName,$category"),
    );
    if (image.statusCode == 200) {
      Uint8List data = image.bodyBytes;
      return data;
    }
    return null;
  }
}
