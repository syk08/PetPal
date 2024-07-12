import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_pal/cartmodel.dart';
import 'package:pet_pal/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'cart.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

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

  final List<Map<String, dynamic>> products = [
    {
      "id": "one",
      "category": "Cat",
      "name": "Whiskas",
      "price": 10.0,
      "image": "assets/images/cats/food1.jpg"
    },
    {
      "id": "two",
      "category": "Hygiene",
      "name": "Litter Box",
      "price": 20.0,
      "image": "assets/images/cats/litter1.jpg"
    },
    {
      "id": "three",
      "category": "Toys",
      "name": "Cat Toy",
      "price": 20.0,
      "image": "assets/images/cats/toy1.jpg"
    },
    {
      "id": "four",
      "category": "Hygiene",
      "name": "Litter Box",
      "price": 20.0,
      "image": "assets/images/cats/litter2.jpg"
    },
    {
      "id": "five",
      "category": "Toys",
      "name": "Cat Toy",
      "price": 35.0,
      "image": "assets/images/cats/toy2.jpg"
    },
    {
      "id": "six",
      "category": "Cat",
      "name": "SmartHeart",
      "price": 20.0,
      "image": "assets/images/cats/food2.png"
    },
    {
      "id": "seven",
      "category": "Dog",
      "name": "DogChow",
      "price": 15.0,
      "image": "assets/images/dogs/food1.png"
    },
    {
      "id": "eight",
      "category": "Hygiene",
      "name": "Litter Box",
      "price": 20.0,
      "image": "assets/images/dogs/litter1.png"
    },
    {
      "id": "nine",
      "category": "Dog",
      "name": "PuppyChow",
      "price": 15.0,
      "image": "assets/images/dogs/food2.jpg"
    },
    {
      "id": "ten",
      "category": "Toys",
      "name": "Dog Toy",
      "price": 15.0,
      "image": "assets/images/dogs/toy1.jpg"
    },
    {
      "id": "eleven",
      "category": "Cat",
      "name": "MeowMix",
      "price": 20.0,
      "image": "assets/images/cats/food3.jpg"
    },
    {
      "id": "twelve",
      "category": "Cat",
      "name": "Treats",
      "price": 25.0,
      "image": "assets/images/cats/food4.png"
    },
    // Add more products here...
  ];

  String selectedCategory = 'All';
  // Map<String, int> cart = {};

  // void _addToCart(Map<String, dynamic> product) {
  //   setState(() {
  //     final productId = product['id'] as String;
  //     if (cart.containsKey(productId)) {
  //       cart[productId] = cart[productId]! + 1; // Increment quantity
  //     } else {
  //       cart[productId] = 1; // Add new item with quantity 1
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // var cart = Provider.of<CartModel>(context);
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });

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

    List<Map<String, dynamic>> filteredProducts = selectedCategory == 'All'
        ? products
        : products
            .where((product) => product['category'] == selectedCategory)
            .toList();

    return Scaffold(
      appBar: Navbar(
        title: 'PetMart',
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: Column(
        children: [
          _buildCategorySlider(),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return _buildProductCard(filteredProducts[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildCategorySlider() {
    final categories = ['All', 'Cat', 'Dog', 'Hygiene', 'Toys'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ChoiceChip(
              label: Text(category),
              selected: selectedCategory == category,
              onSelected: (bool selected) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    var cart = Provider.of<CartModel>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Color.fromARGB(255, 157, 208, 232),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                product['image'],
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product['name'],
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: () => cart.addToCart(product),
                ),
              ],
            ),
            Text(
              '\$${product['price']}',
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
