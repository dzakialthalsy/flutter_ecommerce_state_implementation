import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mendengarkan perubahan di CartProvider
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Keranjang Belanja')),
      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty
                ? Center(child: Text('Keranjang kosong'))
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (ctx, i) => ListTile(
                      leading: CircleAvatar(child: Text('${i + 1}')),
                      title: Text(cart.items[i].name),
                      subtitle: Text('Rp ${cart.items[i].price}'),
                    ),
                  ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Harga:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp ${cart.totalPrice}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
