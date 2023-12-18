import 'package:flutter/material.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';

class LocationSelectionPage extends StatefulWidget {
  LocationSelectionPage({super.key, required this.availableLocations, required this.selectedKey});

  final Map<String, String> availableLocations;
  final String selectedKey;

  @override
  _LocationSelectionPageState createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  late ListView _locationsView;
  var _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _locationsView = _updateLocationsView();
      });
    });
  }

  _updateLocationsView({String query = ""}) {
    return ListView(
        children: widget.availableLocations.entries
            .where(
                (e) => (query.isEmpty) ? true : e.value.toLowerCase().contains(query.toLowerCase()))
            .map((e) => Card(
                    child: ListTile(
                  dense: true,
                  title: Text(e.value),
                  selected: e.key.toLowerCase() == widget.selectedKey.toLowerCase(),
                  trailing: (e.key.toLowerCase() == widget.selectedKey.toLowerCase())
                      ? const Icon(Icons.check_circle_outline)
                      : null,
                  selectedTileColor: Colors.yellowAccent.shade100,
                  iconColor: Colors.yellow,
                  onTap: () {
                    debugPrint(e.toString());
                    Navigator.pop(context, e.key);
                  },
                )))
            .toList());
  }

  _searchInput() => TextField(
        controller: _textEditingController,
        style: const TextStyle(color: Colors.black, fontSize: 14),
        decoration: InputDecoration(
            isDense: true,
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            fillColor: Colors.white,
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: MaterialStateColor.resolveWith(
                (states) => states.contains(MaterialState.focused) ? Colors.black : Colors.grey),
            labelText: 'Tìm kiếm sản phẩm',
            suffixIcon: IconButton(
              onPressed: () {
                _textEditingController.clear();
                setState(() {
                  _locationsView = _updateLocationsView();
                });
              },
              icon: Icon(Icons.clear),
            )),
        onChanged: (value) {
          setState(() {
            _locationsView = _updateLocationsView(query: value);
          });
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => Navigator.pop(context),
              color: Colors.white,
            ),
            centerTitle: true,
            backgroundColor: DesignConstants.primaryColor,
            title: const Text('Chọn địa chỉ xem hàng', style: TextStyle(color: Colors.black)),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(10),
                child: Container(padding: const EdgeInsets.all(10), child: _searchInput())),
          ),
        ),
        body: _locationsView);
  }
}
