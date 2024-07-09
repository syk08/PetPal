import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _postsCollection = FirebaseFirestore.instance.collection('posts');


  Future<void> saveImageUrl(String imageUrl, String documentId) async {
    try {
      await _firestore.collection('images').doc(documentId).set({
        'imageUrl': imageUrl,
      });
    } catch (e) {
      print(e);
    }
  }

    Future<void> addPost(String? text, String? imageUrl, DateTime timestamp, int likes,String? user) async {
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

  Future<void> addComment(String postId, String comment, String userName, DateTime timestamp) async {
    try {
      await _firestore.collection('posts').doc(postId).collection('comments').add({
        'comment': comment,
        'username': userName,
        'timestamp': timestamp,
      });
    } catch (e) {
      print(e);
    }
  }
}
