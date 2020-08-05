import 'package:flutter/material.dart';
import 'package:jph/api/api.dart';
import 'package:jph/models/post.dart';
import 'package:jph/ui/ui_elements.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffKey = GlobalKey<ScaffoldState>();

  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: UIHelp().bgColor,
      appBar: AppBar(
        backgroundColor: UIHelp().secondaryColor,
        centerTitle: true,
        title: Text(
          "Add Post",
          style: TextStyle(color: UIHelp().accent),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: UIHelp().secondaryColor,
              ),
              child: TextField(
                controller: title,
                cursorColor: UIHelp().accent,
                cursorWidth: 1.5,
                textCapitalization: TextCapitalization.words,
                autocorrect: true,
                autofocus: false,
                style: TextStyle(color: UIHelp().textColor, fontSize: 18.0),
                onSubmitted: (pattern) {
                  FocusScope.of(context).nextFocus();
                },
                decoration: InputDecoration(
                    hintText: 'Enter title',
                    hintStyle:
                        TextStyle(color: UIHelp().textColor.withOpacity(.3)),
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 500.0,
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: UIHelp().secondaryColor,
              ),
              child: TextField(
                controller: body,
                cursorColor: UIHelp().accent,
                cursorWidth: 1.5,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                autofocus: false,
                style: TextStyle(color: UIHelp().textColor, fontSize: 18.0),
                onSubmitted: (pattern) {
                  FocusScope.of(context).nextFocus();
                },
                decoration: InputDecoration(
                    hintText: 'Enter body',
                    hintStyle:
                        TextStyle(color: UIHelp().textColor.withOpacity(.3)),
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: loading
          ? CircularProgressIndicator()
          : FloatingActionButton.extended(
              onPressed: () async {
                if (title.text.isNotEmpty && body.text.isNotEmpty) {
                  setState(() {
                    loading = true;
                  });
                  Post post = Post(
                      userId: 1, id: 1, title: title.text, body: body.text);
                  bool added = await ApiService().postPost(post);
                  if (added == true) {
                    setState(() {
                      loading = false;
                    });
                    Navigator.pop(context);
                  } else {
                    _scaffKey.currentState.showSnackBar(SnackBar(
                      content: Text(
                        "There seems to be some error! Sorry",
                        style: TextStyle(fontFamily: 'mont'),
                      ),
                    ));
                  }
                } else {
                  _scaffKey.currentState.showSnackBar(SnackBar(
                    content: Text(
                      "Please fill all details!!!",
                      style: TextStyle(fontFamily: 'mont'),
                    ),
                  ));
                }
              },
              label: Text(
                "Submit",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18.0,
                    letterSpacing: -.5,
                    fontFamily: 'mont',
                    color: UIHelp().textColor),
              ),
            ),
    );
  }
}
