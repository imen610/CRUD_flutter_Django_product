import 'dart:convert';

import 'package:crud/constants/base_api.dart';
import 'package:crud/create.dart';
import 'package:crud/edit.dart';
import 'package:crud/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List products = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchProduct();
  }

  fetchProduct() async {
    setState(() {
      isLoading = false;
    });
    var url = BASE_API + "products/";
    print(url);
    var response = await http.get(Uri.parse(url));
    // print(response.body);
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      // print(items);
      setState(() {
        products = items;
        isLoading = false;
      });
      return;
    } else {
      setState(() {
        products = [];
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("listing products"),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => createProduct()));
              },
              child: Icon(
                Icons.add,
                color: white,
              ))
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (isLoading || products.length == 0) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return cardItem(products[index]);
        });
  }

  Widget cardItem(item) {
    var ProductName = item['name_product'];
    var ProductPrice = item['price_product'];
    return Card(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            title: Text(ProductName),
            subtitle: Text(ProductPrice.toString()),
          ),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Colors.blueAccent,
            icon: Icons.edit,
            onTap: () => editUser(item),
          ),
          IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => showDeleteAlert(context, item)),
        ],
      ),
    );
  }

  editUser(item) {
    var productId = item['id'].toString();
    var ProductName = item['name_product'].toString();
    var ProductPrice = item['price_product'].toString();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProduct(
                  productId: productId,
                  ProductName: ProductName,
                  ProductPrice: ProductPrice,
                )));
  }

  deleteProduct(productId) async {
    print(productId);
    var url = BASE_API + "products/$productId/";
    var response = await http.delete(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });
    if (response.statusCode == 200) {
      this.fetchProduct();

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => IndexPage()),
          (Route<dynamic> route) => false);
    }
  }

  showDeleteAlert(BuildContext context, item) {
    // set up the buttons
    Widget noButton = FlatButton(
      child: Text(
        "No",
        style: TextStyle(color: primary),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget yesButton = FlatButton(
      child: Text("Yes", style: TextStyle(color: primary)),
      onPressed: () {
        Navigator.pop(context);

        deleteProduct(item['id']);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text("Would you like to delete this user?"),
      actions: [
        noButton,
        yesButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
