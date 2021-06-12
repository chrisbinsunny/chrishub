import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:provider/provider.dart';
import '../../sizes.dart';
import '../../widgets.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'controller.dart';
import 'model.dart';

class FeedBack extends StatefulWidget {
  final Offset initPos;
  const FeedBack({this.initPos, Key key}) : super(key: key);

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  Offset position = Offset(0.0, 0.0);
  bool feedbackFS;
  bool feedbackPan;
  bool feedbackOpen;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();


  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      FeedbackForm feedbackForm = FeedbackForm(
          nameController.text,
          emailController.text,
          mobileNoController.text,
          feedbackController.text);

      FormController formController = FormController();

      _showSnackbar("Submitting Feedback");

      // Submit 'feedbackForm' and save it in Google Sheets.
      formController.submitForm(feedbackForm, (String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          // Feedback is saved succesfully in Google Sheets.
          _showSnackbar("Feedback Submitted");
        } else {
          // Error Occurred while saving data in Google Sheets.
          _showSnackbar("Error Occurred!");
        }
      });
    }
  }

  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    // _scaffoldKey.currentState.showSnackBar(snackBar);
  debugPrint(message);
  }


  @override
  void initState() {
    position = widget.initPos;
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    feedbackOpen = Provider.of<OnOff>(context).getFeedBack;
    feedbackFS = Provider.of<OnOff>(context).getFeedBackFS;
    feedbackPan = Provider.of<OnOff>(context).getFeedBackPan;
    return true
        ? AnimatedPositioned(
      duration: Duration(milliseconds: feedbackPan ? 0 : 200),
      top: feedbackFS ? screenHeight(context, mulBy: 0.0335) : position.dy,
      left: feedbackFS ? 0 : position.dx,
      child: feedbackWindow(context),
    )
        : Container();
  }

  AnimatedContainer feedbackWindow(BuildContext context) {

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: feedbackFS
          ? screenWidth(context, mulBy: 1)
          : screenWidth(context, mulBy: 0.7),
      height: feedbackFS
          ? screenHeight(context, mulBy: 0.863)
          : screenHeight(context, mulBy: 0.75),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 10,
            blurRadius: 15,
            offset: Offset(0, 8), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                height: feedbackFS
                    ? screenHeight(context, mulBy: 0.059)
                    : screenHeight(context, mulBy: 0.06),
                decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
              ),
              GestureDetector(
                onPanUpdate: (tapInfo) {
                  if (!feedbackFS) {
                    setState(() {
                      position = Offset(position.dx + tapInfo.delta.dx,
                          position.dy + tapInfo.delta.dy);
                    });
                  }
                },
                onPanStart: (details) {
                  Provider.of<OnOff>(context, listen: false).onSpotifyPan();
                },
                onPanEnd: (details) {
                  Provider.of<OnOff>(context, listen: false).offSpotifyPan();
                },
                onDoubleTap: () {
                  Provider.of<OnOff>(context, listen: false).toggleSpotifyFS();
                },
                child: Container(
                  alignment: Alignment.topRight,
                  width: feedbackFS
                      ? screenWidth(context, mulBy: 0.95)
                      : screenWidth(context, mulBy: 0.7),
                  height: feedbackFS
                      ? screenHeight(context, mulBy: 0.059)
                      : screenHeight(context, mulBy: 0.06),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black.withOpacity(0.5),
                              width: 0.8))),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context, mulBy: 0.013),
                    vertical: screenHeight(context, mulBy: 0.01)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: Container(
                            height: 11.5,
                            width: 11.5,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                          ),
                          onTap: () {
                            Provider.of<OnOff>(context, listen: false)
                                .toggleSpotify();
                            Provider.of<OnOff>(context, listen: false)
                                .offSpotifyFS();
                          },
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.005),
                        ),
                        InkWell(
                          child: Container(
                            height: 11.5,
                            width: 11.5,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.005),
                        ),
                        InkWell(
                          child: Container(
                            height: 11.5,
                            width: 11.5,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                          ),
                          onTap: () {
                            Provider.of<OnOff>(context, listen: false)
                                .toggleSpotifyFS();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                child: Container(
                  height: screenHeight(context, mulBy: 0.14),
                  width: screenWidth(
                    context,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor.withOpacity(0.8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Form(
                          key: _formKey,
                          child:
                          Padding(padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  controller: nameController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter Valid Name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Name'
                                  ),
                                ),
                                TextFormField(
                                  controller: emailController,
                                  validator: (value) {
                                    if (!value.contains("@")) {
                                      return 'Enter Valid Email';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      labelText: 'Email'
                                  ),
                                ),
                                TextFormField(
                                  controller: mobileNoController,
                                  validator: (value) {
                                    if (value.trim().length != 10) {
                                      return 'Enter 10 Digit Mobile Number';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Mobile Number',
                                  ),
                                ),
                                TextFormField(
                                  controller: feedbackController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter Valid Feedback';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                      labelText: 'Feedback'
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed:_submitForm,
                        child: Text('Submit Feedback'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
