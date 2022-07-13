// packages
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as systemPath;

class ImageInputWidget extends StatefulWidget {
  final Function selectImage;

  const ImageInputWidget({
    Key? key,
    required this.selectImage,
  }) : super(key: key);

  @override
  State<ImageInputWidget> createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  File? _storedImage;

  Future<void> _takeImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _storedImage = File(image.path);
      });
      widget.selectImage(_storedImage, _saveImage);
    }
  }

  Future<File> _saveImage() async {
    final Directory appDir =
        await systemPath.getApplicationDocumentsDirectory();
    final String fileName = path.basename(_storedImage!.path);
    //final savedImage =
    await (_storedImage as File).copy('${appDir.path}/$fileName');
    return _storedImage as File;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage as File,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: SizedBox(
            height: 100,
            child: TextButton.icon(
              onPressed: _takeImage,
              icon: const Icon(
                Icons.camera,
              ),
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              label: const Text('Taken an image'),
            ),
          ),
        ),
      ],
    );
  }
}
