import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/globals/globals.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Account",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Global.bg,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.black,
                    child: Icon(
                      CupertinoIcons.person,
                      size: 50,
                      color: Global.bg,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dhruvil",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Global.text,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "dhruviltarpara9904@gmail.com",
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Global.text,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
