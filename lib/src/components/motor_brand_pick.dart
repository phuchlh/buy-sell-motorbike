import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logger.dart';
import '../blocs/cubit/motorbrand/motorbrand_cubit.dart';
import '../blocs/cubit/post/post_cubit.dart';
import '../common/constants.dart';
import '../model/response/motor_brand_response.dart';

class MotorBrandPick extends StatefulWidget {
  const MotorBrandPick(
      {super.key,
      required this.title,
      required this.icon,
      required this.isRequired});
  final String title;
  final IconData icon;
  final bool isRequired;

  @override
  State<MotorBrandPick> createState() => _MotorBrandPickState();
}

class _MotorBrandPickState extends State<MotorBrandPick> {
  String selectedBrand = '';
  String? errorText;
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      color: hasError ? Colors.red : Colors.grey[600],
                    ) // isNoteForSell = true => title bold
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
                  _bottomDataMotorBrand(widget.title, state.status);
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
                          selectedBrand.isNotEmpty
                              ? selectedBrand
                              : widget.title,
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
      },
    );
  }

  void _bottomDataMotorBrand(String title, PostStatus status) async {
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
              child: BlocBuilder<MotorBrandCubit, MotorBrandState>(
                builder: (context, state) {
                  List<MotorBrand> motorBrandList = state.motorBrands;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      mainAxisSpacing: 20,
                      childAspectRatio: .95,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: motorBrandList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<PostCubit>()
                              .onChangeBrandID(motorBrandList[index].id);
                          print(motorBrandList[index].id);
                          Navigator.pop(context,
                              motorBrandList[index].name ?? 'Đang cập nhật');
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 180,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        motorBrandList[index].logo ??
                                            ErrorConstants.ERROR_PHOTO),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                  child: Text(motorBrandList[index].name ??
                                      'Đang cập nhật')),
                            )
                          ],
                        ),
                      ),
                    ),
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
        selectedBrand = result;
      });
    }
    if (status == PostStatus.canAddMore) {
      selectedBrand = widget.title;
    }
  }

  bool validateBrand() {
    if (selectedBrand == null || selectedBrand.isEmpty) {
      // error, null or empty value
      setState(() {
        hasError = true;
        errorText = 'Please select a brand'; // Your error message
      });
      return false;
    } else {
      // no error, not null
      setState(() {
        hasError = false;
        errorText = null;
      });
      return true;
    }
  }
}
