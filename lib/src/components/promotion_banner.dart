import 'dart:async';

import 'package:flutter/material.dart';
import '../../logger.dart';

class PromotionBanner extends StatefulWidget {
  const PromotionBanner(
      {super.key,
      required this.children,
      this.height,
      required this.isLocalFile,
      this.isAutoScroll});

  final List<String> children;
  final double? height;
  final bool isLocalFile;
  final bool? isAutoScroll;

  @override
  _PromotionBannerState createState() => _PromotionBannerState();
}

class _PromotionBannerState extends State<PromotionBanner> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      _currentPage += 1;

      if (_currentPage == widget.children.length) {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAutoSlide = widget.isAutoScroll ?? false;
    Logger.log('isAutoSlide: $isAutoSlide');
    Logger.log('isAutoSlide 123123123: ${widget.isAutoScroll}');
    return SizedBox(
      height: widget.height ?? 250,
      child: Card(
        child: PageView.builder(
          controller: isAutoSlide ? _pageController : null,
          itemCount: widget.children.length,
          itemBuilder: (context, index) {
            return widget.isLocalFile
                ? Image.asset(
                    widget.children[index],
                    fit: BoxFit.contain,
                  )
                : Image.network(
                    widget.children[index],
                    fit: BoxFit.contain,
                  );
          },
        ),
      ),
    );
  }
}
