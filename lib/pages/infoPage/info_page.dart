import 'package:flutter/material.dart';
import 'package:projectmercury/pages/homePage/room.dart';
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
  @override
  Widget build(BuildContext context) {
    final AuthMethods _auth = locator.get<AuthMethods>();
    final TimerController _timer = locator.get<TimerController>();
    final FirestoreMethods _firestore = locator.get<FirestoreMethods>();

    return ChangeNotifierProvider.value(
      value: _timer,
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Consumer<EventController>(builder: (_, event, __) {
            int session = event.session;
            Room? sessionRoom = event.sessionRoom;
            List<int> roomProgress = event.roomProgress;
            List<int> eventProgress = event.eventProgress;
            double progress = event.sessionProgress;
            return Column(
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
                            backgroundColor: Colors.grey,
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
                    const SizedBox(height: 12),
                    const Text('Checklist:'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (sessionRoom != null) ...[
                          roomProgress[0] == roomProgress[1]
                              ? const Icon(Icons.check_box_outlined)
                              : const Icon(Icons.check_box_outline_blank),
                          Text(
                              'Fully furnish ${sessionRoom.name}: ${roomProgress.join('/')}'),
                        ],
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (sessionRoom != null) ...[
                          eventProgress[0] == eventProgress[1]
                              ? const Icon(Icons.check_box_outlined)
                              : const Icon(Icons.check_box_outline_blank),
                          Text('Complete Events: ${eventProgress.join('/')}'),
                        ],
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: progress == 1
                          ? () async {
                              if (locator.get<EventController>().session <
                                  locator.get<EventController>().rooms.length) {
                                await _firestore.updateSession();
                              }
                            }
                          : null,
                      child: const Text('Complete Session'),
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
                          await _firestore.resetData();
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
            );
          }),
        ),
      ),
    );
  }
}
