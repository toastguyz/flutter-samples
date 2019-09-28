import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/provider_shopper_app/shopper_cart_model.dart';
import 'package:flutter_samples/provider_shopper_app/shopper_catalog_model.dart';
import 'package:provider/provider.dart';

class ProviderShopperApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProviderShopperAppState();
  }
}

class ProviderShopperAppState extends State<ProviderShopperApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("Shopper Provider"),
            floating: true,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/providerShopperCart");
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 12.0,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MyListItem(index)),
          ),
        ],
      ),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  _MyListItem(this.index);

  @override
  Widget build(BuildContext context) {
    var catalog = Provider.of<ShopperCatalogModel>(context);
    var item = catalog.getByPosition(index);
    var textTheme = Theme.of(context).textTheme.title;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: LimitedBox(
        maxHeight: 48.0,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            SizedBox(
              width: 24.0,
            ),
            Expanded(
              child: Text(
                item.name,
                style: textTheme,
              ),
            ),
            SizedBox(
              width: 24.0,
            ),
            _AddButton(
              item: item,
            )
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<ShopperCartModel>(context);

    return FlatButton(
      onPressed: cart.items.contains(item) ? null : () => cart.add(item),
      splashColor: Theme.of(context).primaryColor,
      child: cart.items.contains(item)
          ? Icon(Icons.check, semanticLabel: 'ADDED')
          : Text('ADD'),
    );
  }
}
