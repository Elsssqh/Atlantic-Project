import 'package:atlanticc/theme/palette.dart';
import 'package:flutter/material.dart';

 

class AuthField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String titleText;
  final bool isPassword;  
  final Color backgroundColor;

  const AuthField({

    super.key,
    required this.controller,
    required this.hintText,
    required this.titleText,
    required this.isPassword,
    this.backgroundColor=Colors.blue,

  });

 

  @override
  State<AuthField> createState() => _AuthFieldState();
}

 

class _AuthFieldState extends State<AuthField> {
  bool _showPassword = false;

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });

  }

 

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          widget.titleText,
          style: TextStyle(
            fontSize: 20,

          ),

        ),

      ),

      const SizedBox(height: 7),
      TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? !_showPassword : false,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color:  Color.fromARGB(255, 91, 124, 202),
              width: 2,

            ),

          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color:  Color.fromARGB(255, 91, 124, 202),
              width: 1,
            ),

          ),

          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 18,

          ),

          fillColor:  Color.fromARGB(255, 91, 124, 202),
          filled:true,
          suffixIcon: GestureDetector(
            onTap: () {
              widget.isPassword ? _togglevisibility() : DoNothingAction();

            },

            child: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
              color: widget.isPassword ? Colors.black : Colors.transparent,

            ),

          ),

        ),

      ),

    ]);

  }

}

