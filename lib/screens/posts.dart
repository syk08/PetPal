import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_pal/widgets/navbar.dart';
import 'dart:io';

class PostsPage extends StatefulWidget {
  static const routeName = '/posts';

  PostsPage({Key? key}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> posts = [
    {"text": "Lost dog near Central Park", "image": null, "comments": []},
    {"text": "Looking to adopt a cat", "image": null, "comments": []},
    {"text": "Found a puppy near the river", "image": null, "comments": []},
  ];

  File? _image;

  void _addPost() {
    setState(() {
      posts.add({"text": _controller.text, "image": _image, "comments": []});
      _controller.clear();
      _image = null;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _addComment(int index, String comment) {
    setState(() {
      posts[index]['comments'].add(comment);
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 233, 255),
      appBar: Navbar(
        title: 'Community',
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Make a post!',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.photo,
                      ),
                      onPressed: _pickImage,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _addPost,
                      child: Text(
                        'Post',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 88, 146, 173),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Color.fromARGB(255, 88, 146, 173),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (posts[index]['image'] != null)
                                Image.file(posts[index]['image']),
                              Text(posts[index]['text'],
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.thumb_up),
                                    onPressed: () {
                                      // Handle like action
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.comment),
                                    onPressed: () {
                                      // Show comment input dialog
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          final TextEditingController
                                              _commentController =
                                              TextEditingController();
                                          return AlertDialog(
                                            title: Text('Add a comment'),
                                            content: TextField(
                                              controller: _commentController,
                                              decoration: InputDecoration(
                                                labelText: 'Comment',
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  _addComment(index,
                                                      _commentController.text);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Add'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              if (posts[index]['comments'].isNotEmpty)
                                ExpansionTile(
                                  title: Text('View all comments'),
                                  children: posts[index]['comments']
                                      .map<Widget>((comment) =>
                                          ListTile(title: Text(comment)))
                                      .toList(),
                                  backgroundColor:
                                      Color.fromARGB(255, 126, 177, 201),
                                  collapsedBackgroundColor:
                                      Color.fromARGB(255, 110, 159, 183),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
