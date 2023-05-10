import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_todo_app_with_firebase/pages/SignUpPage.dart';
import 'package:flutter_todo_app_with_firebase/services/Auth_Services.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthClass authClass = AuthClass();
  final ImagePicker picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: getImage(),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button('Upload', () {
                    Navigator.pop(context);
                  }),
                  IconButton(
                      onPressed: () async {
                        image =
                            await picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          image = image;
                        });
                      },
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.teal,
                        size: 30,
                      ))
                ],
              ),
              const SizedBox(height: 30),
              button('Log Out', () async {
                await authClass.logOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => SignUpPage()),
                    (route) => false);
              }),
            ],
          ),
        ),
      ),
    );
  }

  void logOut() {}

  ImageProvider getImage() {
    if (image != null) {
      return FileImage(File(image!.path));
    }
    return AssetImage('assets/avatar.jpg');
  }

  Widget button(String text, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            Color(0xff8a32f1),
            Color(0xffad32f9),
          ]),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
