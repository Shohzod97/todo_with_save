import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../data.dart';

var defaultImage = "assets/images/Айно.png";      //фото по умолчанию

class ImageHero extends StatefulWidget {          //Фото героя

  @override
  _ImageHeroState createState() => _ImageHeroState();
}

class _ImageHeroState extends State<ImageHero> {
  String appDocPath = '';
  File _image = File('');
  final fileName = 'background_image';

  Future _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    _image = File(pickedFile.path);

    final File localImage = await _image.copy('$appDocPath/$fileName');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    appDocPath = Provider.of<Data>(context, listen: false).getPath;
    if (appDocPath == '') context.read<Data>().getApplicationDirectoryPath();

    Image? image;
    var hasLocalImage = File('$appDocPath/$fileName').existsSync();
    if (hasLocalImage) {
      var bytes = File('$appDocPath/$fileName').readAsBytesSync();
      image = Image.memory(bytes, width: 246, height: 296, fit: BoxFit.cover);
    }

    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(children: [
        _imageFrame(image),
        SizedBox(height: 10),
        FlatButton(
            onPressed: () => _getImage(),
            child: Icon(Icons.add_photo_alternate_outlined)),
      ]),
    );
  }

  _imageFrame(image) => Container(
      //рамка фотографии
      child: (File('$appDocPath/$fileName').existsSync())
          ? image
          : Image.asset(defaultImage,
              width: 246, height: 296, fit: BoxFit.cover),
      alignment: Alignment.center,
      width: 250,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          shape: BoxShape.rectangle,
          border: Border.all(
            width: 3,
            color: Colors.deepOrangeAccent,
          )));
}
