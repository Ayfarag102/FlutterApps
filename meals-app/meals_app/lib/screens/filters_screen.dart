import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  FiltersScreen(this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegeterian = false;
  var _vegan = false;
  var _lactoseFree = false;

  Widget _buildFilterSwitches(
      String title, String desc, bool currVal, Function updateVal) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(desc),
        value: currVal,
        onChanged: updateVal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Filters'), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegeterian
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ]),
        drawer: MainDrawer(),
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.all(20),
              child: Text('Adjust your meal selection.',
                  style: Theme.of(context).textTheme.headline6)),
          Expanded(
            child: ListView(children: <Widget>[
              _buildFilterSwitches(
                  'Gluten-free', 'Only include gluten-free meals.', _glutenFree,
                  (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
              }),
              _buildFilterSwitches(
                  'Vegetarian', 'Only include veggie meals.', _vegeterian,
                  (newValue) {
                setState(() {
                  _vegeterian = newValue;
                });
              }),
              _buildFilterSwitches('Vegan', 'Only include vegan meals.', _vegan,
                  (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              }),
              _buildFilterSwitches('Lactose-free',
                  'Only include lactose-free meals.', _lactoseFree, (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
              }),
            ]),
          )
        ]));
  }
}
