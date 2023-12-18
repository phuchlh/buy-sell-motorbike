import 'package:flutter/material.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      height: 120,
      decoration: BoxDecoration(
        color: DesignConstants.greyFooter,
      ),
      child: const Column(
        children: [
          Text(
            'Buy sell motorbike platform',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Powered by FA23SE076 team',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w200,
            ),
          ),
          Text(
            'FPT University HCMC Campus',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w200,
            ),
          ),
          Text(
            'E2a-7, D1, Saigon Hitech Park, Thu Duc City, HCMC',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }
}
