import 'package:flutter/material.dart';
import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/resources/timeController.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    final AuthMethods _auth = locator.get<AuthMethods>();
    TimerController _timer = Provider.of<TimerController>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Info'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<TimerController>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      const Text('Total time:'),
                      Text(_timer.totalTime),
                      const Text('Time this session:'),
                      Text(_timer.sessionTime),
                    ],
                  );
                },
              ),
              Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: TextButton(
                  onPressed: () async {
                    await _auth.signout();
                  },
                  child: const Text('SignOut'),
                ),
              ),
            ],
          ),
        ));
  }
}
