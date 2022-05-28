import 'package:flutter/material.dart';
import 'package:load_image/camera_gallery.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const CameraGalleryScreen(),
      },
    ),
  );
}
