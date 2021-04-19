import 'package:customer/ui/create_trip/create_trip_page.dart';
import 'package:customer/ui/widget/platform_specific_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBar
    extends PlatformSpecificWidget<CupertinoTabScaffold, BottomNavigationBar> {
  @override
  BottomNavigationBar androidWidget(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.trip_origin),
          title: Text(
            'Create Trip',
            style: TextStyle(fontSize: 15.0),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.drive_eta),
          title: Text(
            'My Trip',
            style: TextStyle(fontSize: 15.0),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          title: Text(
            'Notifications',
            style: TextStyle(fontSize: 15.0),
          ),
        ),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }

  @override
  CupertinoTabScaffold iosWidget(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bus),
            title: Text('Create Trip'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book),
            title: Text('My Trips'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.conversation_bubble),
            title: Text('Notifications'),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        assert(index >= 0 && index <= 2);
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return CupertinoPageScaffold(
                    child: Material(
                  child: CreateTripPage(),
                ));
              },
              defaultTitle: 'Colors',
            );
            break;
          case 1:
            return CupertinoTabView(
              builder: (BuildContext context) => CupertinoPageScaffold(
                child: Center(),
              ),
              defaultTitle: 'Support Chat',
            );
            break;
          case 2:
            return CupertinoTabView(
              builder: (BuildContext context) => CupertinoPageScaffold(
                child: Center(),
              ),
              defaultTitle: 'Account',
            );
            break;
        }
        return null;
      },
    );
  }
}
