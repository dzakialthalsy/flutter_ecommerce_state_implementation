import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class ProductListScreen extends StatelessWidget {
  final List<Product> products = [
    Product(id: '1', name: 'Sepatu Keren', price: 500000),
    Product(id: '2', name: 'Tas Punggung', price: 350000),
    Product(id: '3', name: 'Topi Kece', price: 150000),
    Product(id: '4', name: 'Kaos Polos', price: 100000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toko Saya'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            title: Text(products[i].name),
            subtitle: Text('Rp ${products[i].price}'),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                // Memanggil fungsi addToCart tanpa mendengarkan perubahan (listen: false)
                Provider.of<CartProvider>(
                  context,
                  listen: false,
                ).addToCart(products[i]);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${products[i].name} ditambah ke keranjang!'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
