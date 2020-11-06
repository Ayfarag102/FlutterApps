import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:gma_app/providers/grocery_management.dart';
//import 'package:gma_app/providers/models/grocery.dart';
//import 'package:provider/provider.dart';
// import './completed_groceries_screen.dart';
// import './current_groceries_screen.dart';
//import '../widgets/nav.dart';
//import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import '../providers/models/grocery.dart';

class AddGroceriesScreen extends StatefulWidget {
  static const routeName = '/add-grocery';

  @override
  _AddGroceriesScreenState createState() => _AddGroceriesScreenState();
}

class _AddGroceriesScreenState extends State<AddGroceriesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _shopNameController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _nameController = TextEditingController();

  final _nameFocusNode = FocusNode();

  final _quantityController = TextEditingController();
  final _quantityFocusNode = FocusNode();

  // var _isInit = true;
  // var _isLoading = false;

  final List<Map<String, dynamic>> _tempItemList = [];

  // };

  // final _shopNameFocusNode = FocusNode();

  // Grocery _grocery = new Grocery();

  void addItemToList() {
    setState(() {
      // _tempItemList.map((e) => null)

      _tempItemList.add({
        'items': [
          {
            'itemName': _nameController.text,
            'itemQuantity': _quantityController.text,
            'image_url': _imageUrlController.text,
          }
        ]
      });
      debugPrint(_tempItemList.toString());
    });
  }

  Future<void> saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();

    setState(() {
      // _isLoading = true;
    });

    if (_shopNameController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _imageUrlController.text.isEmpty) {
      return;
    }
    // Provider.of<GroceryManagement>(context, listen: false,).addGrocery(_shopNameController.text, _nameController.text, _quantityController.text, _imageUrlController.text, DateTime.now().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text("Add a New Grocery List")),
        body: Container(
            child: Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView(children: <Widget>[
                      Column(
                        children: <Widget>[
                          TextFormField(
                            //initialValue: _init,
                            controller: _shopNameController,
                            textInputAction: TextInputAction.next,

                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_nameFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide a shop name";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Shop Name"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            //initialValue: _init,
                            controller: _nameController,
                            textInputAction: TextInputAction.next,
                            focusNode: _nameFocusNode,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_quantityFocusNode);
                            },

                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide an item name";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Item Name"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            //initialValue: _init,
                            controller: _quantityController,
                            textInputAction: TextInputAction.next,
                            focusNode: _quantityFocusNode,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: false),
                            maxLength: 2,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a quantity';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid number.';
                              }
                              if (double.tryParse(value) <= 0) {
                                return 'Please enter a number greater than zero.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Item Quantity"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(
                                    top: 8,
                                    right: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: _imageUrlController.text.isEmpty
                                      ? Text('Enter an URL')
                                      : FittedBox(
                                          child: Image.network(
                                              _imageUrlController.text),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                      //initialValue: _init,
                                      controller: _imageUrlController,
                                      focusNode: _imageUrlFocusNode,
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.url,
                                      onFieldSubmitted: (_) {},
                                      onEditingComplete: () {
                                        setState(() {});
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please enter an image url";
                                        }
                                        if (!value.startsWith('http') &&
                                            !value.startsWith('https')) {
                                          return "Please provide a valid url";
                                        }
                                        if (!value.endsWith('.png') &&
                                            !value.endsWith('.jpg') &&
                                            !value.endsWith('.jpeg')) {
                                          return 'Please provide a valid image url';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Image URL",
                                        hintText:
                                            "Optional: Add image for easy search",
                                      )),
                                ),
                              ]),
                          SizedBox(
                            height: 10,
                          ),
                          //  This button is used to ADD single items to the list
                          TextButton.icon(
                            onPressed: addItemToList,
                            icon: Icon(Icons.add),
                            label: Text('Add Item to List'),
                            //  color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 170,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                              ),
                            ),
                            // child: SingleChildScrollView(child:,);

                            child: (_tempItemList == null)
                                ? Text('Preview List Here')
                                : SingleChildScrollView(
                                    // controller: controller,
                                    child: Column(children: <Widget>[
                                      ListView.builder(
                                          itemCount: _tempItemList.length,
                                          itemBuilder: (ctx, index) => Card(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                // child: Padding(
                                                //     padding:
                                                //         EdgeInsets.symmetric(
                                                //             vertical: 5,
                                                //             horizontal: 10),
                                                    child: 
                                                    Text(_tempItemList[
                                                            index]["itemName"] +
                                                        "|" +
                                                        _tempItemList[index]
                                                            ["itemQuantity"] +
                                                        "|" +
                                                        _tempItemList[index]
                                                            ["image_url"])),
                                              ))
                                    ]),
                                  ),
                          ),
                          //  This button is used to ADD ALL items in list to final list
                          RaisedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.shopping_cart),
                            label: Text('Add List'),
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ])))));
  }
}
