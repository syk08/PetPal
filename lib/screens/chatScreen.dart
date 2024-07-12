import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import 'vetClinic/chat/dateformatting.dart';

class ChatRoom extends StatefulWidget {
  final String chatRoomId;
  final String vetname;
  final String username;
  final int index;

  ChatRoom(
      {required this.chatRoomId,
      required this.vetname,
      required this.username,
      required this.index});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String name = "";

  final TextEditingController _message = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? imageFile;

  bool isFirstMessage = false;

  Map<String, dynamic> chatData = {};

  // String getUsersData() {
  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;

    await _firestore
        .collection('Chatroom')
        .doc(widget.chatRoomId)
        .collection('chats')
        .doc(fileName)
        .set({
      "sendby": widget.username,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });

    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await _firestore
          .collection('Chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      await _firestore
          .collection('Chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});

      print(imageUrl);
      //await _firestore.collection('Chatroom').doc(widget.chatRoomId).set({});
    }
  }

  void onSendMessage() {
    setState(() {
      FirebaseFirestore.instance
          .collection('conversations')
          .doc(widget.chatRoomId)
          .set({
        'chatRoomID': widget.chatRoomId,
        'vetname': widget.vetname,
        'username': widget.username,
        //'owner': "",
        //'imageUrl': ""
      }, SetOptions(merge: true));

      final docRef = _firestore.collection('Chatroom').doc(widget.chatRoomId);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          print("Inside");

          chatData = data;
          print(chatData);
        },
        onError: (e) => print("Error getting document: $e"),
      );
      print("Outside");
      print(chatData);

      if (_message.text.isNotEmpty) {
        Map<String, dynamic> messages = {
          "sendby": widget.username,
          "message": _message.text,
          "type": "text",
          "time": FieldValue.serverTimestamp(),
        };

        print("choltese?");

        if (isFirstMessage == true) {
          print("prothombar");
          Map<String, dynamic> newEntry = {
            "from_user": widget.username,
            "to_user": widget.vetname,
            "from_num": 1,
            "to_num": 0,
            "last_message": _message.text,
            "last_time": FieldValue.serverTimestamp(),
            "last_sendby": widget.username
          };

          _firestore
              .collection('Chatroom')
              .doc(widget.chatRoomId)
              .set(newEntry, SetOptions(merge: true));
          isFirstMessage = false;
        } else {
          print("puran manush");
          print(chatData);
          if (chatData['from_user'] == widget.username) {
            Map<String, dynamic> Entry = {
              "from_user": chatData['from_user'],
              "to_user": chatData['to_user'],
              "from_num": chatData['from_num'] + 1,
              "to_num": chatData['to_num'],
              "last_message": _message.text,
              "last_time": FieldValue.serverTimestamp(),
              "last_sendby": widget.vetname
            };

            _firestore
                .collection('Chatroom')
                .doc(widget.chatRoomId)
                .set(Entry, SetOptions(merge: true));
          } else {
            Map<String, dynamic> Entry2 = {
              "from_user": chatData['from_user'],
              "to_user": chatData['to_user'],
              "from_num": chatData['from_num'],
              "to_num": chatData['to_num'] + 1,
              "last_message": _message.text,
              "last_time": FieldValue.serverTimestamp(),
              "last_sendby": widget.username
            };

            _firestore
                .collection('Chatroom')
                .doc(widget.chatRoomId)
                .set(Entry2, SetOptions(merge: true));
          }
        }

        print("maybe");

        _message.clear();
        _firestore
            .collection('Chatroom')
            .doc(widget.chatRoomId)
            .collection('chats')
            .add(messages);
      } else {
        print("Enter Some Text");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: const Color(0xFF075E54),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back,
                size: 25,
              ),
            ),
          ),
          leadingWidth: 20,
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/vet${widget.index}.jpg',
                    height: 35,
                    width: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Add your onPressed action here
                          context.go(
                            '/profileChat',
                            extra: {
                              //'path': widget.path,
                              'name': widget.vetname,
                            },
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align text to the start of the column
                          children: [
                            Text(
                              widget.vetname,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Online",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.withOpacity(.8),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(top: 10, right: 25),
              child: Icon(
                Icons.videocam,
                size: 25,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, right: 20),
              child: Icon(
                Icons.call,
                size: 25,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, right: 10),
              child: Icon(
                Icons.more_vert,
                size: 25,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('Chatroom')
                    .doc(widget.chatRoomId)
                    .collection('chats')
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    //print(" list make");
                    if (isFirstMessage != true) isFirstMessage = false;
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        print(map);
                        //print("ekhane ashe prothombare keno");
                        return messages(size, map, context);
                      },
                    );
                  } else {
                    //print(isFirstMessage);
                    //print("thik korar por");

                    isFirstMessage = true;
                    //print(isFirstMessage);
                    return Container(
                        alignment: Alignment.center,
                        child: Text("Nothing to show here!"));
                  }
                },
              ),
            ),
            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      //height: size.height / 17,
                      //width: size.width / 1.7,
                      child: Expanded(
                          child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: _message,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () => getImage(),
                              icon: Icon(Icons.photo),
                            ),
                            hintText: "Send Message",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      )),
                    ),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                          icon: Icon(Icons.send), onPressed: onSendMessage),
                      /*IconButton(
                        icon: Icon(Icons.directions),
                        onPressed: () {
                          print(getuid(userMap['friend']));
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                MyMap(getuid(userMap['friend'])),
                          ));
                        },
                      ),*/
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    return map['type'] == "text"
        ? Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
                Flexible(
                    child: Container(
                  width: size.width,
                  alignment: map['sendby'] == widget.username
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      border: map['sendby'] == widget.username
                          ? Border.all(color: Colors.white)
                          : Border.all(color: Colors.blueGrey),
                      borderRadius: map['sendby'] == widget.username
                          ? BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30))
                          : BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                      color: map['sendby'] == widget.username
                          ? Colors.blueGrey
                          : Colors.white,
                    ),
                    child: Text(
                      map['message'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: map['sendby'] == widget.username
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                )),
                /*Padding(

    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * .04),
    child: Text("time sent",
    style: const TextStyle(fontSize: 13, color: Colors.black54),
      textAlign: TextAlign.left,
    ),
    ),*/
                Container(
                  width: size.width,
                  alignment: map['sendby'] == widget.username
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: map['time'] == null
                        ? Text("Loading...")
                        : Text(
                            MyDateUtil.getMessageTime(
                                context: context,
                                time: map['time']
                                    .toDate()
                                    .millisecondsSinceEpoch
                                    .toString()),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                  ),
                )
              ])
        : Container(
            height: size.height / 2.5,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: map['sendby'] == widget.username
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShowImage(
                    imageUrl: map['message'],
                  ),
                ),
              ),
              child: Container(
                height: size.height / 2.5,
                width: size.width / 2,
                decoration: BoxDecoration(border: Border.all()),
                alignment: map['message'] != "" ? null : Alignment.center,
                child: map['message'] != ""
                    ? Image.network(
                        map['message'],
                        fit: BoxFit.cover,
                      )
                    : CircularProgressIndicator(),
              ),
            ),
          );
  }
}

class ShowImage extends StatefulWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(widget.imageUrl),
      ),
    );
  }
}

//
