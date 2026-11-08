import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndPrivacyText extends StatelessWidget {
  const TermsAndPrivacyText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
        children: [
          const TextSpan(text: 'Continue to log in or sign up and accept our '),
          TextSpan(
            text: 'Terms and Conditions',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()..onTap = () {
              // Route to Terms Page
            },
          ),
          const TextSpan(text: '. See our '),
          TextSpan(
            text: 'Privacy Policy',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()..onTap = () {
              // Route to Privacy Page
            },
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
