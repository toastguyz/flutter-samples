import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/provider_shopper_app/shopper_cart_model.dart';
import 'package:provider/provider.dart';

class ShopperCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: _CartList(),
              ),
            ),
            Divider(
              height: 4.0,
              color: Colors.white,
            ),
            _CartTotal(),
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.title;
    var cart = Provider.of<ShopperCartModel>(context);

    if (cart.items != null && cart.items.length > 0) {
      return ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.done),
            title: Text(
              cart.items[index].name,
              style: itemNameStyle,
            ),
          );
        },
      );
    } else {
      return Center(
        child: Text(
          "No Items Found!!",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
        ),
      );
    }
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.display4.copyWith(fontSize: 40.0);
    return SizedBox(
      height: 80.0,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<ShopperCartModel>(
              builder:
                  (BuildContext context, ShopperCartModel value, Widget child) {
                return Text(
                  "\$${value.totalPrice}",
                  style: hugeStyle,
                );
              },
            ),
            SizedBox(
              width: 24.0,
            ),
            Card(
              elevation: 2.0,
              child: FlatButton(
                color: Colors.white,
                child: Text("BUY"),
                onPressed: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Buying not supported yet !!"),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
