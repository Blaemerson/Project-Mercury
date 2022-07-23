import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:projectmercury/pages/homePage/floor_plan.dart';
import 'package:projectmercury/pages/homePage/room.dart';
import 'package:projectmercury/pages/storePage/receipt_page.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/resources/tutorial.dart';
import 'package:projectmercury/utils/utils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Room? _currentRoom = locator.get<EventController>().currentRoom;
    Tutorial _tutorial = locator.get<Tutorial>();
    const _homeLayout = FloorPlan();

    return Scaffold(
      body: Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: FittedBox(
              key: _tutorial.homeViewKey,
              child: _currentRoom ?? _homeLayout,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //button on bottom-left: shows list of rooms for navigation.
            Consumer<EventController>(
              builder: (_, event, __) {
                return Badge(
                  showBadge: event.sessionRoom != null
                      ? event.sessionRoom!.slots
                              .where((item) => item.item == null)
                              .isNotEmpty &&
                          event.currentRoom == null
                      : false,
                  badgeContent: Icon(
                    Icons.notification_important,
                    size: 28,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  ignorePointer: true,
                  child: SpeedDial(
                    key: _tutorial.buttonKey1,
                    childPadding: const EdgeInsets.symmetric(vertical: 0),
                    visible: event.session != 0 ? true : false,
                    animatedIcon: AnimatedIcons.menu_close,
                    switchLabelPosition: true,
                    overlayOpacity: 0.3,
                    childMargin: const EdgeInsets.symmetric(horizontal: 0),
                    children: [
                      SpeedDialChild(
                        labelWidget: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 2,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5),
                            child: Row(
                              children: [
                                _currentRoom == null
                                    ? const Icon(Icons.arrow_forward)
                                    : Container(),
                                const Text(
                                  'Full View',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(
                            () {
                              locator.get<EventController>().setRoom(null);
                            },
                          );
                        },
                      ),
                      for (Room room
                          in locator.get<EventController>().rooms) ...[
                        SpeedDialChild(
                          labelWidget: room.unlockOrder > event.session
                              ? Row(
                                  children: [
                                    const Icon(Icons.lock),
                                    Column(
                                      children: [
                                        const Text('Unlock at'),
                                        Text('Session ${room.unlockOrder}'),
                                      ],
                                    ),
                                  ],
                                )
                              : Badge(
                                  showBadge: room.slots
                                      .where((item) => item.item == null)
                                      .isNotEmpty,
                                  badgeContent: Icon(
                                    Icons.notification_important,
                                    size: 20,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 2,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 5),
                                      child: Row(
                                        children: [
                                          room == _currentRoom
                                              ? const Icon(Icons.arrow_forward)
                                              : Container(),
                                          Text(
                                            capitalize(room.name),
                                            style:
                                                const TextStyle(fontSize: 24),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                          onTap: room.unlockOrder <= event.session
                              ? () {
                                  setState(() {
                                    locator
                                        .get<EventController>()
                                        .setRoom(room);
                                  });
                                }
                              : null,
                        ),
                      ]
                    ],
                  ),
                );
              },
            ),
            // Text showing current room name.
            Text(
              _currentRoom != null
                  ? capitalize(_currentRoom.name)
                  : 'Full View',
              style: const TextStyle(fontSize: 30),
            ),
            // button on bottom-right: opens store page.
            FloatingActionButton(
              key: _tutorial.buttonKey2,
              heroTag: null,
              child: const Icon(Icons.storefront, size: 42),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return const ReceiptPage();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
