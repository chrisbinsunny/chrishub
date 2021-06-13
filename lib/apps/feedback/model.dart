

class FeedbackForm {
  String name;
  String email;
  String mobileNo;
  String type;
  String feedback;
  String dateTime;

  FeedbackForm(this.name, this.email, this.mobileNo, this.type, this.feedback, this.dateTime);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm("${json['name']}", "${json['email']}",
        "${json['mobileNo']}","${json['type']}", "${json['feedback']}", "${json['dateTime']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
    'name': name,
    'email': email,
    'mobileNo': mobileNo,
    'type' : type,
    'feedback': feedback,
    'dateTime': dateTime

  };
}