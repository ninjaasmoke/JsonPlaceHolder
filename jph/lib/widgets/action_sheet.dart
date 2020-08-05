import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jph/ui/ui_elements.dart';
import 'package:url_launcher/url_launcher.dart' as launch;

Widget actionSheet(BuildContext context) {
  return Theme(
    data: ThemeData.dark(),
    child: CupertinoActionSheet(
      title: Text(
        "Just kidding! It's only me ☺",
        style: TextStyle(
            fontFamily: 'mont',
            color: UIHelp().accent,
            fontWeight: FontWeight.w500,
            fontSize: 14),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(
            "Visit GitHub ►",
            style: TextStyle(
                fontFamily: 'mont',
                color: UIHelp().textColor.withOpacity(.8),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          onPressed: () async {
            Navigator.pop(context);
            const url = 'https://www.github.com/ninjaasmoke';
            if (await launch.canLaunch(url)) {
              try {
                launch.launch(url);
              } catch (e) {
                print(e.toString());
              }
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text(
            "Request Feature",
            style: TextStyle(
                fontFamily: 'mont',
                color: UIHelp().textColor.withOpacity(.8),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          onPressed: () async {
            Navigator.pop(context);
            const url =
                'mailto:iumapplications@gmail.com?subject=Feature%20Request:%20Weatherium';
            if (await launch.canLaunch(url)) {
              try {
                launch.launch(url);
              } catch (e) {
                print(e.toString());
              }
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text(
            "Report issue",
            style: TextStyle(
                fontFamily: 'mont',
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          onPressed: () async {
            Navigator.pop(context);
            const url =
                'mailto:iumapplications@gmail.com?subject=Issue%20Report';
            if (await launch.canLaunch(url)) {
              try {
                launch.launch(url);
              } catch (e) {
                print(e.toString());
              }
            }
          },
          isDestructiveAction: true,
        ),
        CupertinoActionSheetAction(
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.red,
              fontFamily: 'mont',
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      // cancelButton: CupertinoActionSheetAction(
      //   child: Text(
      //     "Cancel",
      //     style: TextStyle(
      //       color: Colors.red,
      //       fontFamily: 'mont',
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      // ),
    ),
  );
}
