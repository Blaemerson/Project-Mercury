import 'package:flutter/material.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class Tutorial {
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];

  final navBarKey = GlobalKey();
  final navItemKey1 = GlobalKey();
  final navItemKey2 = GlobalKey();
  final navItemKey3 = GlobalKey();
  final navItemKey4 = GlobalKey();
  final navItemKey5 = GlobalKey();
  final homeViewKey = GlobalKey();
  final buttonKey1 = GlobalKey();
  final buttonKey2 = GlobalKey();

  Widget _tutorialDescription(String desc) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              desc,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showTutorial(BuildContext context) {
    initTargets();
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.8,
      focusAnimationDuration: const Duration(milliseconds: 0),
      unFocusAnimationDuration: const Duration(milliseconds: 0),
      pulseEnable: false,
      onFinish: () {
        debugPrint("finish");
      },
      onClickTarget: (target) {
        if (target.keyTarget == navItemKey1) {
          locator.get<EventController>().currentPage = 0;
        }
        debugPrint('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        debugPrint("target: $target");
        debugPrint(
            "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        debugPrint('onClickOverlay: $target');
      },
      onSkip: () {
        debugPrint("skip");
      },
    )..show();
  }

  void initTargets() {
    targets.clear();
    targets.add(
      TargetFocus(
        identify: "navBar",
        keyTarget: navBarKey,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return _tutorialDescription(
                'This is the navigation bar. Tap on the icons to navigate to each page.',
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "navBarItem1",
        keyTarget: navItemKey1,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        paddingFocus: 24,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return _tutorialDescription(
                'Tap here to go to the home page.',
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "homeView",
        keyTarget: homeViewKey,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            builder: (context, controller) {
              return _tutorialDescription(
                'This is your home. Your goal is to furnish each room to your liking.',
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "roomSelect",
        keyTarget: buttonKey1,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.right,
            builder: (context, controller) {
              return _tutorialDescription(
                'Tap here to switch to different rooms.',
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "purchaseHistory",
        keyTarget: buttonKey2,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            builder: (context, controller) {
              return _tutorialDescription(
                'Tap here see your purchase history.',
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "keyNavBarItem2",
        keyTarget: navItemKey2,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        paddingFocus: 24,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return _tutorialDescription(
                'Tap here to go to the money page.',
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "keyNavBarItem3",
        keyTarget: navItemKey3,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        paddingFocus: 24,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return _tutorialDescription(
                'Tap here to go to the contacts page.',
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "keyNavBarItem4",
        keyTarget: navItemKey4,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        paddingFocus: 24,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return _tutorialDescription(
                'Tap here to go to the events page.',
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "keyNavBarItem5",
        keyTarget: navItemKey5,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        paddingFocus: 24,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return _tutorialDescription(
                'Tap here to go to the info page.',
              );
            },
          ),
        ],
      ),
    );
  }
}
