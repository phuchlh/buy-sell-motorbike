import 'package:flutter/material.dart';
import '../blocs/cubit/post/post_cubit.dart';
import '../blocs/cubit/showroom/showroom_cubit.dart';
import '../model/response/showroom_response.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PickShowroom extends StatefulWidget {
  const PickShowroom(
      {super.key,
      required this.title,
      required this.icon,
      required this.isRequired});
  final String title;
  final IconData icon;
  final bool isRequired;

  @override
  State<PickShowroom> createState() => _PickShowroomState();
}

class _PickShowroomState extends State<PickShowroom> {
  String selectShowroom = '';
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
              _bottomShowroomPicker(widget.title);
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
                      selectShowroom.isNotEmpty ? selectShowroom : widget.title,
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

  void _bottomShowroomPicker(String title) async {
    // show data
    // put list data here
    String? result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              height: 500,
              child: BlocBuilder<ShowroomCubit, ShowroomState>(
                builder: (context, state) {
                  List<Showroom> showroomList = state.showrooms;
                  return ListView.builder(
                    itemCount: showroomList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            "${showroomList[index].name} - ${showroomList[index].province} " ??
                                'Đang cập nhật'),
                        onTap: () {
                          context
                              .read<PostCubit>()
                              .onChangeShowroomID(showroomList[index].id);
                          Navigator.pop(context, showroomList[index].name);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
    if (result != null) {
      setState(() {
        selectShowroom = result;
      });
    }
  }
}
