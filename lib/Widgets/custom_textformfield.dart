import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  String? title;
  bool? readonly;
  bool? iconwant;
  String? Function(String?)? validator;
  TextEditingController? controller;
  GestureTapCallback? onPressed;
  CustomTextFormField(
      {required this.title,
      this.readonly,
      this.controller,
      this.iconwant,
      this.validator,
      this.onPressed});
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: widget.readonly!,
      decoration: InputDecoration(
        labelText: widget.title,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: widget.iconwant == true
            ? IconButton(
                onPressed: widget.onPressed,
                icon: Icon(Icons.download),
              )
            : Text(''),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: widget.validator,
    );
  }
}
