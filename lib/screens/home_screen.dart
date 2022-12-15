import 'package:chat_app/Helpers.dart';
import 'package:chat_app/theme.dart';
import 'package:chat_app/widgets/avatar.dart';
import 'package:chat_app/widgets/icon_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import '../pages/calls_page.dart';
import '../pages/contacts_page.dart';
import '../pages/messages_page.dart';
import '../pages/notifications_page.dart';
import '../widgets/glowing_action_button.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> pageTitle = ValueNotifier("Messages");

  final pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage(),
  ];

  final titles = const [
    'Messages',
    'Notifications',
    'Calls',
    'Contacts'
  ];

  void _selectedItem(index){
    pageIndex.value = index ;
    pageTitle.value = titles[index];

  }

  @override
  Widget build(BuildContext context) {
   // StreamChatCore.of(context).client;
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title : ValueListenableBuilder(
          valueListenable: pageTitle,
          builder: (BuildContext context, String value, _) {
            return 
          Text( 
            pageTitle.value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          );
          }
        ),
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(icon: Icons.search, onTap: () { 
            print('Search');
            },),
        ),
        actions: [Padding(
          padding: const EdgeInsets.only(right:24.0),
          child: Avatar.small(url :Helpers.randomPictureUrl()),
        )],
        ),
        body: ValueListenableBuilder(
          valueListenable: pageIndex,
          builder: (BuildContext context, int value, _) {
            return pages[value];
          },
        ),
        bottomNavigationBar: _BottomNavigationBar(
          selectedItem: _selectedItem,
        ));
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({Key? key, required this.selectedItem})
      : super(key: key);

  final ValueChanged<int> selectedItem;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  int selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.selectedItem(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light)? Colors.transparent : null,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 8) ,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(
                index: 0,
                lable: 'Messages',
                isSelected: (selectedIndex == 0),
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
                onTap: handleItemSelected,
              ),
              _NavigationBarItem(
                index: 1,
                lable: 'Notifications',
                isSelected: (selectedIndex == 1),
                icon: CupertinoIcons.bell_solid,
                onTap: handleItemSelected,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: GlowingActionButton(color: AppColors.secondary,icon: CupertinoIcons.add, onPressed: (){
                  print('new message');
                },),
              ),
              _NavigationBarItem(
                index: 2,
                lable: 'Calls',
                isSelected: (selectedIndex == 2),
                icon: CupertinoIcons.phone_fill,
                onTap: handleItemSelected,
              ),
              _NavigationBarItem(
                index: 3,
                lable: 'Contacts',
                isSelected: (selectedIndex == 3),
                icon: CupertinoIcons.person_2_fill,
                onTap: handleItemSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem(
      {Key? key,
      required this.lable,
      required this.icon,
      required this.index,
      required this.onTap,
      required this.isSelected})
      : super(key: key);

  final int index;
  final String lable;
  final IconData icon;
  final ValueChanged<int> onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              lable,
              style: isSelected? const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    )
                  : const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
