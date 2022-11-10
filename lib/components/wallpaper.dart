import 'package:flutter/material.dart';

class Wallpaper extends StatefulWidget {
  const Wallpaper({Key? key}) : super(key: key);

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
        Theme.of(context).colorScheme.onError,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15)),
      ),
      padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 30,
          bottom: 10
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .errorContainer,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 0.3
            )
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.4),
                          width: 1.2
                      )
                  ),
                  height: 90,
                  width: 130,
                  child: Image.asset(
                    "assets/wallpapers/bigsur_dark.jpg",
                    fit: BoxFit.cover,
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}