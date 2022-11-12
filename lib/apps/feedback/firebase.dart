import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mac_dt/apps/feedback/model.dart';



class DataBase{
  Stream<QuerySnapshot> getFeedback() {
    return FirebaseFirestore.instance
        .collection("Feedback")
        .orderBy("time", descending: true)
        .snapshots();
  }


  Future addFeedback(
      {required FeedbackForm feedbackForm})async {
    await FirebaseFirestore.instance
        .collection("Feedback")
        .add(feedbackForm.toJson()).catchError((e){
    });
}
}