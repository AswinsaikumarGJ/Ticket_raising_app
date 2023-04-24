import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  String? buttonname;
  double? h;
  double? w;
  GestureTapCallback? onPressed;
  CustomButton({this.buttonname, this.h, this.w, this.onPressed});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        height: widget.h,
        width: widget.w,
        child: ElevatedButton(
            onPressed: widget.onPressed, child: Text('${widget.buttonname}')));
  }
}
