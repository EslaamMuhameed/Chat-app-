import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constant.dart';
import '../model/message.dart';
import '../widgets/chat_buble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key, required this.email}) : super(key: key);
  var email;
  CollectionReference messeges =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController messegeController = TextEditingController();
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messeges.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageslist = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageslist.add(Message.fromJson(
                  snapshot.data!.docs[i].data() as Map<String, dynamic>));
            }
            return Scaffold(
              backgroundColor: Color(0xff1E1E1E),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Color(0xff1E1E1E),
                title: Text(
                  'Chatty',
                  style: GoogleFonts.atomicAge(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
              ),
              body: Column(children: [
                Divider(
                  color: Colors.white.withOpacity(.35),
                  thickness: 1,
                ),
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return messageslist[index].id == email
                          ? ChatBuble(
                              message: Message(
                                message: messageslist[index].message,
                                id: messageslist[index].id,
                              ),
                            )
                          : ChatBubleForFriend(
                              message: Message(
                                message: messageslist[index].message,
                                id: messageslist[index].id,
                              ),
                            );
                    },
                    itemCount: messageslist.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: messegeController,
                    onSubmitted: (value) {
                      messeges.add(
                        {
                          kMessage: value,
                          kCreatedAt: DateTime.now(),
                          'id': email,
                        },
                      );
                      messegeController.clear();
                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      focusColor: Color(0xff414141),
                      fillColor: Color(0xff414141),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xff414141),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Type a message',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          messeges.add(
                            {
                              kMessage: messegeController.text,
                              kCreatedAt: DateTime.now(),
                              'id': email,
                            },
                          );
                          messegeController.clear();
                          _scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        icon: Image.asset(
                          'assets/images/Vector.png',
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )
              ]),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
