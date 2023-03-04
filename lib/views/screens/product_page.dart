import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/controllers/getx_controllers.dart';
import 'package:food/globals/globals.dart';
import 'package:food/models/models.dart';
import 'package:food/widget/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  BottomIndexController bottomIndexController =
      Get.find<BottomIndexController>();
  CartController cartController = Get.find<CartController>();
  WishlistController wishlistController = Get.find<WishlistController>();

  @override
  Widget build(BuildContext context) {
    ProductDB data = Get.arguments;

    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(CupertinoIcons.arrow_left),
        ),
        title: Text(
          "Order",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: carouselSlider(
                height: size.height,
                width: size.width,
                productName: data.name,
                category: data.category),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.name,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Obx(
                          ()=> IconButton(
                          onPressed: () {
                      wishlistController.add(productDB: data,index: data.id);
                            },
                          icon: wishlistController.chengIcon(),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    data.details,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Review (${data.review})",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "⭐⭐⭐⭐ 4.1",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.03,
                            child: OutlinedButton(
                              onPressed: () {
                                //  cartController.addQuantity(productDB: data);
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      const CircleBorder()),
                                  side: MaterialStateProperty.all(BorderSide(
                                      color: Global.text, width: 2))),
                              child: Icon(
                                Icons.remove,
                                size: 18,
                                color: Global.bg1,
                              ),
                            ),
                          ),
                          Text(
                            "${data.quantity}",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                            child: OutlinedButton(
                              onPressed: () {
                                // cartController.removeQuantity(product:data);
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      const CircleBorder()),
                                  side: MaterialStateProperty.all(BorderSide(
                                      color: Global.text, width: 2))),
                              child: Icon(
                                Icons.add,
                                size: 18,
                                color: Global.bg1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "₹ ${data.price}",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              width: size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                child: ElevatedButton(
                  onPressed: () {
                    cartController.addProduct(productDB: data);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Global.button),
                  ),
                  child: text(text: "+Add to Cart"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
