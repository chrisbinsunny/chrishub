import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mac_dt/apps/feedback/model.dart';



class DataBase{
  Stream<QuerySnapshot> getFeedback() {
    return FirebaseFirestore.instance
        .collection("Feedback")
        .orderBy("time", descending: true)
        .snapshots();
  }


  Future<bool> addFeedback(
      {required FeedbackForm feedbackForm})async {
    return await FirebaseFirestore.instance
        .collection("Feedback")
        .add(feedbackForm.toJson()).then((value) {
          return true;
    }).catchError((e){
      return false;
    });
}
}