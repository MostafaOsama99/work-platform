import 'package:flutter/material.dart';
import 'package:project/widgets/chat/chat_design.dart';
import 'package:project/widgets/task/add_teams_button.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import '../constants.dart';
import '../demoData.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: PreferredSize(
       preferredSize: Size.fromHeight(45),
       child: ClipRRect(
         borderRadius: BorderRadius.only(
             bottomLeft: Radius.circular(KAppBarRound),
             bottomRight: Radius.circular(KAppBarRound)),
         child: AppBar(
           centerTitle: true,
           title: Text("Chat")
         ),
       ),
     ),
     body: Column(
       children: [
         Expanded(
           child: ListView.builder(
               itemCount: messagesList.length,
               itemBuilder: (context,i){
             return messageBuble(sender: messagesList[i].senderName,text: messagesList[i].text,IsMe: messagesList[i].isMe,);
           }),


         ),
         Row(
           children: [
             SizedBox(
               width: MediaQuery.of(context).size.width * 0.66,
               height: 42,
               child: TextFormField(
                 textInputAction: TextInputAction.newline,
                 onFieldSubmitted: (_) {},
                 autofocus: false,
                 maxLines: 3,
                 keyboardType: TextInputType.multiline,
                 decoration: InputDecoration(
                   hintText: "write something ..",
                   contentPadding: EdgeInsets.only(
                       left: 20, right: 20, bottom: 20, top: 5),
                   isDense: true,
                   filled: true,
                   fillColor: Colors.white54,
                   hintStyle: TextStyle(color: Colors.grey[700]),
                   focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide(width: 2),
                     borderRadius: BorderRadius.circular(25),
                   ),
                   enabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.white54),
                     borderRadius: BorderRadius.circular(25),
                   ),
                   focusedErrorBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.red, width: 1.5),
                     borderRadius: BorderRadius.circular(25),
                   ),
                   errorBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.red, width: 2),
                     borderRadius: BorderRadius.circular(25),
                   ),
                 ),
               ),
             ),
             Padding(
               padding: EdgeInsets.only(left: 20),
               child: addTeamsButton(hintText: "Send", onPressed: () {}),
             )
           ],
         ),

       ],
     ),
   );
  }

}
