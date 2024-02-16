import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  CustomExpansionTile({super.key, required this.icon, required this.title, required this.mapItem});
  final IconData icon;
  final String title;

  final Map<String, String> mapItem;

  final _leftStyle = TextStyle(fontSize: 16, color: Colors.grey);
  final _rightStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
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
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        children: _buildItem(),
      ),
    );
  }

  List<Widget> _buildItem() {
    List<Widget> list = [];
    mapItem.forEach((key, value) {
      list.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(key, style: _leftStyle),
                Text(value, style: _rightStyle),
              ],
            ),
            SizedBox(height: 10), // Add SizedBox for spacing between rows
          ],
        ),
      );
    });
    return list;
  }
}
