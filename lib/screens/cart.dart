import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_pal/cartmodel.dart';
import 'package:pet_pal/widgets/navbar.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      _selectedIndex = index;
      if (index == 0) {
        GoRouter.of(context).go('/dashboard');
      } else if (index == 1) {
        GoRouter.of(context).go('/mypets');
      } else if (index == 2) {
        GoRouter.of(context).go('/posts');
      } else if (index == 3) {
        GoRouter.of(context).go('/store');
      }
    }

    var cart = Provider.of<CartModel>(context);
    return Scaffold(
      appBar: Navbar(
        title: 'Shopping Cart',
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: ListView.builder(
        itemCount: cart.cartItems.length,
        itemBuilder: (context, index) {
          final product = cart.cartItems[index];

          return Card(
            color: Color.fromARGB(255, 215, 202, 243),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Image.asset(
                      product['image'],
                      height: 70,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '\$${product['price']}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          cart.decrementQuantity(index);

                          if (product['quantity'] == 0) {
                            cart.removeFromCart(index);
                          }
                        },
                      ),
                      Text('${product['quantity']}'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          cart.incrementQuantity(index);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ), // Ensure you handle navigation separately
    );
  }
}
