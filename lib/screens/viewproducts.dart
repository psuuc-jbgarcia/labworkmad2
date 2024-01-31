import 'package:flutter/material.dart';
import 'package:garciajerico_labwork/screens/cartscreen.dart';
import 'package:provider/provider.dart';
import 'package:garciajerico_labwork/models/product.dart';
import 'package:garciajerico_labwork/providers/productprovider.dart';
import 'package:garciajerico_labwork/screens/manageproduct.dart';

class ViewProductsScreen extends StatelessWidget {
  ViewProductsScreen({super.key});

  void openAddProduct(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ManageProductScreen(),
      ),
    );
  }

  void openEditProduct(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ManageProductScreen(
          index: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Products'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: () => openAddProduct(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              leading: IconButton(
                onPressed: () {
                  productsProvider.toggleFavorite(index);
                },
                icon: Icon(Icons.favorite_outline),
              ),
              onTap: () => openEditProduct(context, index),
              trailing: IconButton(
                onPressed: () {
                  productsProvider.addcart(index);
                  print('add cart');
                },
                icon: Icon(Icons.shopping_cart),
              ),
              title: Text(productsProvider.items[index].nameDesc),
              subtitle: Text(productsProvider.items[index].code),
            ),
          );
        },
        itemCount: productsProvider.totalNoItems,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Cart(
                cartItems: productsProvider.cartItems,
              ),
            ),
          );
        },
        child: Icon(Icons.shopping_cart_checkout),
      ),
    );
  }
}