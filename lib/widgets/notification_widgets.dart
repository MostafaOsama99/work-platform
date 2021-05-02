import 'package:flutter/material.dart';
Widget eventLabelWidget(String text,Function onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 90,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.all(Radius.circular(18.0) //
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.blue),
        ),
      ),
    ),
  );
}

Widget NotificationWidget (context){
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.68,
                  child: Text(
                    "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFssssssaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaFFFFhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhFFFff",
                    style: TextStyle(fontSize: 16),
                    softWrap: true,
                    maxLines: 3,
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                timeCalculation(380),
                SizedBox(
                  height: 10,
                ),
                Icon(Icons.more_vert)
              ],
            ),
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15, left: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            eventLabelWidget("Congrats",(){}),
            eventLabelWidget("Congrats",(){}),
            eventLabelWidget("Congrats",(){}),
          ],
        ),
      ),


    ],
  );
}

Widget timeCalculation (int x){
  if (x<24){
    return Text("${x}h");}
  else if (x<365)
    return  Text("${(x/28).toInt()} m");

  else return Text("${(x/365).toInt()} y");



}


