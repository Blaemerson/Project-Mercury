import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SignInScreen(
      providerConfigs: [
        EmailProviderConfiguration(),
      ],
    );
  }
}
