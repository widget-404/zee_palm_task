import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zee_palm/export.dart';

class Tabs extends GetView<TabsController> {
  Tabs({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> tabs = [
    HomePage(),
    SubmitOfferPage(),
    ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        body: tabs[controller.tabIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: colors.background,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: colors.primaryDark,
                  size: 24,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: colors.accentPrimary,
                  size: 26,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.note_add,
                  color: colors.primaryDark,
                  size: 24,
                ),
                activeIcon: Icon(
                  Icons.note_add,
                  color: colors.accentPrimary,
                  size: 26,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                  color: colors.primaryDark,
                  size: 24,
                ),
                activeIcon: Icon(
                  Icons.chat,
                  color: colors.accentPrimary,
                  size: 26,
                ),
                label: ''),
          ],
          currentIndex: controller.tabIndex.value,
          onTap: (pageIndex) {
            controller.onChangeTab(pageIndex);
          },
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
