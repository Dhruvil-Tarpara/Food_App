import 'package:flutter/material.dart';
import 'package:food/controllers/getx_controllers.dart';
import 'package:food/helper/db_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food/widget/widgets.dart';
import '../../globals/globals.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  String? name;
  String? email;
  String? password;

  CheckBoxController checkBoxController = Get.put(CheckBoxController());

  @override
  void initState() {
    DBHelper.dbHelper.create();
    super.initState();
  }

  @override
  void dispose() {
    loginFormKey;
    signUpFormKey;
    name;
    password;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/benar.jpg"),
              fit: BoxFit.cover,
              opacity: 0.4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 3,
            ),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                  image: const AssetImage("assets/images/1.jpg"),
                  height: size.height * 0.05,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "My Food",
                    style: GoogleFonts.italianno(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Global.bg1),
                  ),
                  Text(
                    "Discovering\nFresh,Local,\nOrganic Food",
                    style: GoogleFonts.pacifico(
                        fontSize: 32, color: Global.buttonLText),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.06,
                    width: size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.bottomSheet(
                            bottomSheetsLogin(w: size.width, h: size.height));
                      },
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(4),
                          shadowColor:
                              MaterialStateProperty.all(Global.buttonLText),
                          backgroundColor:
                              MaterialStateProperty.all(Global.button)),
                      child: text(text: "Login"),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.bottomSheet(
                          bottomSheets(w: size.width, h: size.height));
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(8),
                      surfaceTintColor: MaterialStateProperty.all(Global.bg),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?  ",
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Global.buttonLText),
                        ),
                        Text(
                          "Sign up now",
                          style: GoogleFonts.poppins(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Global.bg1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bottomSheets({required double h, required double w}) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Container(
      height: h * 0.6,
      decoration: BoxDecoration(
        color: Global.bg,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: GoogleFonts.poppins(
                    fontSize: 18, color: Global.buttonLText),
              ),
              Text(
                "Registrar",
                style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Global.buttonLText),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(thickness: 2),
              Form(
                key: signUpFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "User Name",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please Enter Name";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            Global.name = val;
                          },
                          controller: userNameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "User Name",
                            filled: true,
                            fillColor:
                                const Color(0xff50414D).withOpacity(0.12),
                          ),
                        ),
                      ),
                      Text(
                        "Email",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please Enter Valid email";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            Global.email = val;
                          },
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "Email",
                            filled: true,
                            fillColor:
                                const Color(0xff50414D).withOpacity(0.12),
                          ),
                        ),
                      ),
                      Text(
                        "Password",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please Enter Valid Password";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            Global.password = val;
                          },
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "Password",
                            filled: true,
                            fillColor:
                                const Color(0xff50414D).withOpacity(0.12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  width: w * 0.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (signUpFormKey.currentState!.validate()) {
                        signUpFormKey.currentState!.save();
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setBool("isUserDetails", true);
                        prefs.setString("name", Global.name.toString());
                        prefs.setString("email", Global.email.toString());
                        prefs.setString("password", Global.password.toString());
                        Get.back();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Global.button),
                    ),
                    child: text(text: "Register"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bottomSheetsLogin({required double h, required double w}) {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Container(
      height: h * 0.6,
      decoration: BoxDecoration(
        color: Global.bg,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome back",
                style: GoogleFonts.poppins(
                    fontSize: 18, color: Global.buttonLText),
              ),
              Text(
                "Login",
                style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Global.buttonLText),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(thickness: 2),
              Form(
                key: loginFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "User Name",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          validator: (val) {
                            if (val == name || val == email) {
                              return "Please Enter Valid name";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            Global.name = val;
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "User Name or Email",
                            filled: true,
                            fillColor:
                                const Color(0xff50414D).withOpacity(0.12),
                          ),
                        ),
                      ),
                      Text(
                        "Password",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          validator: (val) {
                            if (val != password) {
                              return "Please Enter Valid Password";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            Global.password = val;
                          },
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "Password",
                            filled: true,
                            fillColor:
                                const Color(0xff50414D).withOpacity(0.12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  const Text("Remember me Login"),
                  GetBuilder<CheckBoxController>(
                    builder: (checkBoxController) => Checkbox(
                        value: checkBoxController.c1.isCheck,
                        onChanged: (val) {
                          checkBoxController.isUpdate(val: val!);
                        }),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  width: w * 0.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      name = prefs.getString("name");
                      email = prefs.getString("email");
                      password = prefs.getString("password");

                      if (loginFormKey.currentState!.validate()) {
                        loginFormKey.currentState!.save();
                        prefs.setBool("isLogin", true);
                        prefs.setBool(
                            "isRemember", checkBoxController.c1.isCheck);
                        Get.offAllNamed("/");
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Global.button),
                    ),
                    child: text(text: "Login"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
