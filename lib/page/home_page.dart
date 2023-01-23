import 'package:course_discuss_app/controller/c_home.dart';
import 'package:course_discuss_app/page/fragment/account_fragment.dart';
import 'package:course_discuss_app/page/fragment/explore_fragment.dart';
import 'package:course_discuss_app/page/fragment/feed_fragment.dart';
import 'package:course_discuss_app/page/fragment/my_topic_fragment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List menu = [
      {
        'icon': Icons.feed,
        'label': 'Feed',
        'view': const FeedFragment(),
      },
      {
        'icon': Icons.public,
        'label': 'Explore',
        'view': const ExploreFragment(),
      },
      {
        'icon': Icons.library_books,
        'label': 'Topic',
        'view': const MyTopicFragment(),
      },
      {
        'icon': Icons.feed,
        'label': 'Account',
        'view': const AccountFragment(),
      },
    ];
    return Consumer<CHome>(builder: (context, _, child) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: menu[_.indexMenu]['view'],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          mini: true,
          tooltip: 'Create New Topic',
          child: const Icon(Icons.create),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _.indexMenu,
          onTap: (newIndex) {
            _.indexMenu = newIndex;
          },
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: menu.map((e) {
            return BottomNavigationBarItem(
                icon: Icon(e['label']), label: e['label']);
          }).toList(),
        ),
      );
    });
  }
}
