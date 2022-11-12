import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedbackForm {
  String name;
  String email;
  String mobileNo;
  String type;
  String feedback;
  DateTime dateTime;
  Key? key;

  FeedbackForm(this.name, this.email, this.mobileNo, this.type, this.feedback,
      this.dateTime, {this.key});

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm(
        "${json['name']}",
        "${json['email']}",
        "${json['mobileNo']}",
        "${json['type']}",
        "${json['feedback']}",
        json['dateTime']);
  }

  // Method to make GET parameters.
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'number': mobileNo,
        'type': type,
        'feedback': feedback,
        'time': dateTime
      };


  factory FeedbackForm.fromSnapshot(QueryDocumentSnapshot? snapshot) {
    return FeedbackForm(
        "${snapshot!['name']}",
        "${snapshot['email']}",
        "${snapshot['number']}",
        "${snapshot['type']}",
        "${snapshot['feedback']}",
        snapshot['time'].toDate(),
    key: ObjectKey(snapshot.id)
    );
  }
}
