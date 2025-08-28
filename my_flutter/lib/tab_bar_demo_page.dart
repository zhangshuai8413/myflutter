// tab_bar_demo_page.dart
import "package:flutter/material.dart";
import 'message_page.dart';

// 常量定义
class TabBarConstants {
  // 颜色常量
  static const Color selectedColor = Colors.blue;
  static const Color unselectedColor = Colors.grey;
  static const Color contactIconColor = Colors.green;
  static const Color settingIconColor = Colors.orange;
  static const Color textColor = Colors.black;
  static const Color subtitleColor = Colors.grey;
  
  // 尺寸常量
  static const double iconSize = 64.0;
  static const double titleFontSize = 24.0;
  static const double subtitleFontSize = 16.0;
  static const double spacing = 16.0;
  static const double smallSpacing = 8.0;
  
  // 文本常量
  static const String messageLabel = 'Message';
  static const String contactLabel = 'Contact';
  static const String settingLabel = 'Setting';
  static const String contactTitle = 'Contact Page';
  static const String settingTitle = 'Setting Page';
  static const String contactSubtitle = 'Here shows contact list';
  static const String settingSubtitle = 'Here shows app settings';
}

class TabBarDemoPage extends StatefulWidget {
  const TabBarDemoPage({Key? key}) : super(key: key);

  @override
  _TabBarDemoPageState createState() => _TabBarDemoPageState();
}

class _TabBarDemoPageState extends State<TabBarDemoPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    MessagePage(),
    ContactPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: TabBarConstants.selectedColor,
        unselectedItemColor: TabBarConstants.unselectedColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: TabBarConstants.messageLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: TabBarConstants.contactLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: TabBarConstants.settingLabel,
          ),
        ],
      ),
    );
  }
}



class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.contacts, 
            size: TabBarConstants.iconSize, 
            color: TabBarConstants.contactIconColor
          ),
          SizedBox(height: TabBarConstants.spacing),
          Text(
            TabBarConstants.contactTitle, 
            style: TextStyle(fontSize: TabBarConstants.titleFontSize)
          ),
          SizedBox(height: TabBarConstants.smallSpacing),
          Text(
            TabBarConstants.contactSubtitle, 
            style: TextStyle(
              fontSize: TabBarConstants.subtitleFontSize, 
              color: TabBarConstants.subtitleColor
            )
          ),
        ],
      ),
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.settings, 
            size: TabBarConstants.iconSize, 
            color: TabBarConstants.settingIconColor
          ),
          SizedBox(height: TabBarConstants.spacing),
          Text(
            TabBarConstants.settingTitle, 
            style: TextStyle(fontSize: TabBarConstants.titleFontSize)
          ),
          SizedBox(height: TabBarConstants.smallSpacing),
          Text(
            TabBarConstants.settingSubtitle, 
            style: TextStyle(
              fontSize: TabBarConstants.subtitleFontSize, 
              color: TabBarConstants.subtitleColor
            )
          ),
        ],
      ),
    );
  }
}
