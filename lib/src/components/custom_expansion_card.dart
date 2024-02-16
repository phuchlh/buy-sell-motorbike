import 'package:flutter/material.dart';
import '../common/constants.dart';
import '../model/response/detail_buy_request.dart';

class CustomExpansionCard extends StatelessWidget {
  const CustomExpansionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.showroomName,
    required this.showroomAddress,
    required this.showroomPhone,
  });
  final IconData icon;
  final String title;
  final String showroomName;
  final String showroomAddress;
  final String showroomPhone;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ExpansionTile(
        shape: Border(),
        initiallyExpanded: false,
        leading: Icon(icon),
        title: Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        children: [
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: DesignConstants.primaryColor,
                  width: 3.0,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/app_logo.jpg',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  showroomName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  showroomAddress,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.normal),
                ),
                Text(
                  'Liên hệ: $showroomPhone',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
