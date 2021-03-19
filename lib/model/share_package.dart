import 'package:flutter/material.dart';
import 'package:share/share.dart';
final String subject = "";
onShare(context, String text) async {
  // A builder is used to retrieve the context immediately
  // surrounding the RaisedButton.
  //
  // The context's `findRenderObject` returns the first
  // RenderObject in its descendent tree when it's not
  // a RenderObjectWidget. The RaisedButton's RenderObject
  // has its position and size after it's built.
  final RenderBox box = context.findRenderObject();

  await Share.share(text,
      subject: subject,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}