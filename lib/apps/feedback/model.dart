

class FeedbackForm {
  String name;
  String email;
  String mobileNo;
  String type;
  String feedback;

  FeedbackForm(this.name, this.email, this.mobileNo, this.type, this.feedback);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm("${json['name']}", "${json['email']}",
        "${json['mobileNo']}","${json['type']}", "${json['feedback']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
    'name': name,
    'email': email,
    'mobileNo': mobileNo,
    'type' : type,
    'feedback': feedback
  };
}