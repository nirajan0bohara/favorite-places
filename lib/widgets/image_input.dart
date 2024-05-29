import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  void _uploadImage() async {
    final ImagePicker imagepicker = ImagePicker();
    final uploadedImage = await imagepicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          onPressed: _takePicture,
          icon: const Icon(Icons.camera),
          label: const Text('Take Picture'),
        ),
        const SizedBox(width: 6),
        TextButton.icon(
          onPressed: _uploadImage,
          icon: const Icon(Icons.photo_album),
          label: const Text('Upload Picture'),
        ),
      ],
    );

    if (_selectedImage != null) {
      content = Image.file(
        _selectedImage!,
        fit: BoxFit.cover,
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}