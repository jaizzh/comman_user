import 'package:common_user/features/product/model/cart_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void addToCart(CartItem item, {int quantity = 1}) {
    final index = _items.indexWhere((e) => e.name == item.name);
    if (index >= 0) {
      _items[index].quantity += quantity; // always add quantity
    } else {
      _items.add(
        CartItem(
          name: item.name,
          image: item.image,
          price: item.price,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    final index = _items.indexWhere((e) => e.name == item.name);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity -= 1;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }
}
