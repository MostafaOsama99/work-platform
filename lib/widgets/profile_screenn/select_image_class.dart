import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../constants.dart';
Widget textField({String text, icon, Function validator, Function onSaved}) {
  return Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 5),
    child: Container(
      child: TextFormField(
          validator: validator,
          onSaved: onSaved,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) {},
          autofocus: false,
          initialValue: text,
          style: TextStyle(color: Colors.grey[800], fontSize: 20),
          decoration: TEXT_FIELD_DECORATION1.copyWith(
              prefixIcon: Icon(
                icon,
                color: Colors.grey[800],
              ))),
    ),
  );
}

class SelectImage extends StatelessWidget {
  PickedFile pickedFile;
  File _image;

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();
    Future getGalleryImage() async {
      pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
        Navigator.of(context).pop(_image);
      } else {
        print('No image selected.');
        Navigator.of(context).pop();
      }
    }

    Future getCameraImage() async {
      pickedFile = await picker.getImage(source: ImageSource.camera);

      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
        Navigator.of(context).pop(_image);
      } else {
        print('No image selected.');
        Navigator.of(context).pop();
      }
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(
                flex: 2,
              ),
              FlatButton(
                onPressed: () {
                  getCameraImage();
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  child: Icon(
                    Icons.camera_alt,
                    size: 50,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              Spacer(
                flex: 2,
              ),
              FlatButton(
                onPressed: () {
                  getGalleryImage();
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  child: Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
              Spacer(
                flex: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}