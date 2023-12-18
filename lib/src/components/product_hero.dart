import 'dart:async';

import 'package:flutter/material.dart';

class ProductHero extends StatefulWidget {
  const ProductHero({super.key, this.imageUrls = const <String>[]});

  final List<String> imageUrls;

  @override
  _ProductHeroState createState() => _ProductHeroState();
}

class _ProductHeroState extends State<ProductHero> {
  final PageController _pageController = PageController(initialPage: 0);
  int _index = 0;

  @override
  Widget build(BuildContext context) => Stack(children: [
        SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            child: PageView(
              controller: _pageController,
              children: widget.imageUrls
                  .map((url) => Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(url),
                        )),
                      ))
                  .toList(),
            ))
      ]);
}
