import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class CatDog extends StatefulWidget {
  @override
  _CatDogState createState() => _CatDogState();
}

class _CatDogState extends State<CatDog> {
  bool _loading = true;
  File _image;
  List _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    } else {
      setState(() {
        _image = File(image.path);
      });
      detectImage(_image);
    }
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      setState(() {
        _image = File(image.path);
      });
      detectImage(_image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Cat Dog Classifier',
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: _loading
                  ? Container(
                      child: Image.asset('assets/3.png'),
                    )
                  : Container(
                      child: Column(
                        children: [
                          Container(
                            height: 250,
                            child: Image.file(_image),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          _output != null
                              ? Text('${_output[0]['label']}')
                              : Container(),
                        ],
                      ),
                    ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      child: Text(
                        'Take photo',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width - 250,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                      decoration: BoxDecoration(
                          color: Colors.pink.shade400,
                          borderRadius: BorderRadius.circular(7)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      pickGalleryImage();
                    },
                    child: Container(
                      child: Text(
                        'Select photo',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width - 250,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                      decoration: BoxDecoration(
                          color: Colors.pink.shade400,
                          borderRadius: BorderRadius.circular(7)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
