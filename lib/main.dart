import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> imageList = [];

  @override
  void initState() {
    super.initState();
    loadImages(20);
  }

  Future<void> loadImages(int length) async {
    Random random = Random();
    List<String> images = [];

    for (int i = 0; i < length; i++) {
      int seed = random.nextInt(100000);
      images.add('https://picsum.photos/seed/$seed/720/1280');

      await Future.delayed(Duration(milliseconds: 200));
    }

    setState(() {
      imageList = images;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrossel de Imagens'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: imageList.isEmpty
            ? CircularProgressIndicator()
            : Container(
                height: MediaQuery.of(context).size.height,
                child: CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 4),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.easeInOutCubic,
                    pauseAutoPlayOnTouch: true,
                    viewportFraction: 0.99,
                    scrollDirection: Axis.vertical,
                  ),
                  items: imageList.map((item) {
                    return GestureDetector(
                      child: Image.network(item, fit: BoxFit.contain),
                    );
                  }).toList(),
                ),
              ),
      ),
    );
  }
}
