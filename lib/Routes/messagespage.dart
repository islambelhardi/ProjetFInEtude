// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Widgets/conversation.dart';
import 'package:projet_fin_etude/models or classes/chat_user.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "Thamer sekhri",
        messageText: "Awesome ",
        imageURL:
            "https://scontent.fogx1-2.fna.fbcdn.net/v/t1.6435-9/136336596_1390435887974379_5447428029288955471_n.jpg?_nc_cat=106&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeF6bklpwoZoN-ydFbqN06JC_lwIyGjI0bP-XAjIaMjRs8VaXzQIOZahokQNEUg3HBTA-H_RpKLjK1fnI6Px4E6n&_nc_ohc=7NXb99p3yIYAX_ImojM&tn=eoS-ofEnYkm8WG9a&_nc_ht=scontent.fogx1-2.fna&oh=00_AT9jDMImKAjwoWaAwvvgD57j-0jh47hvdjJepDR7ULUaVw&oe=627DF045",
        time: "Now"),
    ChatUsers(
        name: "Gouder haithem",
        messageText: "suiiiiiiiiii",
        imageURL:
            "https://scontent.fogx1-2.fna.fbcdn.net/v/t39.30808-6/230343407_1439909299727515_7988115582448082082_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeFHu2J1N3AKQO0mMETWDqYBTLDW3V8kRbZMsNbdXyRFtnm3xfWvVvKeNA0_KSLHsv_fGjMeEHE3qITSpBsjifJc&_nc_ohc=L3vf38bCcVQAX_TcQ5d&tn=eoS-ofEnYkm8WG9a&_nc_ht=scontent.fogx1-2.fna&oh=00_AT_TBIo6x5iHgdLMaX6lQF8teKzdHo5G5j9REw9b2iJPEw&oe=625C7409",
        time: "Yesterday"),
    ChatUsers(
        name: "Akram",
        messageText: "السلام عليكم",
        imageURL:
            "https://scontent.fogx1-2.fna.fbcdn.net/v/t1.6435-9/123293780_1529481053904520_4296208249742274342_n.jpg?_nc_cat=108&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeEynYXrT8uTHsQQq8KcW0ULD5d4ZodxOJcPl3hmh3E4l_fa54OilxesXKTWjhuwyAc-qTNmk9L0hxllU1u_-NiI&_nc_ohc=ssbeIMpBSTMAX99brZ8&_nc_ht=scontent.fogx1-2.fna&oh=00_AT9T8m2q-LzwtqTNZnbFq1nKzGTzQdCg6pKFb_rwKTDpwA&oe=627DB5C7",
        time: "31 Mar"),
    ChatUsers(
        name: "بدر عاد",
        messageText: "ok",
        imageURL:
            "https://scontent.fogx1-2.fna.fbcdn.net/v/t39.30808-6/273574502_3016821491906158_2395788792921690313_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeH4T5Md_s8WR4uCi_mJUmQwpljETkk7KS6mWMROSTspLnmN2hIr9mDcu-Bz5PdTGWk90enqXH-bH4ZljiqbVYNm&_nc_ohc=ovVoZbt0aBcAX_DwQlz&_nc_ht=scontent.fogx1-2.fna&oh=00_AT80104rj7oEIDll5eNoidQUmnORhogwk_p6QhMeGoIOfA&oe=625B91A2",
        time: "28 Mar"),
    ChatUsers(
        name: "Islam belhardi",
        messageText: "Thankyou, It's awesome",
        imageURL:
            "https://scontent.fogx1-1.fna.fbcdn.net/v/t1.6435-9/80389008_464366174489481_380651642795589632_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeE-ASAJ3WrGoRMsG1fMdE2qDD6YTYl6PVMMPphNiXo9UznoV1VEB_WJPVV2Ugw3wnb3YqlK7KkjgpnvwRhlyPDi&_nc_ohc=C_dnq0FFDfsAX-OnyX5&_nc_ht=scontent.fogx1-1.fna&oh=00_AT_I158MXqsBfoyzuKZ4z6Z6xdN1ngnM-SHQ0wMeMULN6w&oe=627D7903",
        time: "23 Mar"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            //search barr
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            //end search bar
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
