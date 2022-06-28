import 'dart:convert';

import 'package:crud/constants/base_api.dart';
import 'package:crud/constants/util.dart';
import 'package:crud/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatefulWidget {
  //const EditProduct({Key? key}) : super(key: key);
  String productId;
  String ProductName;
  String ProductPrice;

  EditProduct(
      {required this.productId,
      required this.ProductName,
      required this.ProductPrice});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final TextEditingController _controllerProductName =
      new TextEditingController();
  final TextEditingController _controllerProductPrice =
      new TextEditingController();
  String productId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      productId = widget.productId;
      _controllerProductName.text = widget.ProductName;
      _controllerProductPrice.text = widget.ProductPrice;
    });

    print(widget.productId);
    print(widget.ProductName);
    print(widget.ProductPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editing product')),
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
              EditProduct();
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

  EditProduct() async {
    //  print(url);
    var ProductName = _controllerProductName.text;
    var ProductPrice = _controllerProductPrice.text;
    if (ProductName.isNotEmpty && ProductPrice.isNotEmpty) {
      var url = BASE_API + "products/$productId/";
      var bodyData = json.encode({
        "name_product": ProductName,
        "price_product": ProductPrice,
        // "image_product": null
      });
      var response = await http.put(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: bodyData);
      if (response.statusCode == 200) {
        var messageSuccess = "success";
        showMessage(context, messageSuccess);
      } else {
        var messageError = "Error";
        showMessage(context, messageError);
      }
    }
  }
}
