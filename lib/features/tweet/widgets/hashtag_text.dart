import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:atlanticc/features/tweet/views/hashtag_view.dart';
import 'package:atlanticc/theme/pallete.dart';

class HashtagText extends StatelessWidget {
  final String text;
  const HashtagText({
    super.key,
    required this.text,
  }
  );

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textspans = [];

    text.split(' ').forEach((element) {
      if (element.startsWith('#')) {
        textspans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
            color: Color.fromARGB(255, 118, 149, 222),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  HashtagView.route(element),
                );
              },
          ),
        );

      } 
      
      else if (element.startsWith('www.') || element.startsWith('https://')) {
        textspans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
            color: Color.fromARGB(255, 118, 149, 222),
            fontSize: 18,
            ),
          ),
        );
      } 
      
      else {
        textspans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        );
      }
    }
    );

    return RichText(
      text: TextSpan(
        children: textspans,
      ),
    );
  }
}
