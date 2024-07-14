import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_pal/widgets/navbar.dart';
import 'dart:io';

import '../storage/firebase_storage.dart';
import '../storage/firestore_url.dart';

class PostsPage extends StatefulWidget {
  static const routeName = '/posts';

  PostsPage({Key? key}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final FirebaseStorageService _storageService = FirebaseStorageService();
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _controller = TextEditingController();
  User? _user;
  String? _userName;
  List<Map<String, dynamic>> posts = [
    {"text": "Lost dog near Central Park", "image": null, "comments": []},
    {"text": "Looking to adopt a cat", "image": null, "comments": []},
    {"text": "Found a puppy near the river", "image": null, "comments": []},
  ];

  File _image = File(AutofillHints.addressCity);
  File _imageFile = File(AutofillHints.addressCity);
  String? _imageUrl, temp;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _user = user;
      });
      await _getUserDetails(user.uid);
      //await _fetchPosts();
    }
  }

  Future<void> _getUserDetails(String uid) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('UserData').doc(uid).get();
    if (userDoc.exists) {
      setState(() {
        _userName = userDoc['username'];
      });
    }
  }

  void _addPost() async {
    setState(() {
      posts.add({"text": _controller.text, "image": _image, "comments": []});
      temp = _controller.text;
      _imageFile = _image;
      _controller.clear();
      _image = File(AutofillHints.addressCity);
    });

    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final downloadUrl = await _storageService.uploadImage(_imageFile, fileName);

    if (downloadUrl == null) return;

    setState(() {
      _imageUrl = downloadUrl;
    });

    // Save image URL to Firestore
    await _firestoreService.saveImageUrl(downloadUrl, fileName);
    final timestamp = DateTime.now();
    await _firestoreService.addPost(temp, _imageUrl, timestamp, 0, _userName);
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

  void _addComment(String postId, String comment) async {
    if (_userName != null) {
      final timestamp = DateTime.now();
      await _firestoreService.addComment(
          postId, comment, _userName!, timestamp);
    }
  }

  void handleLike(String id) async {
    await _firestoreService.addLike(id, _userName!);
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
                      icon: Icon(Icons.photo),
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
                Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .orderBy('timestamp')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Expanded(
                        child: ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            List<dynamic> likes = data['likes'];
                            String postId = document.id;
                            return Card(
                              color: const Color.fromARGB(255, 88, 146, 173),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (data['imageUrl'] != null)
                                      Row(
                                        children: [
                                          Text(data['poster'],
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Pacifico')),
                                          Gap(5),
                                          Text(data['timestamp'].toDate().toString(),
                                              style: const TextStyle(
                                                fontSize: 11,
                                                  color: Colors.white,
                                                  )),
                                        ],
                                      ),
                                    Image(
                                      image: NetworkImage(data['imageUrl']),
                                      width: 300,
                                      height: 300,
                                    ),
                                    Text(data['post'],
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.thumb_up,
                                              color: likes.contains(_userName) ? Colors.white : Theme.of(context).cardTheme.color,),
                                              onPressed: () {
                                                handleLike(postId);
                                              },
                                            ),
                                          Gap(2),
                                          if(likes.length > 0) Text(likes.length.toString()),
                                          ],
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.comment),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                final TextEditingController
                                                    _commentController =
                                                    TextEditingController();
                                                return AlertDialog(
                                                  title: Text('Add a comment'),
                                                  content: TextField(
                                                    controller:
                                                        _commentController,
                                                    decoration: InputDecoration(
                                                      labelText: 'Comment',
                                                    ),
                                                  ),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        _addComment(
                                                            postId,
                                                            _commentController
                                                                .text);
                                                        Navigator.of(context)
                                                            .pop();
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
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('posts')
                                          .doc(postId)
                                          .collection('comments')
                                          .orderBy('timestamp')
                                          .snapshots(),
                                      builder: (context, commentSnapshot) {
                                        if (!commentSnapshot.hasData) {
                                          return SizedBox.shrink();
                                        }
                                        var comments =
                                            commentSnapshot.data!.docs;
                                        return ExpansionTile(
                                          title: Text(
                                              'View all comments (${comments.length})'),
                                          children: comments.map((commentDoc) {
                                            Map<String, dynamic> commentData =
                                                commentDoc.data()!
                                                    as Map<String, dynamic>;
                                            return ListTile(
                                              title:
                                                  Text(commentData['comment']),
                                              subtitle: Text(
                                                  'By ${commentData['username']} at ${commentData['timestamp'].toDate()}'),
                                            );
                                          }).toList(),
                                          backgroundColor: Color.fromARGB(
                                              255, 126, 177, 201),
                                          collapsedBackgroundColor:
                                              Color.fromARGB(
                                                  255, 110, 159, 183),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
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
