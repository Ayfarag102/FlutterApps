import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserAvatarImage extends StatefulWidget {
  UserAvatarImage(this.usrImageFn);

  final void Function(File picked) usrImageFn;
  @override
  _UserAvatarImageState createState() => _UserAvatarImageState();
}

class _UserAvatarImageState extends State<UserAvatarImage> {
  File _storedImage;

  void _pickImage() async {
    //  Can create a dialog and based on user input we open Image source gallery or camera
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (imageFile == null) {
      debugPrint('No image selected');
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });

    widget.usrImageFn(_storedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _storedImage != null ? FileImage(_storedImage) : null,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
