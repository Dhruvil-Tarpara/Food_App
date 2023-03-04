import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/controllers/getx_controllers.dart';
import 'package:food/globals/globals.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  BottomIndexController bottomIndexController =
      Get.find<BottomIndexController>();
  WishlistController wishlistController = Get.find<WishlistController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            bottomIndexController.changeTabIndex(0);
          },
          icon: const Icon(CupertinoIcons.arrow_left),
        ),
        title: Text(
          "WishList",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: wishlistController.wishList.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    Get.toNamed("/product_page",
                        arguments: wishlistController.wishList[i]);
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image(
                      image: MemoryImage(wishlistController.wishList[i].image),
                      fit: BoxFit.cover,
                      width: size.width * 0.18,
                    ),
                  ),
                  title: Text("${wishlistController.wishList[i].name}"),
                  trailing: TextButton(
                    onPressed: () {
                      wishlistController.remove(
                          productDB: wishlistController.wishList[i],
                          index: wishlistController.wishList[i].id);
                    },
                    child: Text(
                      "Remove",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Global.bg1,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
