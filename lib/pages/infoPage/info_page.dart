import 'package:flutter/material.dart';
import 'package:projectmercury/pages/homePage/room_data.dart';
import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
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
    final FirestoreMethods _firestore = locator.get<FirestoreMethods>();

// TODO: calculate session progress
    double progress = 1;
    int session = locator.get<EventController>().session;

    return ChangeNotifierProvider.value(
      value: _timer,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Info'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Consumer<TimerController>(
                builder: (_, timer, __) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Total time on app:',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            timer.totalTime,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Time this session:',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            timer.sessionTime,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              Column(
                children: [
                  Text(
                    'Session $session Progress',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 10,
                        ),
                      ),
                      Text(
                        '${(progress * 100).round()}%',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (locator.get<EventController>().session <
                          locator.get<Rooms>().rooms.length) {
                        _firestore.user.updateSession();
                        locator.get<EventController>().nextSession();
                        setState(() {});
                      }
                    },
                    child: const Text('Finish Session'),
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
                  //TODO: Reset button for testing
                  Container(
                    color: Theme.of(context).colorScheme.error,
                    child: TextButton(
                      onPressed: () async {
                        await _firestore.user.reset();
                        setState(() {});
                      },
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onError,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
