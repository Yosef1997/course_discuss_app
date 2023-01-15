import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class CAddTopic extends ChangeNotifier {
  final List<String> _imageNames = [];
  List<String> get imageNames => _imageNames;

  final List<Uint8List> _imageBytes = [];
  List<Uint8List> get imageBytes => _imageBytes;

  final List<String> _imageBase64codes = [];
  List<String> get imageBase64codes => _imageBase64codes;

  pickImage(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      _imageNames.add(image.name);
      Uint8List byte = await image.readAsBytes();
      _imageBytes.add(byte);
      _imageBase64codes.add(base64Encode(byte));
      notifyListeners();
    }
  }

  removeImage(int index) {
    _imageNames.removeAt(index);
    _imageBytes.removeAt(index);
    _imageBase64codes.removeAt(index);
    notifyListeners();
  }
}
