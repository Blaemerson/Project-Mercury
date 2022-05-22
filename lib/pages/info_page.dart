import 'package:flutter/material.dart';
import 'package:projectmercury/resources/auth_methods.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Info'),
        ),
        body: Center(
          child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: TextButton(
              onPressed: () async {
                await AuthMethods().signout();
              },
              child: const Text('SignOut'),
            ),
          ),
        ));
  }
}
