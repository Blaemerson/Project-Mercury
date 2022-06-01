import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:projectmercury/resources/auth_methods.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthMethods _auth = GetIt.I.get<AuthMethods>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Info'),
        ),
        body: Center(
          child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: TextButton(
              onPressed: () async {
                await _auth.signout();
              },
              child: const Text('SignOut'),
            ),
          ),
        ));
  }
}
