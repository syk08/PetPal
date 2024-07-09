import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WhatsappChat extends StatefulWidget {
  const WhatsappChat({super.key, required this.path, required this.name});

  final int path;
  final String name;

  @override
  // ignore: library_private_types_in_public_api
  _WhatsappChatState createState() => _WhatsappChatState();
}

class _WhatsappChatState extends State<WhatsappChat> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                GoRouter.of(context).go('/vet');
                
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
                    'assets/images/vet${widget.path}.jpg',
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
                                      'path': widget.path, 
                                      'name': widget.name,
                                    },
                                  );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align text to the start of the column
                          children: [
                            Text(
                              widget.name,
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
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true, // Set reverse to true
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 5, top: 5, bottom: 5),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 8, 10, 10),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _messages[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
