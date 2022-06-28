import 'dart:convert';

import 'package:crud/constants/base_api.dart';
import 'package:crud/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'constants/util.dart';

class createProduct extends StatefulWidget {
  const createProduct({Key? key}) : super(key: key);

  @override
  State<createProduct> createState() => _createProductState();
}

class _createProductState extends State<createProduct> {
  final TextEditingController _controllerProductName =
      new TextEditingController();
  final TextEditingController _controllerProductPrice =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('creating product')),
      body: getBody(),
    );
  }

  Widget getBody() {
    return ListView(
      padding: EdgeInsets.all(30),
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerProductName,
          decoration: InputDecoration(
            hintText: "ProductName",
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerProductPrice,
          decoration: InputDecoration(
            hintText: "productPrice",
          ),
        ),
        SizedBox(
          height: 40,
        ),
        FlatButton(
            color: primary,
            onPressed: () {
              CreateNewProduct();
            },
            child: Text(
              "done",
              style: TextStyle(
                color: white,
              ),
            ))
      ],
    );
  }

  CreateNewProduct() async {
    var ProductName = _controllerProductName.text;
    var ProductPrice = _controllerProductPrice.text;
    // print('ProductName : ${ProductName.text}');
    // print('ProductPrice: ${ProductPrice.text}');

    if (ProductName.isNotEmpty && ProductPrice.isNotEmpty) {
      var url = BASE_API + "products/";
      var bodyData = json.encode({
        "name_product": ProductName,
        "price_product": ProductPrice,
      });
      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: bodyData);
      print(response.statusCode);
      print(response.body);
      var pro = json.decode(response.body)['name_product'];
      print(pro);

      if (response.statusCode == 200) {
        setState(() {
          var messageSuccess = "";
          showMessage(context, messageSuccess);

          _controllerProductName.text = "";
          _controllerProductPrice.text = "";
        });
      } else {
        var message = 'success';
        showMessage(context, message);
      }
    }
  }
}
