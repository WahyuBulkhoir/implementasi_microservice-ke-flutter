import 'package:flutter/material.dart';
import 'package:product_app/ProductDetailPage.dart';
import 'package:product_app/Providers/product_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    if (productProvider.isLoading) {
      productProvider.fetchProducts();
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        title: const Text(
          "Daftar Produk",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: productProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                final product = productProvider.products[index];
                return Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(64, 75, 96, .9),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 40.0,
                      ),
                      title: Text(
                        product['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "Rp ${product['price']}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(product: product),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
