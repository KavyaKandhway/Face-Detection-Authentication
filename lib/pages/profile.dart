import 'dart:io';

import 'package:face_net_authentication/pages/cat_dog.dart';
import 'package:face_net_authentication/pages/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart';
import 'dart:math' as math;

class Profile extends StatelessWidget {
  const Profile(this.username, {Key key, this.imagePath}) : super(key: key);
  final String username;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    final double mirror = math.pi;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFC7FFBE),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(imagePath)),
                        ),
                      ),
                      margin: EdgeInsets.all(20),
                      width: 50,
                      height: 50,
                      // child: Transform(
                      //     alignment: Alignment.center,
                      //     child: FittedBox(
                      //       fit: BoxFit.cover,
                      //       child: Image.file(File(imagePath)),
                      //     ),
                      //     transform: Matrix4.rotationY(mirror)),
                    ),
                    Text(
                      'Hi ' + username + '!',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => CatDog(),
                          ),
                        );
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "cat dog classifier",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                AppButton(
                  text: "LOG OUT",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  color: Color(0xFFFF6161),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
