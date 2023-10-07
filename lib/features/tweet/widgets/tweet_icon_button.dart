import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:atlanticc/theme/palette.dart';

class TweetIconButton extends StatelessWidget {
  final String pathName;
  final String text;
  final VoidCallback onTap;
  const TweetIconButton(
    {
    Key? key,
    required this.pathName,
    required this.text,
    required this.onTap,
  }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            pathName,
            color: Color.fromARGB(255, 72, 77, 143),
          ),

          Container(
            margin: const EdgeInsets.all(6),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 1,
                
              ),
            ),
          ),
        ],
      ),
    );
  }
}
