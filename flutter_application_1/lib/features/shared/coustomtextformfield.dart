import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class coustomtextformfield extends StatefulWidget {
  const coustomtextformfield({
    super.key,
    required this.hintText,
    required this.controller,
    required this.password,
    required this.icon, this.lable,
  });

  final String hintText;
  final TextEditingController controller;
  final bool password;
  final Icon icon;
 final String?lable; 
  @override
  State<coustomtextformfield> createState() => _coustomtextformfieldState();
}

class _coustomtextformfieldState extends State<coustomtextformfield> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.password;
    super.initState();
  }

  void obscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
@override
Widget build(BuildContext context) {
  return SizedBox(
    width: 390,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.lable != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              widget.lable!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

        TextFormField(
          controller: widget.controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "this field ${widget.hintText} is empty";
            }
            return null;
          },
          obscureText: _obscureText,
          cursorColor: AppColors.colorsinapp,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.colorbordertextformfield,
                width: 3,
              ),
            ),
            errorStyle: TextStyle(
              color: Color.fromARGB(255, 137, 133, 132),
              fontSize: 14,
            ),
            prefixIcon: widget.icon,
            suffixIcon: widget.password
                ? GestureDetector(
                    onTap: obscure,
                    child: Icon(Icons.remove_red_eye_outlined),
                  )
                : null,
            hintText: widget.hintText,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ],
    ),
  );
}
}
