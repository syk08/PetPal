import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> product) {
    // Check if the product is already in cart
    bool found = false;
    for (var item in _cartItems) {
      if (item['id'] == product['id']) {
        item['quantity'] = (item['quantity'] ?? 1) + 1; // Increment quantity
        found = true;
        break;
      }
    }

    // If not found, add it with quantity 1
    if (!found) {
      _cartItems.add({...product, 'quantity': 1});
    }

    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _cartItems[index]['quantity']++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_cartItems[index]['quantity'] > 0) {
      _cartItems[index]['quantity']--;
      notifyListeners();
    }
  }
}
