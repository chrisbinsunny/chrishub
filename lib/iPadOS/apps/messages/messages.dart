import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/apps/messages/clipper.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:provider/provider.dart';
import '../../../apps/messages/types.dart';
import '../../../sizes.dart';
import '../../../widgets.dart';
import 'chat_bubble.dart';
import 'dart:html' as html;

class Messages extends StatefulWidget {
  final Offset initPos;
  const Messages({this.initPos, Key key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  Future messageRecords;
  ScrollController chatScrollController = new ScrollController();
  ScrollController nameScrollController = new ScrollController();
  int selectedChatIndex;
  bool info;
  MessageContent selectedChat= new MessageContent(

  );

  Future<List<MessageContent>> readMessages() async {
    var data = json
        .decode(await rootBundle.loadString('assets/messages/messageLog.json'));
    return data
        .map<MessageContent>((json) => MessageContent.fromJson(json))
        .toList();
  }

  @override
  void initState() {
    messageRecords = readMessages();
    selectedChatIndex = 0;
    info= false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaler(child: messagesWindow(context),);
  }

  Container messagesWindow(BuildContext context) {
    var reversedIndex;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
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
        clipBehavior: Clip.none,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight(context, mulBy: 0.025)),
                height: screenHeight(context),
                width: screenWidth(context, mulBy: 0.2),
                decoration: BoxDecoration(
                  color: Theme.of(context).indicatorColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth(context, mulBy: 0.01),),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight(context, mulBy: 0.03),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MBPText(
                                text: "Edit",
                                color: Color(0xff0b84ff),
                                size: 17,
                              ),
                              Icon(
                                CupertinoIcons.text_bubble,
                                color: Color(0xff0b84ff),
                                size: 20,
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight(context, mulBy: 0.01),
                          ),
                          MBPText(
                            text: "Messages",
                            weight: Theme.of(context).textTheme.headline1.fontWeight,
                            color: Theme.of(context).cardColor.withOpacity(1),
                            size: 26,
                          ),
                          SizedBox(
                            height: screenHeight(context, mulBy: 0.01),
                          ),
                          ///Search Box (Fake)
                          Container(
                            height: screenHeight(context, mulBy: 0.035),
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth(context, mulBy: 0.005)),
                            decoration: BoxDecoration(
                                color:
                                Theme.of(context).cardColor.withOpacity(0.07),
                                borderRadius: BorderRadius.circular(7),),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/spotlight.png",
                                  height: 12,
                                  color: Theme.of(context)
                                      .cardColor
                                      .withOpacity(0.3),
                                ),
                                SizedBox(
                                  width: screenWidth(context, mulBy: 0.002),
                                ),
                                MBPText(
                                    text: "Search",
                                    color: Theme.of(context)
                                        .cardColor
                                        .withOpacity(0.3),
                                    fontFamily: 'HN')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenHeight(context, mulBy: 0.01),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: FutureBuilder(
                            future: messageRecords,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if(selectedChat.senderName=="A")
                                  selectedChat=  snapshot.data[0];
                                return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                  controller: nameScrollController,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedChatIndex = index;
                                          selectedChat=  snapshot.data[index];
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
                                                  mulBy: 0.008),
                                            ),
                                            decoration: BoxDecoration(
                                                color: selectedChatIndex == index
                                                    ? Colors.grey.withOpacity(0.1)
                                                    : Colors.transparent),
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
                                                        begin:
                                                        const FractionalOffset(
                                                            0, 0),
                                                        end:
                                                        const FractionalOffset(
                                                            0, 1),
                                                        stops: [0.0, 1.0],
                                                        tileMode:
                                                        TileMode.clamp),
                                                  ),
                                                  height: screenHeight(
                                                      context,
                                                      mulBy: 0.055),
                                                  width: screenHeight(
                                                      context,
                                                      mulBy: 0.055),
                                                  padding: EdgeInsets.all(
                                                      screenHeight(context,
                                                          mulBy: 0.01)),
                                                  child: MBPText(
                                                    text:
                                                    "${snapshot.data[index].senderName.toString().getInitials().capitalize()}",
                                                    color: Colors.white,
                                                    fontFamily: "SFR",
                                                    size: 25,
                                                    weight: FontWeight.w500,
                                                    overflow:
                                                    TextOverflow.fade,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: screenWidth(
                                                      context,
                                                      mulBy: 0.006),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "${snapshot.data[index].senderName}",
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                              context)
                                                              .cardColor
                                                              .withOpacity(
                                                              1),
                                                          fontSize: 13,
                                                          fontFamily: 'HN',
                                                          fontWeight:
                                                          FontWeight
                                                              .w500),
                                                      overflow:
                                                      TextOverflow.fade,
                                                      maxLines: 1,
                                                      softWrap: false,
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data[index]
                                                          .messages
                                                          .sender
                                                          .last,
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                              context)
                                                              .cardColor
                                                              .withOpacity(
                                                              selectedChatIndex ==
                                                                  index
                                                                  ? 1
                                                                  : .6),
                                                          fontSize: 11,
                                                          fontFamily: 'HN',
                                                          fontWeight:
                                                          FontWeight
                                                              .w400),
                                                      overflow:
                                                      TextOverflow.fade,
                                                      maxLines: 1,
                                                      softWrap: false,
                                                    ),
                                                    SizedBox(
                                                      height: screenHeight(
                                                          context,
                                                          mulBy: 0.01),
                                                    )
                                                  ],
                                                ),
                                                Spacer(),
                                                Align(
                                                  alignment: Alignment.topCenter,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(top: screenHeight(context,
                                                        mulBy: 0.01),),
                                                    child: MBPText(
                                                      text:
                                                      "${DateFormat("d/M/yy").format(DateTime.parse(snapshot.data[index].dates.last))}",
                                                      color: Theme.of(context)
                                                          .cardColor
                                                          .withOpacity(0.6),
                                                      fontFamily: "HN",
                                                      size: 11.5,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            child: Container(
                                              color: ((selectedChatIndex ==
                                                  index) ||
                                                  (selectedChatIndex - 1 ==
                                                      index))
                                                  ? Colors.transparent
                                                  : Theme.of(context)
                                                  .cardColor
                                                  .withOpacity(0.5),
                                              height: 0.3,
                                              width: screenWidth(context,
                                                  mulBy: 0.15),
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
                                  child: Center(
                                      child: CupertinoActivityIndicator()));
                            }),
                      ),
                    )
                  ],
                ),
              ),
              FutureBuilder(
                future: messageRecords,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {

                    return Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).indicatorColor,
                          border: Border(
                              left: BorderSide(
                                  color: Theme.of(context).cardColor.withOpacity(0.2), width: 0.8)),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(),
                                decoration: BoxDecoration(),
                                child: ScrollConfiguration(
                                  //TODO Scrollbar
                                  ///turned off scrollbar, coz of weird reverse scrollbar
                                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false ),
                                  child: ListView.builder(
                                    ///For viewing the last chat when the screen opens. Using index in reverse.
                                    reverse: snapshot.data[selectedChatIndex]
                                        .messages.sender.length >
                                        7,
                                    padding: EdgeInsets.only(
                                      bottom: screenHeight(context,
                                          mulBy: 0.135),
                                      top: screenHeight(context, mulBy: 0.1),
                                      left: screenWidth(context, mulBy: 0.009),
                                      right: screenWidth(context, mulBy: 0.009),

                                    ),
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapshot.data[selectedChatIndex]
                                        .messages.sender.length,
                                    controller: chatScrollController,
                                    itemBuilder: (context, index) {
                                      if (snapshot.data[selectedChatIndex]
                                          .messages.sender.length >
                                          7)
                                        reversedIndex = snapshot
                                            .data[selectedChatIndex]
                                            .messages
                                            .sender
                                            .length -
                                            1 -
                                            index;
                                      else
                                        reversedIndex = index;
                                      return Column(
                                        children: [
                                          if (snapshot.data[selectedChatIndex]
                                              .dateStops
                                              .contains(reversedIndex))
                                            MBPText(
                                              text:
                                              "${DateFormat("EEE, d MMM, hh:mm a").format(DateTime.parse(snapshot.data[selectedChatIndex].dates[snapshot.data[selectedChatIndex].dateStops.indexOf(reversedIndex)]))}",
                                              color: Theme.of(context)
                                                  .cardColor
                                                  .withOpacity(0.6),
                                              fontFamily: "HN",
                                              size: 10,
                                            ),
                                          ChatBubble(
                                            clipper: iMessageClipper(
                                                type: BubbleType
                                                    .receiverBubble),
                                            margin:
                                            EdgeInsets.only(top: 5),
                                            backGroundColor:
                                            Color(0xff3b3b3d),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxWidth: screenWidth(
                                                    context,
                                                    mulBy: 0.15),
                                              ),
                                              child: Text(
                                                "${snapshot.data[selectedChatIndex].messages.sender[reversedIndex]}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'HN',
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          ChatBubble(
                                            clipper: iMessageClipper(
                                                type: BubbleType
                                                    .sendBubble),
                                            alignment: Alignment.topRight,
                                            margin:
                                            EdgeInsets.only(top: 5),
                                            backGroundColor:
                                            Color(0xff1f8bff),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxWidth: screenWidth(
                                                    context,
                                                    mulBy: 0.15),
                                              ),
                                              child: Text(
                                                "${snapshot.data[selectedChatIndex].messages.me[reversedIndex]}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'HN',
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: ClipRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 15.0, sigmaY: 15.0),
                                  child: Container(
                                    height: screenHeight(context, mulBy: 0.09),
                                    width: double.infinity,
                                    padding: EdgeInsets.only(
                                      left:
                                      screenWidth(context, mulBy: 0.013),
                                      right: screenWidth(context, mulBy: 0.088),
                                      //vertical: screenHeight(context, mulBy: 0.03)
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.07),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: new LinearGradient(
                                                colors: [
                                                  Color(0xff6d6d6d),
                                                  Color(0xff484848)
                                                ],
                                                begin:
                                                const FractionalOffset(
                                                    0, 0),
                                                end:
                                                const FractionalOffset(
                                                    0, 1),
                                                stops: [0.0, 1.0],
                                                tileMode:
                                                TileMode.clamp),
                                          ),
                                          height: screenHeight(
                                              context,
                                              mulBy: 0.045),
                                          width: screenHeight(
                                              context,
                                              mulBy: 0.045),
                                          padding: EdgeInsets.all(
                                              screenHeight(context,
                                                  mulBy: 0.01)),
                                          child: MBPText(
                                            text:
                                            "${snapshot.data[selectedChatIndex].senderName.toString().getInitials().capitalize()}",
                                            color: Colors.white,
                                            fontFamily: "SFR",
                                            size: 25,
                                            weight: FontWeight.w500,
                                            overflow:
                                            TextOverflow.fade,
                                            maxLines: 1,
                                            softWrap: false,
                                          ),
                                        ),
                                        MBPText(
                                          text:
                                          " ${snapshot.data[selectedChatIndex].senderName} >",
                                          color: Theme.of(context)
                                              .cardColor
                                              .withOpacity(0.7),
                                          fontFamily: 'HN',
                                          weight: FontWeight.w400,
                                          size: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 15.0, sigmaY: 15.0),
                                child: Container(
                                  height: screenHeight(context, mulBy: 0.105),
                                  width: double.infinity,
                                  alignment: Alignment.topCenter,
                                  padding: EdgeInsets.symmetric(horizontal: screenWidth(context, mulBy: 0.01), vertical: screenHeight(context, mulBy: 0.01),),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .indicatorColor
                                        .withOpacity(0.65),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        CupertinoIcons.camera_fill,
                                        size: 22,
                                        color: Colors.grey,
                                      ),
                                      Image.asset(
                                        "assets/messages/store.png",
                                        height: 23,
                                      ),

                                      InkWell(
                                        //onTap: (){showAlertDialog(context);},
                                        child: Container(
                                          width: screenWidth(context,
                                              mulBy:
                                              0.7 ),
                                          height: screenHeight(context,
                                              mulBy: 0.04),
                                          padding: EdgeInsets.only(
                                              left: screenWidth(context,
                                                  mulBy: 0.008),
                                              right: screenWidth(context,
                                                  mulBy: 0.001)),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .indicatorColor
                                                  .withOpacity(0.3),
                                              borderRadius:
                                              BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .cardColor
                                                      .withOpacity(0.2))),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: screenHeight(
                                                      context,
                                                      mulBy: 0.0052),
                                                ),
                                                child: Text(
                                                  "iMessage",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .cardColor
                                                          .withOpacity(0.2),
                                                      fontFamily: 'HN',
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              Icon(
                                                CupertinoIcons.waveform_circle_fill,
                                                size: 25,
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Theme(
                      data: ThemeData(
                          cupertinoOverrideTheme:
                          CupertinoThemeData(brightness: Brightness.dark)),
                      child: Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: Theme.of(context).indicatorColor,
                              ),
                              child: Center(
                                  child: CupertinoActivityIndicator()))));
                },
              ),
            ],
          ),
          Visibility(
            visible: info,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  info=false;
                });
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
          Visibility(
            visible: info,
            child: Positioned(
              top: screenHeight(context, mulBy: 0.043),
              right: screenWidth(context, mulBy: 0.005),
              child: Stack(
                children: [
                  ClipPath(
                    clipper: DetailsClipper(),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 25.0, sigmaY: 25.0),
                      child: CustomPaint(
                        size: Size(screenWidth(context, mulBy: 0.18),screenHeight(context, mulBy: .55)),
                        painter: DetailsPainter(context, false),
                        isComplex: true,
                      ),
                    ),
                  ),
                  CustomPaint(
                    size: Size(screenWidth(context, mulBy: 0.18),screenHeight(context, mulBy: .55)),
                    painter: DetailsPainter(context, true),
                    isComplex: true,
                    child: InkWell(
                      onTap: () {
                        html.window.open(
                          selectedChat.profileLink,
                          'new tab',
                        );
                      },
                      child: Container(
                        width: screenWidth(context, mulBy: 0.18),
                        height: screenHeight(context, mulBy: .55),
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight(context, mulBy: .05),
                            horizontal: screenWidth(context, mulBy: 0.02)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: new LinearGradient(
                                    colors: [
                                      Color(0xff6d6d6d),
                                      Color(0xff484848)
                                    ],
                                    begin:
                                    const FractionalOffset(
                                        0, 0),
                                    end:
                                    const FractionalOffset(
                                        0, 1),
                                    stops: [0.0, 1.0],
                                    tileMode:
                                    TileMode.clamp),
                              ),
                              height: screenHeight(
                                  context,
                                  mulBy: 0.065),
                              width: screenHeight(
                                  context,
                                  mulBy: 0.065),
                              padding: EdgeInsets.all(
                                  screenHeight(context,
                                      mulBy: 0.012)),
                              child: MBPText(
                                text:
                                "${selectedChat.senderName.toString().getInitials().capitalize()}",
                                color: Colors.white,
                                fontFamily: "SFR",
                                size: 25,
                                weight: FontWeight.w500,
                                overflow:
                                TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight(context, mulBy: .014),
                            ),
                            MBPText(
                              text:
                              "${selectedChat.senderName.toString().capitalize()}",
                              color: Theme.of(context).cardColor.withOpacity(1),
                              fontFamily: "HN",
                              size: 13,
                              weight: Theme.of(context).textTheme.headline3.fontWeight,
                              overflow:
                              TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: screenHeight(context, mulBy: .02),
                            ),
                            //TODO: BUG Found>> Right side of info screen wont work
                            ///Track the issue at https://github.com/flutter/flutter/issues/19445
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff0b84ff),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        vertical: screenHeight(
                                            context,
                                            mulBy: 0.005),
                                      ),
                                      height: screenHeight(
                                          context,
                                          mulBy: 0.03),
                                      width: screenHeight(
                                          context,
                                          mulBy: 0.03),
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.phone_solid,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "call",
                                      overflow:
                                      TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                        color: Color(0xff0b84ff),
                                        fontFamily: "HN",
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff0b84ff),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        vertical: screenHeight(
                                            context,
                                            mulBy: 0.005),
                                      ),
                                      height: screenHeight(
                                          context,
                                          mulBy: 0.03),
                                      width: screenHeight(
                                          context,
                                          mulBy: 0.03),
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.person_crop_circle_fill,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "info",
                                      overflow:
                                      TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                        color: Color(0xff0b84ff),
                                        fontFamily: "HN",
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff0b84ff),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        vertical: screenHeight(
                                            context,
                                            mulBy: 0.005),
                                      ),
                                      height: screenHeight(
                                          context,
                                          mulBy: 0.03),
                                      width: screenHeight(
                                          context,
                                          mulBy: 0.03),
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.videocam_fill,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "video",
                                      overflow:
                                      TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                        color: Color(0xff0b84ff),
                                        fontFamily: "HN",
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                          border: Border.all(
                                              color: Theme.of(context).cardColor.withOpacity(0.15)
                                          )
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        vertical: screenHeight(
                                            context,
                                            mulBy: 0.005),
                                      ),
                                      height: screenHeight(
                                          context,
                                          mulBy: 0.03),
                                      width: screenHeight(
                                          context,
                                          mulBy: 0.03),
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.rectangle_fill_on_rectangle_fill,
                                          color: Theme.of(context).cardColor.withOpacity(0.15),
                                          size: 10,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "share",
                                      overflow:
                                      TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                        color: Theme.of(context).cardColor.withOpacity(0.15),
                                        fontFamily: "HN",
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                          border: Border.all(
                                              color: Theme.of(context).cardColor.withOpacity(0.15)
                                          )
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        vertical: screenHeight(
                                            context,
                                            mulBy: 0.005),
                                      ),
                                      height: screenHeight(
                                          context,
                                          mulBy: 0.03),
                                      width: screenHeight(
                                          context,
                                          mulBy: 0.03),
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.mail_solid,
                                          color: Theme.of(context).cardColor.withOpacity(0.15),
                                          size: 10,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "mail",
                                      overflow:
                                      TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                        color: Theme.of(context).cardColor.withOpacity(0.15),
                                        fontFamily: "HN",
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight(context, mulBy: .035),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MBPText(
                                text:
                                "Send My Current Location",
                                color: Color(0xff0b84ff),
                                fontFamily: "HN",
                                size: 10,
                                weight: FontWeight.w500,
                                overflow:
                                TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight(context, mulBy: .015),
                            ),
                            Container(
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.5),
                                height: 0.3,
                                width: double.infinity),
                            SizedBox(
                              height: screenHeight(context, mulBy: .015),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MBPText(
                                text:
                                "Share My Location",
                                color: Color(0xff0b84ff),
                                fontFamily: "HN",
                                size: 10,
                                weight: FontWeight.w500,
                                overflow:
                                TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight(context, mulBy: .015),
                            ),
                            Container(
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.5),
                                height: 0.3,
                                width: double.infinity),
                            SizedBox(
                              height: screenHeight(context, mulBy: .015),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "You are free to contact me anytime for business needs or enquiry about Chrisbin. Select info for more.",
                                style: TextStyle(
                                  color: Theme.of(context).cardColor.withOpacity(0.5),
                                  fontFamily: "HN",
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow:
                                TextOverflow.fade,
                                maxLines: 3,
                              ),
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
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
              screenWidth(context, mulBy: 0.088),
            ),
            child: InkWell(
              onTap: (){
                setState(() {
                  info=!info;
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                height: screenHeight(context,mulBy: 0.06),
                width: screenWidth(context,mulBy: 0.027),
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
      {this.messages,
        this.senderName="A",
        this.profileLink="A",
        this.senderPhoto="A",
        this.dates,
        this.dateStops});

  factory MessageContent.fromJson(Map<String, dynamic> json) {
    return MessageContent(
        messages: MainMessage.fromJson(json["messages"]),
        senderName: json["senderName"].toString(),
        dateStops: List<int>.from(json["dateStops"]),
        dates: List<String>.from(json["dates"]),
        senderPhoto: json["senderPhoto"].toString(),
        profileLink: json["profileLink"].toString());
  }
}

class MainMessage {
  List<String> sender;
  List<String> me;

  MainMessage({this.me, this.sender});

  factory MainMessage.fromJson(Map<String, dynamic> json) {
    return MainMessage(
        me: List<String>.from(json["me"]),
        sender: List<String>.from(json["sender"]));
  }
}

class DetailsPainter extends CustomPainter{

  BuildContext context;
  bool stroke;
  DetailsPainter(this.context,this.stroke);
  @override
  void paint(Canvas canvas, Size size) {



    Paint paint_0 = new Paint()
      ..color = Theme.of(context).cardColor.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeJoin= StrokeJoin.round
      ..strokeWidth = 1;

    Paint paint_1 = new Paint()
      ..color = Theme.of(context).errorColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(size.width*0.0531250,size.height*0.0720000);
    path_0.quadraticBezierTo(size.width*0.0521250,size.height*0.0473000,size.width*0.0937500,size.height*0.0480000);
    path_0.quadraticBezierTo(size.width*0.3445313,size.height*0.0477600,size.width*0.4335938,size.height*0.0472600);
    path_0.cubicTo(size.width*0.4711250,size.height*0.0469400,size.width*0.4671875,size.height*0.0455800,size.width*0.4779063,size.height*0.0396200);
    path_0.quadraticBezierTo(size.width*0.4812812,size.height*0.0367000,size.width*0.4993750,size.height*0.0233600);
    path_0.quadraticBezierTo(size.width*0.5146875,size.height*0.0368000,size.width*0.5206250,size.height*0.0404000);
    path_0.cubicTo(size.width*0.5328125,size.height*0.0485000,size.width*0.5372500,size.height*0.0457400,size.width*0.5621875,size.height*0.0470000);
    path_0.cubicTo(size.width*0.6450781,size.height*0.0472500,size.width*0.8108594,size.height*0.0477500,size.width*0.8937500,size.height*0.0480000);
    path_0.quadraticBezierTo(size.width*0.9511875,size.height*0.0447200,size.width*0.9468750,size.height*0.0760000);
    path_0.quadraticBezierTo(size.width*0.9468750,size.height*0.7315000,size.width*0.9468750,size.height*0.9500000);
    path_0.quadraticBezierTo(size.width*0.9474687,size.height*0.9778600,size.width*0.9062500,size.height*0.9740000);
    path_0.quadraticBezierTo(size.width*0.2921875,size.height*0.9755000,size.width*0.0875000,size.height*0.9760000);
    path_0.quadraticBezierTo(size.width*0.0496562,size.height*0.9752400,size.width*0.0531250,size.height*0.9480000);
    path_0.quadraticBezierTo(size.width*0.0531250,size.height*0.7290000,size.width*0.0531250,size.height*0.0720000);
    path_0.close();

    canvas.drawPath(path_0, stroke?paint_0:paint_1);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

class DetailsClipper extends CustomClipper<Path> {
  DetailsClipper({this.borderRadius = 15});
  final double borderRadius;
  @override
  Path getClip(Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.0531250,size.height*0.0720000);
    path_0.quadraticBezierTo(size.width*0.0521250,size.height*0.0473000,size.width*0.0937500,size.height*0.0480000);
    path_0.quadraticBezierTo(size.width*0.3445313,size.height*0.0477600,size.width*0.4335938,size.height*0.0472600);
    path_0.cubicTo(size.width*0.4711250,size.height*0.0469400,size.width*0.4671875,size.height*0.0455800,size.width*0.4779063,size.height*0.0396200);
    path_0.quadraticBezierTo(size.width*0.4812812,size.height*0.0367000,size.width*0.4993750,size.height*0.0233600);
    path_0.quadraticBezierTo(size.width*0.5146875,size.height*0.0368000,size.width*0.5206250,size.height*0.0404000);
    path_0.cubicTo(size.width*0.5328125,size.height*0.0485000,size.width*0.5372500,size.height*0.0457400,size.width*0.5621875,size.height*0.0470000);
    path_0.cubicTo(size.width*0.6450781,size.height*0.0472500,size.width*0.8108594,size.height*0.0477500,size.width*0.8937500,size.height*0.0480000);
    path_0.quadraticBezierTo(size.width*0.9511875,size.height*0.0447200,size.width*0.9468750,size.height*0.0760000);
    path_0.quadraticBezierTo(size.width*0.9468750,size.height*0.7315000,size.width*0.9468750,size.height*0.9500000);
    path_0.quadraticBezierTo(size.width*0.9474687,size.height*0.9778600,size.width*0.9062500,size.height*0.9740000);
    path_0.quadraticBezierTo(size.width*0.2921875,size.height*0.9755000,size.width*0.0875000,size.height*0.9760000);
    path_0.quadraticBezierTo(size.width*0.0496562,size.height*0.9752400,size.width*0.0531250,size.height*0.9480000);
    path_0.quadraticBezierTo(size.width*0.0531250,size.height*0.7290000,size.width*0.0531250,size.height*0.0720000);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}