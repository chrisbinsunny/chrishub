import 'package:flutter/cupertino.dart';
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
  bool error=true;
  bool valAni=false;
  bool valid = false;
  int submit= 3; /// 0=submitting, 1=success, 2=error, 3= free state
  bool submitShow= false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController mobileNoController;
  TextEditingController feedbackController;
  String type = "Feedback";

  void _submitForm() {

    if(nameController.text.isNotEmpty &&
        emailController.text.contains("@")&&
        (mobileNoController.text.isEmpty||(mobileNoController.text.length>=10&&int.tryParse(mobileNoController.text) != null)) &&
        type.isNotEmpty &&
        feedbackController.text.isNotEmpty) {
      valid = true;
    }
    _formKey.currentState.validate();
    if (valid) {
      // If the form is valid, proceed.
      FeedbackForm feedbackForm = FeedbackForm(
        nameController.text,
        emailController.text,
        mobileNoController.text,
        type,
        feedbackController.text,
        DateTime.now().toString(),
      );

      FormController formController = FormController();

      setState(() {
        submitShow=true;
        submit=0;
      });

      formController.submitForm(feedbackForm, (String response) {
        print("Response: $response");
        Future.delayed(Duration(seconds: 0),(){
          if (response == FormController.STATUS_SUCCESS) {
            setState(() {
              submit = 1;
              nameController.clear();
              emailController.clear();
              mobileNoController.clear();
              feedbackController.clear();
            });
          } else {
            setState(() {
              submit = 2;
            });
          }
        });
      });
      valid=false;
    }
  }


  @override
  void initState() {
    position = widget.initPos;
    nameController = TextEditingController();
    emailController = TextEditingController();
    mobileNoController = TextEditingController();
    feedbackController = TextEditingController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    feedbackOpen = Provider.of<OnOff>(context).getFeedBack;
    feedbackFS = Provider.of<OnOff>(context).getFeedBackFS;
    feedbackPan = Provider.of<OnOff>(context).getFeedBackPan;
    return feedbackOpen
        ? AnimatedPositioned(
      duration: Duration(milliseconds: feedbackPan ? 0 : 200),
      top:
      feedbackFS ? screenHeight(context, mulBy: 0.0335) : position.dy,
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
        color: Theme.of(context).dialogBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 10,
            blurRadius: 15,
            offset: Offset(0, 8), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    //width: screenWidth(context, mulBy: feedbackFS ? .5 : .35),
                    decoration: BoxDecoration(
                        color: Theme.of(context).dialogBackgroundColor,
                        border: Border(
                            right: BorderSide(
                                color: Theme.of(context).cardColor.withOpacity(0.3),
                                width: 0.6))
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth(context,mulBy: 0.02),
                          vertical: screenHeight(context, mulBy: 0.05)
                      ),
                      duration: Duration(milliseconds: 200),
                      width: screenWidth(context, mulBy: feedbackFS ? .75 : .5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).dialogBackgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            height: screenHeight(context, mulBy: feedbackFS ? 0.40 : .3),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/apps/feedback.png",
                                  height: 100,
                                  // width: 30,
                                ),
                                MBPText(text: "Chrisbin's MacBook Pro Feedback", size: 25, color: Theme.of(context).cardColor.withOpacity(1),),
                              ],
                            ),
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            width: screenWidth(context, mulBy: feedbackFS?0.5:0.46),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        width: screenWidth(context, mulBy: 0.22),
                                        height: screenHeight(context, mulBy: 0.038), //0.038
                                        child: TextFormField(
                                          cursorHeight: 16,
                                          controller: nameController,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              setState(() {
                                                error=false;
                                                valAni=true;
                                              });
                                            }
                                            return null;
                                          },
                                          textAlign: TextAlign.start,
                                          cursorColor:
                                          Theme.of(context).cardColor.withOpacity(0.55),
                                          style: TextStyle(
                                            height: 1.5,
                                            color: Theme.of(context).cardColor.withOpacity(1),
                                            fontFamily: "HN",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              filled: true,
                                              fillColor: Color(0xff2f2e32),
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 15
                                              ),
                                              hintText: "Name*",
                                              hintStyle: TextStyle(
                                                height: 1.5,
                                                color: Theme.of(context)
                                                    .cardColor
                                                    .withOpacity(0.4),
                                                fontFamily: "HN",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color(0xffb558e1)
                                                ),),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                ),)
                                          ),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        width: screenWidth(context, mulBy: feedbackFS? 0.06: 0.02),
                                      ),
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        width: screenWidth(context, mulBy: 0.22),
                                        height: screenHeight(context, mulBy: 0.038), //0.038
                                        child: TextFormField(
                                          cursorHeight: 16,
                                          controller: emailController,
                                          validator: (value) {
                                            if (!value.contains("@")) {
                                              setState(() {
                                                error=false;
                                                valAni=true;
                                              });
                                            }
                                            return null;
                                          },
                                          textAlign: TextAlign.start,
                                          cursorColor:
                                          Theme.of(context).cardColor.withOpacity(0.55),
                                          style: TextStyle(
                                            height: 1.5,
                                            color: Theme.of(context).cardColor.withOpacity(1),
                                            fontFamily: "HN",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              filled: true,
                                              fillColor: Color(0xff2f2e32),
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 15
                                              ),
                                              hintText: "Email ID*",
                                              hintStyle: TextStyle(
                                                height: 1.5,
                                                color: Theme.of(context)
                                                    .cardColor
                                                    .withOpacity(0.4),
                                                fontFamily: "HN",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color(0xffb558e1)
                                                ),),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                ),)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight(context,mulBy: 0.025),
                                  ),
                                  Row(
                                    children: [
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        width: screenWidth(context, mulBy: 0.22),
                                        height: screenHeight(context, mulBy: 0.038), //0.038
                                        child: TextFormField(
                                          cursorHeight: 16,
                                          controller: mobileNoController,
                                          validator: (value){
                                            if(value.isNotEmpty && value.length<10 &&int.tryParse(value)==null)
                                              setState(() {
                                                error=false;
                                                valAni=true;
                                              });
                                            return null;
                                          },
                                          textAlign: TextAlign.start,
                                          cursorColor:
                                          Theme.of(context).cardColor.withOpacity(0.55),
                                          style: TextStyle(
                                            height: 1.5,
                                            color: Theme.of(context).cardColor.withOpacity(1),
                                            fontFamily: "HN",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              filled: true,
                                              fillColor: Color(0xff2f2e32),
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 15
                                              ),
                                              hintText: "Mobile Number",
                                              hintStyle: TextStyle(
                                                height: 1.5,
                                                color: Theme.of(context)
                                                    .cardColor
                                                    .withOpacity(0.4),
                                                fontFamily: "HN",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color(0xffb558e1)
                                                ),),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                ),)
                                          ),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        width: screenWidth(context, mulBy: feedbackFS? 0.06: 0.02),
                                      ),
                                      Row(
                                        children: [
                                          MBPText(text: "Type:       ", size: 12, color: Theme.of(context).cardColor.withOpacity(0.85),),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                type="Feedback";
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 14,
                                                  width: 14,
                                                  margin: EdgeInsets.zero,
                                                  padding: EdgeInsets.zero,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    border: (type!="Feedback")? Border.all(
                                                        color: Colors.black
                                                    ):Border.all(
                                                        width: 4,
                                                        color: Colors.blue
                                                    ),
                                                  ),
                                                ),
                                                MBPText(text: "   Feedback", size: 12, color: Theme.of(context).cardColor.withOpacity(0.75),),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenWidth(context, mulBy: 0.015),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                type="Issue";
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 14,
                                                  width: 14,
                                                  margin: EdgeInsets.zero,
                                                  padding: EdgeInsets.zero,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    border: (type!="Issue")? Border.all(
                                                        color: Colors.black
                                                    ):Border.all(
                                                        width: 4,
                                                        color: Colors.blue
                                                    ),
                                                  ),
                                                ),
                                                MBPText(text: "   Issues", size: 12, color: Theme.of(context).cardColor.withOpacity(0.75),),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight(context,mulBy: 0.025),
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    width: screenWidth(context, mulBy: 0.35),
                                    height: screenHeight(context, mulBy: 0.13), //0.038
                                    child: TextFormField(
                                      cursorHeight: 16,
                                      controller: feedbackController,
                                      textAlign: TextAlign.start,
                                      validator: (value){
                                        if(value.isEmpty){
                                          setState(() {
                                            error=false;
                                            valAni=true;
                                          });
                                        }
                                        return null;
                                      },
                                      cursorColor:
                                      Theme.of(context).cardColor.withOpacity(0.55),
                                      style: TextStyle(
                                        height: 1.5,
                                        color: Theme.of(context).cardColor.withOpacity(1),
                                        fontFamily: "HN",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                      maxLines: 6,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          filled: true,
                                          fillColor: Color(0xff2f2e32),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 15
                                          ),
                                          hintText: "$type*",
                                          hintStyle: TextStyle(
                                            height: 1.5,
                                            color: Theme.of(context)
                                                .cardColor
                                                .withOpacity(0.4),
                                            fontFamily: "HN",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Color(0xffb558e1)
                                            ),),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                            ),)
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight(context,mulBy: 0.025),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: _submitForm,
                                      child: Container(
                                        decoration: new BoxDecoration(
                                            gradient: new LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xffb558e1),
                                                Color(0xff7a3a9e),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.circular(7)
                                        ),
                                        width: 80,
                                        height: 30,
                                        child: MBPText(
                                          text: "Submit",
                                          size: 11,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    !error?InkWell(
                      onTap: (){
                        setState(() {
                          error=true;
                        });
                      },
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: screenWidth(context, mulBy: feedbackFS ? .75 : .5),
                          //height: screenHeight(context),
                          color: Colors.transparent
                      ),
                    ):Container(),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: valAni?400:200),
                      left: screenWidth(context,mulBy: feedbackFS?0.284:0.17),
                      top: error?-(screenHeight(context, mulBy: 0.32)):0,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        width: feedbackFS
                            ? screenWidth(context, mulBy: 0.17)
                            : screenWidth(context, mulBy: 0.16),
                        height: feedbackFS
                            ? screenHeight(context, mulBy: 0.32)
                            : screenHeight(context, mulBy: 0.3),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: !error?Colors.black.withOpacity(0.2):Colors.transparent,
                              spreadRadius: 10,
                              blurRadius: 15,
                              offset: Offset(0, 8), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).dialogBackgroundColor.withOpacity(0.5),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth(context, mulBy: 0.02)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/apps/feedback.png",
                                      height: 50,
                                    ),
                                    MBPText(
                                      text: "Value Error",
                                      color: Theme.of(context).cardColor.withOpacity(1),
                                      size: 18,
                                      weight: FontWeight.w600,
                                    ),
                                    SizedBox(
                                      height: screenHeight(context, mulBy: 0.01),
                                    ),
                                    MBPText(
                                      text: "Please check the values\nyou entered.",
                                      color: Theme.of(context).cardColor.withOpacity(1),
                                      size: 11.5,
                                      weight: FontWeight.w300,
                                      fontFamily: "HN",
                                      maxLines: 2,
                                    ),
                                    SizedBox(
                                      height: screenHeight(context, mulBy: 0.035),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          error=true;
                                          Future.delayed(Duration(milliseconds: 400), () {valAni=false;});
                                        });
                                      },
                                      child: Container(
                                        decoration: new BoxDecoration(
                                            gradient: new LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xff1473e8),
                                                Color(0xff0c4382),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        width: 65,
                                        height: 23,
                                        child: MBPText(
                                          text: "Continue",
                                          size: 11,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                    submitShow?InkWell(
                      onTap: (){
                        if(submit==2) {
                          setState(() {
                            submit = 3;
                            submitShow = false;
                          });
                          return;
                        }
                        if(submit==1) {

                          setState(() {
                            submit = 3;
                            submitShow = false;
                          });
                        }},
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: screenWidth(context, mulBy: feedbackFS ? .75 : .5),
                          //height: screenHeight(context),
                          color: Colors.transparent
                      ),
                    ):Container(),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: valAni?400:200),
                      left: screenWidth(context,mulBy: feedbackFS?0.284:0.17),
                      top: !submitShow?-(screenHeight(context, mulBy: 0.32)):0,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        width: feedbackFS
                            ? screenWidth(context, mulBy: 0.17)
                            : screenWidth(context, mulBy: 0.16),
                        height: feedbackFS
                            ? screenHeight(context, mulBy: 0.32)
                            : screenHeight(context, mulBy: 0.3),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: submitShow?Colors.black.withOpacity(0.2):Colors.transparent,
                              spreadRadius: 10,
                              blurRadius: 15,
                              offset: Offset(0, 8), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).dialogBackgroundColor.withOpacity(0.5),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth(context, mulBy: 0.02)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/apps/feedback.png",
                                      height: 50,
                                    ),
                                    MBPText(
                                      text: submit==0?"Please Wait":(submit==1?"Submission Successful":"Submission Error"),
                                      color: Theme.of(context).cardColor.withOpacity(1),
                                      size: 18,
                                      weight: FontWeight.w600,
                                    ),
                                    SizedBox(
                                      height: screenHeight(context, mulBy: 0.01),
                                    ),
                                    MBPText(
                                      text: submit==0?"Your $type is being\nsubmitted":(submit==1?"Your $type has been\nsuccessfully submitted":"Could not submit your $type.\nPlease try again."),
                                      color: Theme.of(context).cardColor.withOpacity(1),
                                      size: 11.5,
                                      weight: FontWeight.w300,
                                      fontFamily: "HN",
                                      maxLines: 2,
                                    ),
                                    SizedBox(
                                      height: screenHeight(context, mulBy: 0.035),
                                    ),
                                    submit>0?InkWell(
                                      onTap: (){
                                        setState(() {
                                          submit= 3;
                                          submitShow=false;
                                          Future.delayed(Duration(milliseconds: 400), () {valAni=false;});
                                        });
                                      },
                                      child: Container(
                                        decoration: new BoxDecoration(
                                            gradient: new LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xff1473e8),
                                                Color(0xff0c4382),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        width: 65,
                                        height: 23,
                                        child: MBPText(
                                          text: "Continue",
                                          size: 11,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ):Theme(data: ThemeData(cupertinoOverrideTheme: CupertinoThemeData(brightness: Brightness.dark)),
                                        child: CupertinoActivityIndicator()),
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
              Provider.of<OnOff>(context, listen: false).onFeedBackPan();
            },
            onPanEnd: (details) {
              Provider.of<OnOff>(context, listen: false).offFeedBackPan();
            },
            onDoubleTap: () {
              valAni=false;
              Provider.of<OnOff>(context, listen: false).toggleFeedBackFS();
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
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth(context, mulBy: 0.013),
                vertical: screenHeight(context, mulBy: 0.02)),
            child: Row(
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
                        .toggleFeedBack();
                    Provider.of<OnOff>(context, listen: false)
                        .offFeedBackFS();
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
                    valAni=false;
                    Provider.of<OnOff>(context, listen: false)
                        .toggleFeedBackFS();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


