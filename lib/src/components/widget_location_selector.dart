import 'package:flutter/material.dart';
import '../common/utils.dart';
import 'location_selection_page.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  final _availableLocations = {
    "VN": "Toàn Quốc",
    "HN": "Hà Nội",
    "ĐN": "Đà Nẵng",
    "HUE": "Huế",
    "HCM": "Tp. Hồ Chí Minh",
    "CT": "Cần Thơ"
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: OutlinedButton.icon(
          icon: const Icon(Icons.location_on_outlined),
          label: const Row(children: [Text('HCM'), Icon(Icons.expand_more)]),
          style: ButtonStyle(
              iconColor: MaterialStateProperty.all(Colors.white),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.white))),
          onPressed: pushNavigatorOnPressed(
              context,
              (context) => LocationSelectionPage(
                  availableLocations: _availableLocations, selectedKey: "VN")),
        ));
  }
}
