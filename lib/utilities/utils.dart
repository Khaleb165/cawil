// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/colors.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No image selected');
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: primary1,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.startToEnd,
      content: Text(
        content,
        style: TextStyle(
          color: colorWhite,
          fontSize: 16,
        ),
      ),
    ),
  );
}
