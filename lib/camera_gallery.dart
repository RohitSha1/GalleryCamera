import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraGalleryScreen extends StatefulWidget {
  const CameraGalleryScreen({Key? key}) : super(key: key);

  @override
  State<CameraGalleryScreen> createState() => _CameraGalleryScreenState();
}

class _CameraGalleryScreenState extends State<CameraGalleryScreen> {
  File? img;
  Future _loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint('Failed to pick Image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GALYCAM'),
      ),
      body: Column(
        children: [
          _displayImage(),
          const SizedBox(height: 100),
          SizedBox(
            width: 250,
            child: ElevatedButton.icon(
              onPressed: () {
                _loadImage(ImageSource.camera);
              },
              icon: const Icon(Icons.camera_enhance),
              label: const Text('Open Camera'),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 250,
            child: ElevatedButton.icon(
              onPressed: () {
                _loadImage(ImageSource.gallery);
              },
              icon: const Icon(Icons.browse_gallery_sharp),
              label: const Text('Open Gallery'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _displayImage() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
        side: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
      ),
      child: ClipRRect(
        // For rounded upper right corner and left corner in imageview
        borderRadius: BorderRadius.circular(55),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: img==null ?
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/512/226/226850.png',
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.height * 0.1,
                    )
                    :Image.file(img!),
              )
            ],
          ),
        ),
      ),
    );
  }
}
