import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';

class Product360ImageView extends StatefulWidget {
  const Product360ImageView({super.key});

  @override
  _Product360ImageViewState createState() => _Product360ImageViewState();
}

class _Product360ImageViewState extends State<Product360ImageView> {
  List<ImageProvider> imageList = [];

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  void loadImages() {
    List<String> urls = [
      "https://mcstaging.bottlestore.com/media/catalog/product/cache/be2ac50930ab3282958370053db2bc19/5/5/55220042-1.jpg",
      "https://mcstaging.bottlestore.com/media/catalog/product/cache/be2ac50930ab3282958370053db2bc19/5/5/55220042-2.jpg",
      "https://mcstaging.bottlestore.com/media/catalog/product/cache/be2ac50930ab3282958370053db2bc19/5/5/55220042-3.jpg",
      "https://mcstaging.bottlestore.com/media/catalog/product/cache/be2ac50930ab3282958370053db2bc19/5/5/55220042-4.jpg",
    ];

    for (String url in urls) {
      imageList.add(NetworkImage(url));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('360° Product View'),
      ),
      body: Center(
        child: imageList.isEmpty
            ? const CircularProgressIndicator()
            : ImageView360(
                key: UniqueKey(),
                imageList: imageList,
                autoRotate: true,
                rotationCount: 2,
                rotationDirection: RotationDirection.anticlockwise, //Optional
                frameChangeDuration: const Duration(milliseconds: 10), //Optional
                swipeSensitivity: 2,
                allowSwipeToRotate: true,
                onImageIndexChanged: (currentImageIndex) {
                  print("currentImageIndex: $currentImageIndex");
                },
              ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Product360ImageView(),
  ));
}
