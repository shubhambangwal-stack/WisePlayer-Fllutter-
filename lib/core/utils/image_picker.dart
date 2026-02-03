import 'package:image_picker/image_picker.dart';

Future<List<XFile>?> pickImages() async {
  ImagePicker _imagePicker = ImagePicker();
  try {
    final List<XFile>? images = await _imagePicker.pickMultiImage();

    return images!;
  } catch (e) {
    return null;
  }
}

Future<XFile?> pickImage() async {
  ImagePicker _imagePicker = ImagePicker();
  try {
    final Future<XFile?> images = _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    return images;
  } catch (e) {
    return null;
  }
}
