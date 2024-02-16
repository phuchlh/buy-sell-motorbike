import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../common/constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.title,
    required this.onChangedString,
    this.errorText,
    this.hintText,
    this.endIcon,
    this.keyboardType = TextInputType.multiline,
    this.initialText,
    this.validString,
    this.maxLines,
  });
  final int? maxLines;
  final String title;
  final String? hintText;
  final String? initialText;
  final Widget? endIcon;
  final Function(String) onChangedString;
  final String? Function(String?)? errorText; // (value) {// code validator}
  final TextInputType keyboardType;
  final String? validString;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode _focus;
  late final TextEditingController controller;
  @override
  void initState() {
    _focus = FocusNode();
    controller = TextEditingController(text: widget.initialText ?? "");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focus.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    if (oldWidget.initialText != widget.initialText) {
      controller.text = widget.initialText ?? '';
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var endIcon = widget.endIcon ?? SizedBox.shrink();
    var suffixIcon = endIcon != SizedBox.shrink()
        ? Container(
            width: MediaQuery.of(context).size.width * .02,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[endIcon],
            ),
          )
        : null;
    return SizedBox(
      height: 72,
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          minLines: 1,
          maxLines: widget.maxLines ?? 1,
          onTapOutside: (event) {
            _focus.unfocus();
          },
          keyboardType: widget.keyboardType,
          onChanged: widget.onChangedString,
          // onFieldSubmitted: widget.onChangedString,
          focusNode: _focus,
          controller: controller,
          // initialValue: widget.initialText,
          decoration: InputDecoration(
            // errorText: widget.errorText.toString(),
            labelText: widget.hintText,
            contentPadding: EdgeInsets.only(left: 10, right: 10),
            // hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: 14),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: DesignConstants.primaryColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
        ),
      ),
    );
  }
}
