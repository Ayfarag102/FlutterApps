import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import '../Screens/favourites_screen.dart';
import '../screens/categories_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  List<Map<String, Object>> _pages = [
    {'page': CategoriesScreen(), 'title': 'Categories'},
    {'page': FavouritesScreen(), 'title': 'Your Favourite(s)'}
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //     length: 2,
    //child:
    return Scaffold(
      appBar: AppBar(title: Text(_pages[_selectedPageIndex]['title'])),
      drawer: MainDrawer(),

      // 1. First way of creating tabs in an app
      // bottom: TabBar(tabs: <Widget>[
      //   Tab(icon: Icon(Icons.category), text: 'Categories'),
      //   Tab(icon: Icon(Icons.star), text: 'Favourites'),
      // ])),
      // body: TabBarView(
      //   children: <Widget>[CategoriesScreen(), FavouritesScreen()],
      // ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black26,
          selectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          // type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), title: Text('Categories')),
            BottomNavigationBarItem(
                icon: Icon(Icons.star, color: Colors.amber),
                title: Text('Favourites'))
          ]),
    );
  }
}
