import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../globals/globals.dart';
import 'package:food/models/models.dart';
import 'package:food/helper/db_helper.dart';
import 'package:food/controllers/getx_controllers.dart';

import 'package:food/views/screens/wishlist_page.dart';
import 'package:food/views/screens/cart_page.dart';
import 'package:food/views/screens/account_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  DateTime dateTime = DateTime.now();

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    dayStatus.showStatus(dateTime: dateTime);
    super.initState();
  }

  @override
  void dispose() {
    dayStatus.dispose();
    super.dispose();
  }

  DayStatus dayStatus = Get.put(DayStatus());
  BottomIndexController bottomIndexController = Get.put(BottomIndexController());
  CartController cartController = Get.put(CartController());
  WishlistController wishlistController = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: bottomIndexController.changeTabIndex,
            currentIndex: bottomIndexController.bottomIndex.value,
            elevation: 1,
            backgroundColor: Colors.grey,
            selectedItemColor: Global.button,
            unselectedItemColor: Global.buttonLText,
            unselectedLabelStyle: TextStyle(
                color: Global.buttonLText,
                fontSize: 12,
                fontWeight: FontWeight.w400),
            selectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.house_alt),
                label: "Home",
                backgroundColor: Colors.grey.withOpacity(0.1),
              ),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.heart),
                label: "Wishlist",
                backgroundColor: Colors.grey.withOpacity(0.1),
              ),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.square_list_fill),
                label: "Bag",
                backgroundColor: Colors.grey.withOpacity(0.1),
              ),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.person_fill),
                label: "Account",
                backgroundColor: Colors.grey.withOpacity(0.1),
              ),
            ],
          ),
        ),
        body: Obx(
          () => IndexedStack(
            index: bottomIndexController.bottomIndex.value,
            children: const [Home(), WishlistPage(), CartPage(), AccountPage()],
          ),
        ));
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DayStatus dayStatus = Get.find<DayStatus>();
  BottomIndexController bottomIndexController = Get.find<BottomIndexController>();
  CartController cartController = Get.find<CartController>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text(
                  "${dayStatus.s1.status},",
                  style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Global.text,
                      fontWeight: FontWeight.w500),
                )),
            Text(
              "Dhruvil",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Global.text,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: Global.button,
                child: Obx(
                  ()=> Text(
                    "${cartController.totalQuantity}",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Global.bg,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  bottomIndexController.bottomIndex(2);
                },
                icon: const Icon(
                  CupertinoIcons.shopping_cart,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CupertinoSearchTextField(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
                color: Colors.grey.withOpacity(0.1),
              ),
              placeholder: "Search here...",
              placeholderStyle:
                  GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              itemColor: Colors.black,
              suffixMode: OverlayVisibilityMode.always,
              suffixIcon: const Icon(
                CupertinoIcons.sportscourt_fill,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "⚫ Most Popular",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            thickness: 2,
            color: Global.bg,
          ),
          Expanded(
            child: FutureBuilder(
              future: DBHelper.dbHelper.fetchAllRecords(),
              builder: (BuildContext context, AsyncSnapshot snapShot) {
                if (snapShot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text("Error : ${snapShot.error}"),
                    ),
                  );
                } else if (snapShot.hasData) {
                  List<ProductDB> data = snapShot.data;
                  return
                    GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 5,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed("/product_page", arguments: data[i]);
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image(
                                        image: MemoryImage(data[i].image),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Card(
                                        color: Colors.white.withOpacity(0.8),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Text(
                                            "₹ ${data[i].price}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  data[i].name,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  "⭐ ${data[i].review}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
