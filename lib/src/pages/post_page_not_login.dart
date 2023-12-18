import 'package:flutter/material.dart';

class NotLoginPage extends StatelessWidget {
  const NotLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Bạn cần đăng nhập để đăng tin'),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
