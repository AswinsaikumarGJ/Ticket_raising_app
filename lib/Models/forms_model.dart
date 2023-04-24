import 'package:cloud_firestore/cloud_firestore.dart';

class FormsModel {
  final String? title;
  final String? description;
  final String? location;
  final String? date;
  final String? attachment;
  final String? attachmentname;

  FormsModel(
      {required this.title,
      required this.description,
      required this.location,
      required this.date,
      required this.attachment,
      required this.attachmentname});

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Description": description,
        "Location": location,
        "Date": date,
        "Attachment": attachment,
        "Attachmentname": attachmentname
      };

  static FormsModel fromJson(Map<String, dynamic> document) => FormsModel(
      title: document["Title"],
      description: document['Description'],
      location: document['Location'],
      date: document['Date'],
      attachment: document['Attachment'],
      attachmentname: document['Attachmentname']);
}
