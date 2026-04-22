import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class ProductListScreen extends StatelessWidget {
  // Data produk dengan gambar dan deskripsi
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Nike Air Max',
      price: 500000,
      description: 'Sepatu lari nyaman dengan desain futuristik.',
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=500',
    ),
    Product(
      id: '2',
      name: 'Tas Ransel Waterproof',
      price: 350000,
      description: 'Tas anti air, cocok untuk laptop dan traveling.',
      imageUrl:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?q=80&w=500',
    ),
    Product(
      id: '3',
      name: 'Kacamata Hitam Stylish',
      price: 150000,
      description: 'Lensa UV protection untuk gaya maksimal di pantai.',
      imageUrl:
          'https://images.unsplash.com/photo-1572635196237-14b3f281503f?q=80&w=500',
    ),
    Product(
      id: '4',
      name: 'Apple Watch Series 6',
      price: 750000,
      description:
          'Desain elegan dengan strap kulit asli, cocok untuk acara formal maupun santai.',
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=500',
    ),
    Product(
      id: '5',
      name: 'Headphone Wireless',
      price: 1200000,
      description:
          'Kualitas suara premium dengan fitur noise cancelling untuk pengalaman audio terbaik.',
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=500',
    ),
    Product(
      id: '6',
      name: 'Cannon EOS M50 Camera',
      price: 8500000,
      description:
          'Tangkap setiap momen berharga dengan resolusi tinggi dan autofokus cepat.',
      imageUrl:
          'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Kita cek lebar layar untuk menyesuaikan tampilan
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PAMF Store',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => CartScreen())),
              ),
              // Circle notifikasi jumlah item (tambahan biar makin pro)
              Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: Text(
                    '${context.watch<CartProvider>().items.length}',
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        // Padding dikurangi agar tidak terlalu sempit di sisi samping
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? screenWidth * 0.2 : 15,
          vertical: 20,
        ),
        itemCount: products.length,
        itemBuilder: (ctx, i) {
          final product = products[i];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(
              bottom: 25,
            ), // Jarak antar card diperlebar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Image.network(
                    product.imageUrl,
                    // Height dinaikkan jadi 300-350 agar lebih "panjang" dan megah
                    height: isDesktop ? 400 : 250,
                    width: double.infinity,
                    // BoxFit.cover tetap yang terbaik untuk estetika,
                    // tapi dengan height lebih tinggi, gambar tidak akan terpotong parah.
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20), // Padding dalam diperbesar
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: isDesktop ? 24 : 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rp ${product.price}',
                            style: TextStyle(
                              fontSize: isDesktop ? 22 : 18,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        product.description,
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50, // Tombol dipertebal
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<CartProvider>().addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.name} ditambah!'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add_shopping_cart),
                          label: const Text(
                            'TAMBAH KE KERANJANG',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
