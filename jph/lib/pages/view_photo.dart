import 'package:flutter/material.dart';
import 'package:jph/models/photo.dart';
import 'package:jph/ui/ui_elements.dart';

class ViewPhoto extends StatefulWidget {
  final Photo photo;
  ViewPhoto({@required this.photo});
  @override
  _ViewPhotoState createState() => _ViewPhotoState();
}

class _ViewPhotoState extends State<ViewPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UIHelp().bgColor,
        appBar: AppBar(
          backgroundColor: UIHelp().secondaryColor,
          centerTitle: true,
          title: Text(
            "View Photo",
            style: TextStyle(color: UIHelp().accent),
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Hero(
                      tag: widget.photo.url,
                      child: Container(
                        height: MediaQuery.of(context).size.width - 20.0,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.srgbToLinearGamma(),
                              image: NetworkImage(widget.photo.url),
                            )),
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(widget.photo.title,
                      style: TextStyle(
                          color: UIHelp().accent,
                          fontSize: 42.0,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'mont')),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Photo ID: ${widget.photo.albumId}",
                    style: TextStyle(
                        fontFamily: 'mont',
                        fontSize: 20.0,
                        color: UIHelp().textColor.withOpacity(.5),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "ID: ${widget.photo.id}",
                    style: TextStyle(
                        fontFamily: 'com',
                        fontSize: 20.0,
                        color: UIHelp().textColor.withOpacity(.5),
                        fontWeight: FontWeight.bold),
                  ),
                ])));
  }
}
