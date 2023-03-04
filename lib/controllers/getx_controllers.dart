import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food/models/models.dart';

class CheckBoxController extends GetxController {
  CheckBox c1 = CheckBox(isCheck: false);

  isUpdate({required bool val}) {
    c1.isCheck = val;
    update();
  }
}

class DayStatus extends GetxController {
  late Status s1;
  late RxString status;

  showStatus({required DateTime dateTime}) {
    (dateTime.hour >= 6 && dateTime.hour <= 12)
        ? status = "Good Morning".obs
        : (dateTime.hour >= 13 && dateTime.hour <= 17)
            ? status = "Good Afternoon".obs
            : (dateTime.hour >= 18 && dateTime.hour <= 20)
                ? status = "Good Evening".obs
                : status = "Good Night".obs;
    s1 = Status(status: status);
  }
}

class BottomIndexController extends GetxController {
  RxInt bottomIndex = 0.obs;

  void changeTabIndex(int index) {
    bottomIndex.value = index;
  }
}

class WishlistController extends GetxController {
  RxList wishList = [].obs;
  RxList wishIndex = [].obs;
  RxBool like = false.obs;

  Widget chengIcon() {
    return (like.value)
        ? const Icon(
            CupertinoIcons.heart_fill,
            color: Colors.red,
          )
        : const Icon(CupertinoIcons.heart);
  }

  add({required ProductDB productDB, required int index}){
    wishList.add(productDB);
    wishIndex.add(index);
  }
  remove({required ProductDB productDB, required int index}){
    wishList.remove(productDB);
    wishIndex.remove(index);
  }

  addWishList({required ProductDB productDB, required int index}) {
    for (int e in wishIndex) {
      if (e == index) {
        like = true.obs;
        wishList.add(productDB);
        wishIndex.add(index);
      } else {
        like = false.obs;
        wishList.remove(productDB);
        wishIndex.remove(index);
      }
    }
  }

}

class CartController extends GetxController {
  RxList addedProduct = [].obs;
  RxList productQuantity = [].obs;

  void addQuantity({required ProductDB productDB, required int index}) {
    productQuantity[index]++;
  }

  void removeQuantity({required ProductDB product, required int index}) {
    (productQuantity[index] > 1) ? productQuantity[index]-- : product;
  }

  RxInt get totalQuantity {
    RxInt totalQuantity = 0.obs;
    for (var element in productQuantity) {
      totalQuantity += element;
    }
    return totalQuantity;
  }

  RxInt get totalPrice {
    RxInt finalTotal = 0.obs;
    for (var element in addedProduct) {
      int indext = addedProduct.indexOf(element);
      finalTotal += element.price * productQuantity[indext];
    }
    return finalTotal;
  }

  addProduct({required ProductDB productDB}) {
    addedProduct.add(productDB);
    productQuantity.add(1);
  }

  removeProduct({required ProductDB productDB, required int quantity}) {
    addedProduct.remove(productDB);
    productQuantity.remove(quantity);
  }
}
