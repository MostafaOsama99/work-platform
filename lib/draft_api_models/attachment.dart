import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class AttachmentModel {
  final int id;
  final String name,url;


  AttachmentModel(
      {this.id,
      this.name,this.url,
  });
}

Future getAttachment(token, int taskID) async {
  final response = await http.get(
        Uri.parse('https://workera.azurewebsites.net/api/v1/tasks/$taskID/attachments'),

      headers: {
        'content-Type': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $token",
      });
  List<AttachmentModel> attachmentList = [];
  if (response.statusCode >= 400)
    print(response.body);
  else {
    final decodedData = jsonDecode(response.body);
    print("this is attachment data $decodedData");
    final List body = decodedData;
    body.forEach((elementId) {
      attachmentList.add(AttachmentModel(
     id: elementId['id'],
        name: elementId['name'],
        url: elementId['url']

      ));
    });
    return attachmentList;
  }
}
