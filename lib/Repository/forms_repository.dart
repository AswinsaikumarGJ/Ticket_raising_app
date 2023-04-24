import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ticket_raising_app/Models/forms_model.dart';


class FormRepository {
  final _db = FirebaseFirestore.instance;
  createTickets(FormsModel form) {

    _db.collection("Tickets").add(form.toJson()).whenComplete(() {
      print("Successfully posted");
    }).catchError((error, StackTrace) {
      print("Error,Try again later");
    });
  }

  Stream<List<FormsModel>> getTicketsDetails() {
    return _db.collection("Tickets").snapshots().map((snapshot) =>
        snapshot.docs.map((e) => FormsModel.fromJson(e.data())).toList());
  }

  filePicker({filefetch, file}) async {
    var result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: ['pdf', 'jpg', 'xlsx']);
    List files = result!.paths.map((e) => e!).toList();
    var fileName = files.first.toString().split("/").last;
    file.text = files.first.toString().split("/").last;
    var bytes = base64Encode(File(files[0].toString()).readAsBytesSync());
    filefetch.text = bytes;
    return filefetch.text;
  }
}
