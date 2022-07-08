import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:projectmercury/models/event.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/utils/utils.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({required this.event, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: elevatedCardDecor(context),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        event.type == EventType.email
                            ? Icons.email_outlined
                            : event.type == EventType.text
                                ? Icons.textsms_outlined
                                : event.type == EventType.call
                                    ? Icons.call_outlined
                                    : Icons.question_mark,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${event.type.name} from ${event.sender} (${timeAgo(event.timeSent!)})',
                              style: const TextStyle(fontSize: 12)),
                          Text(event.title,
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    child: const Text('Open'),
                    style: ElevatedButton.styleFrom(
                      primary: event.state == EventState.actionNeeded
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[700],
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => _EventDialog(event: event));
                    },
                  ),
                ],
              ),
            ),
          ),
          event.state != EventState.actionNeeded
              ? Image.asset(
                  'assets/completed.png',
                  height: 75,
                  fit: BoxFit.fitHeight,
                  color: const Color.fromARGB(124, 255, 0, 0),
                )
              : Container(),
        ],
      ),
    );
  }
}

class _EventDialog extends StatefulWidget {
  final Event event;

  const _EventDialog({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<_EventDialog> createState() => _EventDialogState();
}

class _EventDialogState extends State<_EventDialog> {
  @override
  Widget build(BuildContext context) {
    FirestoreMethods _firestore = locator.get<FirestoreMethods>();

    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: widget.event.type == EventType.text
                        ? _TextEvent(event: widget.event)
                        : widget.event.type == EventType.email
                            ? _EmailEvent(event: widget.event)
                            : _CallEvent(event: widget.event),
                  ),
                ),
                Column(
                  children: [
                    const Divider(
                      indent: 0,
                    ),
                    Text(
                      widget.event.question,
                      style: const TextStyle(fontSize: 20),
                    ),
                    if (widget.event.state == EventState.actionNeeded) ...[
                      yesOrNo(
                        context,
                        yesLabel: 'Approve',
                        noLabel: 'Reject',
                        confirmationTitle: 'Are you sure?',
                        yesConfirmationMessage:
                            '${widget.event.question}\nYou selected: Approve',
                        noConfirmationMessage:
                            '${widget.event.question}\nYou selected: Reject',
                        onYes: () {
                          setState(() {
                            widget.event.state = EventState.approved;
                          });
                          _firestore.eventAction(widget.event, true);
                        },
                        onNo: () {
                          setState(() {
                            widget.event.state = EventState.rejected;
                          });
                          _firestore.eventAction(widget.event, false);
                        },
                      )
                    ] else if (widget.event.state == EventState.approved) ...[
                      const Text(
                        'Approved',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.green,
                        ),
                      )
                    ] else ...[
                      const Text(
                        'Rejected',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class _TextEvent extends StatelessWidget {
  final Event event;
  const _TextEvent({required this.event, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            event.sender,
            style: const TextStyle(fontSize: 32),
          ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (String dialog in event.dialog) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Container(
                    decoration: elevatedCardDecor(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        dialog,
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _EmailEvent extends StatelessWidget {
  final Event event;
  const _EmailEvent({required this.event, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          event.title,
          style: const TextStyle(fontSize: 32),
        ),
        const Divider(),
        Text('From: ${event.sender}'),
        const Divider(),
        for (String dialog in event.dialog) ...[
          Text(
            dialog,
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ],
    );
  }
}

class _CallEvent extends StatefulWidget {
  final Event event;
  const _CallEvent({required this.event, Key? key}) : super(key: key);

  @override
  State<_CallEvent> createState() => _CallEventState();
}

class _CallEventState extends State<_CallEvent> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setAudio();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
      });
    });
  }

  Future setAudio() async {
    audioPlayer.setSourceAsset('callAudio/${widget.event.audioPath}');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.event.sender,
          style: const TextStyle(fontSize: 32),
        ),
        Slider(
          min: 0,
          max: duration.inSeconds.toDouble(),
          value: position.inSeconds.toDouble(),
          onChanged: (value) async {
            final position = Duration(seconds: value.toInt());
            await audioPlayer.seek(position);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formatTime(position)),
            Text(formatTime(duration)),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () async {
            if (isPlaying) {
              await audioPlayer.pause();
            } else {
              await audioPlayer.resume();
            }
          },
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            size: 24,
          ),
          label: Text(isPlaying ? 'Pause' : 'Play',
              style: const TextStyle(fontSize: 18)),
        ),
        const Divider(),
        const Text(
          'Transcript:',
          style: TextStyle(fontSize: 24),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (String dialog in widget.event.dialog) ...[
              Text(
                dialog,
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
