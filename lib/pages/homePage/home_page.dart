import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:projectmercury/pages/homePage/floor_plan.dart';
import 'package:projectmercury/pages/homePage/room_data.dart';
import 'package:projectmercury/pages/storePage/store_page.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/utils/utils.dart';
import 'package:projectmercury/widgets/room.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Room? _currentRoom = locator.get<Rooms>().room;
    const _homeLayout = FloorPlan();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(30.0),
          minScale: 1.0,
          maxScale: 3.0,
          child: Center(
            child: FittedBox(
              child: _currentRoom ?? _homeLayout,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //button on bottom-left: shows list of rooms for navigation.
              SpeedDial(
                animatedIcon: AnimatedIcons.menu_close,
                switchLabelPosition: true,
                overlayOpacity: 0.3,
                childMargin: const EdgeInsets.symmetric(horizontal: 0),
                children: [
                  SpeedDialChild(
                    label: 'Full View',
                    labelStyle: const TextStyle(fontSize: 24),
                    onTap: () {
                      setState(() {
                        locator.get<Rooms>().set(null);
                      });
                    },
                  ),
                  for (Room room in locator.get<Rooms>().rooms) ...[
                    SpeedDialChild(
                      label: capitalize(room.name),
                      labelWidget: room.unlockOrder >
                              locator.get<EventController>().session
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
                          : null,
                      labelStyle: const TextStyle(fontSize: 24),
                      onTap: room.unlockOrder <=
                              locator.get<EventController>().session
                          ? () {
                              setState(() {
                                locator.get<Rooms>().set(room);
                              });
                            }
                          : null,
                    )
                  ]
                ],
              ),
              // Text showing current room name.
              Text(
                _currentRoom != null
                    ? capitalize(_currentRoom!.name)
                    : 'Full View',
                style: const TextStyle(fontSize: 30),
              ),
              // button on bottom-right: opens store page.
              FloatingActionButton(
                heroTag: null,
                child: const Icon(Icons.storefront, size: 42),
                onPressed: _currentRoom != null
                    ? () {
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
                            return StorePage(room: _currentRoom);
                          },
                        );
                      }
                    : () =>
                        showSnackBar('Select a room to open store.', context),
              ),
            ],
          ),
        ));
  }
}
