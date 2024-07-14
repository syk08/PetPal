import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');

  Future<void> saveImageUrl(String imageUrl, String documentId) async {
    try {
      await _firestore.collection('images').doc(documentId).set({
        'imageUrl': imageUrl,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addPost(String? text, String? imageUrl, DateTime timestamp,
      int likes, String? user) async {
    try {
      await _postsCollection.add({
        'post': text,
        'poster': user,
        'imageUrl': imageUrl,
        'likes': likes,
        'timestamp': timestamp,
      });
    } catch (e) {
      print('Error adding post: $e');
      throw e;
    }
  }

  Future<void> addComment(String postId, String comment, String userName,
      DateTime timestamp) async {
    try {
      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .add({
        'comment': comment,
        'username': userName,
        'timestamp': timestamp,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addLike(String postId, String? userName) async {
    try {
      DocumentSnapshot ds =
          await _firestore.collection('posts').doc(postId).get();

      List<dynamic> arr = ds['likes'];

      if (arr.contains(userName)) {
        arr.remove(userName);
      } else {
        arr.add(userName!);
      }
      await _firestore.collection('posts').doc(postId).set({
        'imageUrl': ds['imageUrl'],
        'post': ds['post'],
        'poster': ds['poster'],
        'timestamp': ds['timestamp'],
        'likes': arr
        });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addPet(
      String petname, String? imageUrl, String? userName) async {
    DocumentSnapshot docSnapshot =
        await FirebaseFirestore.instance.collection('pets').doc(petname).get();
    //var currentData = docSnapshot.data() as Map<String, dynamic>;
    try {
      print("ashena?");
      await FirebaseFirestore.instance.collection('pets').doc(petname).set(
          {'name': petname, 'owner': userName, 'imageUrl': imageUrl},
          SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }
}
