import 'package:barber_booking/widget/buildsignupform.dart';
import 'package:barber_booking/widget/registration.dart';
import 'package:barber_booking/widget/signuploginsection.dart';
import 'package:barber_booking/widget/custom_button.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? name, mail, password;
  TextEditingController fullname_editor_controller = TextEditingController();
  TextEditingController email_editor_controller = TextEditingController();
  TextEditingController password_editor_controller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: Colors.black),
              child: const Text(
                "Create your\nAccount",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white60,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: screen.height * 0.75 -
                    MediaQuery.of(context).viewInsets.bottom,
                width: screen.width,
                decoration: const BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildSignupForm().buildSignupForm(
                          _formkey,
                          fullname_editor_controller,
                          email_editor_controller,
                          password_editor_controller),
                      InkWell(
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              mail = email_editor_controller.text;
                              name = fullname_editor_controller.text;
                              password = password_editor_controller.text;
                            },);
                          }
                          Registration()
                              .registration(context, password, name, mail);
                        },
                        child: CustomButton(
                            screen: screen, button_text: "SIGN UP"),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SignupLoginSection().buildLoginSection(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    email_editor_controller;
    fullname_editor_controller;
    password_editor_controller;
    super.dispose();
  }
}
