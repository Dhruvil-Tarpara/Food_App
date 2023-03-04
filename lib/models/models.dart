import 'dart:typed_data';
import 'package:get/get.dart';

class CheckBox {
  bool isCheck;

  CheckBox({required this.isCheck});
}

class Status {
  late RxString status;

  Status({required this.status});
}

class Product {
  final String name;
  final String category;
  final String details;
  final int review;
  final int like;
  final int quantity;
  final int price;
  Uint8List? image;

  Product({
    required this.name,
    required this.details,
    required this.category,
    required this.quantity,
    required this.like,
    required this.price,
    required this.review,
    this.image,
  });

  factory Product.fromData({required Product data, Uint8List? image}) {
    return Product(
        name: data.name,
        details: data.details,
        category: data.category,
        quantity: data.quantity,
        like: data.like,
        price: data.price,
        review: data.review,
        image: image);
  }
}

class ProductDB {
  final String name;
  final String category;
  final String details;
  final int review;
  final int like;
  late final int quantity;
  final int price;
  final Uint8List image;
  final int id;

  ProductDB(
      {required this.name,
      required this.details,
      required this.category,
      required this.quantity,
      required this.like,
      required this.price,
      required this.review,
      required this.image,
      required this.id});

  factory ProductDB.fromData({required Map data}) {
    return ProductDB(
      name: data["Name"],
      details: data["Details"],
      category: data["Category"],
      quantity: data["Quantity"],
      like: data["likes"],
      price: data["Price"],
      review: data["Review"],
      image: data["Image"],
      id: data["Id"],
    );
  }
}

class Login {
  final String name;
  final String email;
  final String password;

  Login({required this.name, required this.email, required this.password});

  factory Login.fromDB({required Map data}) {
    return Login(
        name: data["name"], email: data["email"], password: data["password"]);
  }
}
