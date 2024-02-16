import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/cubit/post/post_cubit.dart';

class PickYear extends StatefulWidget {
  const PickYear({
    super.key,
    required this.title,
    required this.icon,
    required this.isRequired,
  });
  final String title;
  final IconData icon;
  final bool isRequired;

  @override
  State<PickYear> createState() => _PickYearState();
}

class _PickYearState extends State<PickYear> {
  String selectedYear = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.title,
                style: TextStyle(
                    fontSize: 16,
                    color:
                        Colors.grey[600]) // isNoteForSell = true => title bold
                ),
            SizedBox(width: 5),
            widget.isRequired
                ? Text(
                    '*',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  )
                : SizedBox(),
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: GestureDetector(
            onTap: () {
              _showBottomSheetPicker();
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(widget.icon),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      selectedYear.isNotEmpty ? selectedYear : widget.title,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_outlined),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showBottomSheetPicker() async {
    // show data
    // put list data here
    DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chọn năm sản xuất'),
          content: SizedBox(
            height: 300,
            width: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 100, 1),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
              selectedDate: DateTime.now(),
              onChanged: (DateTime dateTime) {
                context.read<PostCubit>().onChangeRegistrationYear(
                    DateFormat('yyyy').format(dateTime));
                Navigator.of(context).pop(dateTime);
              },
            ),
          ),
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedYear = DateFormat('yyyy').format(picked);
      });
    }
  }
}
