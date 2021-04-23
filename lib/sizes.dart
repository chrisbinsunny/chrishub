import 'package:flutter/material.dart';

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}
double screenHeight(BuildContext context, {double mulBy = 1}) {
  return screenSize(context).height * mulBy;
}
double screenWidth(BuildContext context, {double mulBy = 1}) {
  return screenSize(context).width * mulBy;
}