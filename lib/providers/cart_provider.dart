import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  // List private untuk menampung item di keranjang
  final List<Product> _cartItems = [];

  // Getter untuk mengambil list item
  List<Product> get items => _cartItems;

  // Fungsi untuk menambah barang ke keranjang
  void addToCart(Product product) {
    _cartItems.add(product);
    // Memberitahu semua widget yang 'mendengarkan' bahwa data berubah
    notifyListeners();
  }

  // Fungsi menghitung total harga
  double get totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + item.price);
  }

  // Fungsi untuk mengosongkan keranjang (opsional)
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
