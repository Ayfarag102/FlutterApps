import 'package:flutter/material.dart';
import 'package:gma_app/screens/add_groceries_screen.dart';
import 'package:gma_app/screens/completed_groceries_screen.dart';
import 'package:gma_app/screens/current_groceries_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Map<String, Object>> _pages;
  int _currentIndex = 0;
  void _selectPage(int index) {
    debugPrint(index.toString());
    setState(() {
      // index = widget.incomingIndex;
      // debugPrint(index.toString());
      _currentIndex = index;
      debugPrint(_currentIndex.toString());

      // if (index == 0) {
      //   Navigator.of(context)
      //       .pushReplacementNamed(AddGroceriesScreen.routeName);
      // } else if (index == 1) {
      //   Navigator.of(context)
      //       .pushReplacementNamed(CurrentGroceriesScreen.routeName);
      // } else {
      //   Navigator.of(context)
      //       .pushReplacementNamed(CompletedGroceriesScreen.routeName);
      // }
    });
    // return _currentIndex;
  }

  @override
  void initState() {
    _pages = [
      {'page': AddGroceriesScreen(), 'title': "Add a New Grocery List"},
      {'page': CurrentGroceriesScreen(), 'title': "Current Groceries"},
      {'page': CompletedGroceriesScreen(), 'title': "Completed Groceries"},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_pages[_currentIndex]['title'])),
        body: _pages[_currentIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          //  backgroundColor: Theme.of(context).primaryColor,

          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          // unselectedItemColor: Colors.black26,

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.add, color: Colors.white),
              label: 'Add Groceries',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket, color: Colors.white),
              label: 'Current',
              backgroundColor: Colors.orange,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle, color: Colors.white),
              label: 'Completed',
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ],
          onTap: _selectPage,
        ));
  }
}
