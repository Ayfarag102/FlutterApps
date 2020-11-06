import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
//import '../providers/models/grocery.dart';

class BuildNumberRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150.0,
          child: RaisedButton(
            child: Text("Add Quantity"),
            onPressed: () => showMaterialNumberPicker(
              context: context,
              title: "Quantity Items",
              maxNumber: 50,
              minNumber: 1,
              confirmText: "Okay",
              cancelText: "Cancel",
              //  selectedNumber: Grocery.quantity,
              // onChanged: (v) => setState(() => )
            ),
          ),
        ),
      ],
    );
  }
}
/*ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text("Processing Data")));
                }
              },
              child: Text('Add Grocery List'),
            ) */
