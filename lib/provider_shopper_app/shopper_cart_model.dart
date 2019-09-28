import 'package:flutter/material.dart';
import 'package:flutter_samples/provider_shopper_app/shopper_catalog_model.dart';

class ShopperCartModel extends ChangeNotifier {
  /// The current catalog. Used to construct items from numeric ids.
  final ShopperCatalogModel _catalogModel;

  /// Internal, private state of the cart. Stores the ids of each item.
  final List<int> _itemIDs;

  /// Construct a CartModel instance that is backed by a [CatalogModel] and
  /// an optional previous state of the cart.
  /// If [previous] is not `null`, it's items are copied to the newly
  /// constructed instance.
  ShopperCartModel(this._catalogModel, ShopperCartModel previous)
      : assert(_catalogModel != null),
        _itemIDs = previous?._itemIDs ?? [];

  /// List of items in the cart.
  List<Item> get items =>
      _itemIDs.map((id) => _catalogModel.getByID(id)).toList();

  /// The current total price of all items.
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item) {
    _itemIDs.add(item.id);
    notifyListeners();
  }
}
