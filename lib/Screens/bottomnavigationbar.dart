import 'package:flutter/material.dart';
import 'package:ticket_raising_app/Screens/forms.dart';
import 'package:ticket_raising_app/Screens/homepage.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var selectindex = 0;
  List screens = [Homepage(), FormsPage()];
  onselectindex(int index) {
    setState(() {
      selectindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: screens[selectindex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 17,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Forms",
          ),
        ],
        currentIndex: selectindex,
        onTap: onselectindex,
      ),
    );
  }
}
