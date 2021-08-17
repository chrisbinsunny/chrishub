import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:mac_dt/apps/messages/clipper.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:provider/provider.dart';
import '../../openApps.dart';
import '../../sizes.dart';
import '../../widgets.dart';
import 'chat_bubble.dart';
import 'types.dart';

class Messages extends StatefulWidget {
  final Offset initPos;
  const Messages({this.initPos, Key key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  Offset position = Offset(0.0, 0.0);
  bool messagesFS;
  bool messagesPan;
  Future messageRecords;
  ScrollController scrollController = new ScrollController();
  int selectedChat;


  Future<List<MessageContent>> readMessages() async{
    var data= json.decode(await rootBundle.loadString('assets/messages/messageLog.json'));
    return data.map<MessageContent>((json) => MessageContent.fromJson(json)).toList();

  }

  @override
  void initState() {
    position = widget.initPos;
    messageRecords=  readMessages();
    selectedChat=0;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var messagesOpen = Provider.of<OnOff>(context).getMessages;
    messagesFS = Provider.of<OnOff>(context).getMessagesFS;
    messagesPan = Provider.of<OnOff>(context).getMessagesPan;
    return messagesOpen
        ? AnimatedPositioned(
            duration: Duration(milliseconds: messagesPan ? 0 : 200),
            top: messagesFS ? screenHeight(context, mulBy: 0.034) : position.dy,
            left: messagesFS ? 0 : position.dx,
            child: messagesWindow(context),
          )
        : Container();
  }

  AnimatedContainer messagesWindow(BuildContext context) {
    String topApp = Provider.of<Apps>(context).getTop;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: messagesFS
          ? screenWidth(context, mulBy: 1)
          : screenWidth(context, mulBy: 0.55),
      height: messagesFS
          ? screenHeight(context, mulBy: 0.966)
          : screenHeight(context, mulBy: 0.65),
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
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 70.0, sigmaY: 70.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context, mulBy: 0.005),
                        vertical: screenHeight(context, mulBy: 0.025)),
                    height: screenHeight(context),
                    width: screenWidth(context, mulBy: 0.2),
                    decoration: BoxDecoration(
                        color: Theme.of(context).hintColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth(context, mulBy: 0.008),
                              ),
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
                                      .offFinderFS();
                                  Provider.of<Apps>(context, listen: false)
                                      .closeApp("finder");
                                  Provider.of<OnOff>(context, listen: false)
                                      .toggleFinder();
                                },
                              ),
                              SizedBox(
                                width: screenWidth(context, mulBy: 0.005),
                              ),
                              InkWell(
                                onTap: () {
                                  Provider.of<OnOff>(context, listen: false)
                                      .toggleFinder();
                                  Provider.of<OnOff>(context, listen: false)
                                      .offFinderFS();
                                },
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
                                      .toggleMessagesFS();
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight(context, mulBy: 0.028),
                        ),
                        //Search Box (Fake)
                        Container(
                          height: screenHeight(context, mulBy: 0.035),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth(context, mulBy: 0.005)
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: Theme.of(context).cardColor.withOpacity(0.15),
                              width: 0.5
                            )
                          ),
                          child: Row(
                            children: [
                              Image.asset("assets/icons/spotlight.png", height: 12, color: Theme.of(context).cardColor.withOpacity(0.3),),
                              SizedBox(width: screenWidth(context, mulBy: 0.002),),
                              MBPText(text: "Search", color: Theme.of(context).cardColor.withOpacity(0.3),fontFamily: 'HN')
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight(context,mulBy: 0.01),),
                        Expanded(
                          child: Container(
                            child: FutureBuilder(
                              future: messageRecords,
                                builder: (context, snapshot){
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snapshot.data.length,
                                      controller: scrollController,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedChat = index;
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: screenHeight(context,
                                                    mulBy: 0.08),
                                                padding: EdgeInsets.only(
                                                    left: screenWidth(context,
                                                        mulBy: 0.01),
                                                    right: screenWidth(context,
                                                        mulBy: 0.008)),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: selectedChat==index?Color(0xff0b84ff):Colors.transparent
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                  gradient: new LinearGradient(
                                                      colors: [
                                                        Color(0xff6d6d6d),
                                                        Color(0xff484848)
                                                      ],
                                                      begin: const FractionalOffset(0, 0),
                                                      end: const FractionalOffset(0, 1),
                                                      stops: [0.0, 1.0],
                                                      tileMode: TileMode.clamp),
                                                ),
                                                      height: screenHeight(context, mulBy: 0.055),
                                                      width: screenHeight(context, mulBy: 0.055),
                                                      padding: EdgeInsets.all(screenHeight(context, mulBy: 0.01)),
                                                      child: MBPText(
                                                        text:"${snapshot.data[index].senderName.toString().getInitials().capitalize()}",
                                                        color: Colors.white,
                                                        fontFamily: "SFR",
                                                        size: 25,
                                                        weight: FontWeight.w500,
                                                        overflow: TextOverflow.fade,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                      ),
                                                      ),
                                                    SizedBox(width: screenWidth(context,mulBy: 0.006),),
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "${snapshot.data[index].senderName}",
                                                          style: TextStyle(
                                                              color: Theme.of(context)
                                                                  .cardColor
                                                                  .withOpacity(1),
                                                              fontSize: 13,
                                                              fontFamily: 'HN',
                                                              fontWeight:
                                                              FontWeight.w500),
                                                          overflow: TextOverflow.fade,
                                                          maxLines: 1,
                                                          softWrap: false,
                                                        ),
                                                        Text(
                                                          snapshot.data[index].messages.sender.last,
                                                          style: TextStyle(
                                                              color: Theme.of(context)
                                                                  .cardColor
                                                                  .withOpacity(selectedChat==index?1:.6),
                                                              fontSize: 11,
                                                              fontFamily: 'HN',
                                                              fontWeight:
                                                              FontWeight.w400),
                                                          overflow: TextOverflow.fade,
                                                          maxLines: 1,
                                                          softWrap: false,
                                                        ),
                                                        SizedBox(height: screenHeight(context,mulBy: 0.01),)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Align(
                                                child: Container(
                                              color: ((selectedChat==index)||(selectedChat-1==index))?Colors.transparent:Theme.of(context).cardColor.withOpacity(0.5),
                                                  height: 0.3,
                                                  width: screenWidth(context,mulBy: 0.15),
                                                ),
                                                alignment: Alignment.topRight,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  return Theme(
                                      data: ThemeData(
                                          cupertinoOverrideTheme:
                                          CupertinoThemeData(
                                              brightness: Brightness.dark)),
                                      child: Center(child: CupertinoActivityIndicator()));
                                }
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                future: messageRecords,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        child: Container(

                          decoration: BoxDecoration(
                            color: Theme.of(context).errorColor,
                            border: Border(
                                left: BorderSide(color: Colors.black, width: 0.8)),
                          ),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: screenHeight(context, mulBy: 0.07),
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth(context, mulBy: 0.013),
                                      //vertical: screenHeight(context, mulBy: 0.03)
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xff3b393b),
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black,
                                                width: 0.7
                                            )
                                        )
                                    ),
                                    child: Row(
                                      children: [
                                        MBPText(
                                          text: "To:",
                                          color: Color(0xff747374),
                                          fontFamily: "HN",
                                          weight: FontWeight.w500,
                                          size: 11,
                                        ),
                                        MBPText(
                                          text: " ${snapshot.data[selectedChat].senderName}",
                                          color: Theme.of(context).cardColor.withOpacity(1),
                                          fontFamily: 'HN',
                                          weight: FontWeight.w400,
                                          size: 12,
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.info_outline_rounded,
                                          color: Color(0xff9b999b),
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth(context, mulBy: 0.009),
                                      vertical: screenHeight(context,mulBy: 0.005)
                                      ),
                                      decoration: BoxDecoration(
                                      ),
                                      child: ListView.builder(
                                        ///For viewing the last chat when the screen opens. Using index in reverse.
                                        reverse: true,
                                        physics: BouncingScrollPhysics(),
                                        itemCount: snapshot.data[selectedChat].messages.sender.length,
                                        controller: scrollController,
                                        itemBuilder: (context, index) {
                                          final reversedIndex = snapshot.data[selectedChat].messages.sender.length - 1 - index;
                                          return Column(
                                            children: [
                                              if(snapshot.data[selectedChat].dateStops.contains(reversedIndex))
                                              MBPText(
                                                text: "${snapshot.data[selectedChat].dates[snapshot.data[selectedChat].dateStops.indexOf(reversedIndex)]}",
                                              color: Theme.of(context).cardColor.withOpacity(0.6),
                                                fontFamily: "HN",
                                                size: 10,

                                              ),
                                              ChatBubble(
                                                clipper: iMessageClipper(type: BubbleType.receiverBubble),
                                                margin: EdgeInsets.only(top: 5),
                                                backGroundColor: Color(0xff3b3b3d),
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth: screenWidth(context,mulBy: 0.15),
                                                  ),
                                                  child: Text(
                                                    "${snapshot.data[selectedChat].messages.sender[reversedIndex]}",
                                                    style: TextStyle(color: Colors.white,
                                                    fontFamily: 'HN',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ChatBubble(
                                                clipper: iMessageClipper(type: BubbleType.sendBubble),
                                                alignment: Alignment.topRight,
                                                margin: EdgeInsets.only(top: 5),
                                                backGroundColor: Color(0xff1f8bff),
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth: screenWidth(context,mulBy: 0.15),
                                                  ),
                                                  child: Text(
                                                    "${snapshot.data[selectedChat].messages.me[reversedIndex]}",
                                                    style: TextStyle(color: Colors.white,
                                                        fontFamily: 'HN',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              ClipRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                  child: Container(
                                    height: screenHeight(context, mulBy: 0.055),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.3),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          "assets/messages/store.png",
                                          height: 23,
                                        ),
                                        InkWell(
                                          //onTap: (){showAlertDialog(context);},
                                          child: Container(
                                            width: screenWidth(context, mulBy: 0.27),
                                            height: screenHeight(context, mulBy: 0.032),
                                            padding: EdgeInsets.only(
                                                left: screenWidth(context, mulBy: 0.008),
                                                right: screenWidth(context, mulBy: 0.005)
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Theme.of(context).cardColor.withOpacity(0.2)
                                                )
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: screenHeight(context, mulBy: 0.0052),
                                                  ),
                                                  child: Text(
                                                    "iMessage",
                                                    style: TextStyle(
                                                        color: Theme.of(context).cardColor.withOpacity(0.2),
                                                        fontFamily: 'HN',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12
                                                    ),

                                                  ),
                                                ),
                                                Image.asset(
                                                  "assets/messages/voice.png",
                                                  height: 23,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          "assets/messages/emoji.png",
                                          height: 23,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Theme(
                      data: ThemeData(
                          cupertinoOverrideTheme:
                          CupertinoThemeData(
                              brightness: Brightness.dark)),
                      child: Expanded(child: Container(decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        color:Theme.of(context).scaffoldBackgroundColor,
                      ),child: Center(child: CupertinoActivityIndicator()))));
                },
              )
            ],
          ),
          GestureDetector(
            onPanUpdate: (tapInfo) {
              if (!messagesFS) {
                setState(() {
                  position = Offset(position.dx + tapInfo.delta.dx,
                      position.dy + tapInfo.delta.dy);
                });
              }
            },
            onPanStart: (details) {
              Provider.of<OnOff>(context, listen: false).onMessagesPan();
            },
            onPanEnd: (details) {
              Provider.of<OnOff>(context, listen: false).offMessagesPan();
            },
            onDoubleTap: () {
              Provider.of<OnOff>(context, listen: false).toggleMessagesFS();
            },
            child: Container(
                alignment: Alignment.centerRight,
                width: messagesFS
                    ? screenWidth(context, mulBy: 0.95)
                    : screenWidth(context, mulBy: 0.5),
                height: screenHeight(context, mulBy: 0.04),
                color: Colors.transparent),
          ),
          Visibility(
            visible: topApp != "Messages",
            child: InkWell(
              onTap: () {
                Provider.of<Apps>(context, listen: false)
                    .bringToTop(ObjectKey("messages"));
              },
              child: Container(
                width: screenWidth(
                  context,
                ),
                height: screenHeight(
                  context,
                ),
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class MessageContent {
  MainMessage messages;
  String senderName;
  String senderPhoto;
  String profileLink;
  List<int> dateStops;
  List<String> dates;

  MessageContent(
      {this.messages, this.senderName, this.profileLink, this.senderPhoto, this.dates, this.dateStops}):assert(dateStops.length==dates.length);

  factory MessageContent.fromJson(Map<String, dynamic> json){

    return MessageContent(
      messages: MainMessage.fromJson(json["messages"]),
      senderName: json["senderName"].toString(),
      dateStops: List<int>.from(json["dateStops"]),
      dates: List<String>.from(json["dates"]),
      senderPhoto: json["senderPhoto"].toString(),
      profileLink: json["profileLink"].toString()
    );
  }
}


class MainMessage {
  List<String> sender;
  List<String> me;

  MainMessage({this.me, this.sender});

  factory MainMessage.fromJson(Map<String, dynamic> json){
    return MainMessage(
      me: List<String>.from(json["me"]),
      sender: List<String>.from(json["sender"])
    );
  }
}