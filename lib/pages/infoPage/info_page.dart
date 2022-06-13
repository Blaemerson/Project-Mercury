import 'package:flutter/material.dart';
import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/resources/badge_controller.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/resources/time_controller.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  // TODO: add session progress bar
  @override
  Widget build(BuildContext context) {
    final AuthMethods _auth = locator.get<AuthMethods>();
    final TimerController _timer = locator.get<TimerController>();
    final BadgeController _badge = locator.get<BadgeController>();

    return ChangeNotifierProvider.value(
      value: _timer,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Info'),
          ),
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<TimerController>(
                  builder: (_, timer, __) {
                    return Column(
                      children: [
                        const Text(
                          'Total time on app:',
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          timer.totalTime,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const Text(
                          'Time this session:',
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          timer.sessionTime,
                          style: const TextStyle(fontSize: 24),
                        ),
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
                TextButton(
                  onPressed: () {
                    _badge.update();
                  },
                  child: const Text('SignOut'),
                ),
              ],
            ),
          )),
    );
  }
}
