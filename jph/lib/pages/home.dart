import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jph/api/api.dart';
import 'package:jph/models/album.dart';
import 'package:jph/models/photo.dart';
import 'package:jph/models/post.dart';
import 'package:jph/pages/add_post.dart';
import 'package:jph/pages/view_photo.dart';
import 'package:jph/ui/ui_elements.dart';
import 'package:jph/widgets/action_sheet.dart';

enum ViewState { busyPost, busyAlbum, busyPhoto, idle, error, loadingPosts }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> postsList = [];
  List<Album> albumLists = [];
  List<Photo> photoLists = [];

  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  ViewState viewState;

  int id = 1, aId = 1;

  ScrollController _postScroll;

  Future<List<Post>> getPost(int id) async {
    setState(() {
      viewState = ViewState.busyPost;
    });
    Iterable _postList = await ApiService().getPosts(id);
    setState(() {
      viewState = ViewState.idle;
      postsList.addAll(_postList);
    });
    return _postList;
  }

  getAlbum(int id) async {
    setState(() {
      viewState = ViewState.busyAlbum;
    });
    Iterable _albumList = await ApiService().getAlbums(id);
    setState(() {
      viewState = ViewState.idle;
      albumLists.addAll(_albumList);
    });
    // return _albumList;
  }

  Future<List<Post>> loadPost(int id) async {
    setState(() {
      viewState = ViewState.loadingPosts;
    });
    Iterable _postList = await ApiService().getPosts(id);
    setState(() {
      viewState = ViewState.idle;
      postsList.addAll(_postList);
    });
    return _postList;
  }

  Future<List<Photo>> getPhoto() async {
    setState(() {
      viewState = ViewState.busyPhoto;
    });
    Iterable _photoList = await ApiService().getPhoto(id);
    setState(() {
      viewState = ViewState.idle;
      photoLists.addAll(_photoList);
    });
    return _photoList;
  }

  Widget postList() {
    return ListView.builder(
      controller: _postScroll,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: postsList.length,
      itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width,
          // height: 30,
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: UIHelp().secondaryColor),
          child: Column(
            children: <Widget>[
              Text(postsList[index].title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: UIHelp().accent,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'mont',
                  )),
              SizedBox(
                height: 10.0,
              ),
              Text(
                postsList[index].body,
                textAlign: TextAlign.left,
                style: TextStyle(color: UIHelp().textColor, fontFamily: 'com'),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "UserID: ${postsList[index].userId}",
                    style:
                        TextStyle(color: UIHelp().textColor.withOpacity(0.6)),
                  ),
                  Text(
                    "Post ID: ${postsList[index].id}",
                    style:
                        TextStyle(color: UIHelp().textColor.withOpacity(0.6)),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget albumList() {
    return ListView.builder(
      itemCount: albumLists.length,
      itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: UIHelp().secondaryColor),
          child: Column(
            children: <Widget>[
              Text(albumLists[index].title.toUpperCase(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: UIHelp().accent,
                    fontSize: 38.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'mont',
                  )),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "UserID: ${albumLists[index].userId}",
                    style:
                        TextStyle(color: UIHelp().textColor.withOpacity(0.6)),
                  ),
                  Text(
                    "Post ID: ${albumLists[index].id}",
                    style:
                        TextStyle(color: UIHelp().textColor.withOpacity(0.6)),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget photoList() {
    return viewState == ViewState.busyPhoto
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: photoLists.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Material(
                    color: UIHelp().secondaryColor,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ViewPhoto(
                                      photo: photoLists[index],
                                    ),
                                fullscreenDialog: true));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Hero(
                              tag: photoLists[index].url,
                              child: Container(
                                height: MediaQuery.of(context).size.width * .5,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      colorFilter:
                                          ColorFilter.srgbToLinearGamma(),
                                      image:
                                          NetworkImage(photoLists[index].url),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(photoLists[index].title.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: UIHelp().accent,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'mont',
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }

  @override
  void initState() {
    _postScroll = ScrollController();
    super.initState();
    getPost(id);
    getAlbum(aId);
    getPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: UIHelp().bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: UIHelp().secondaryColor,
          centerTitle: true,
          title: Text(
            "Home",
            style: TextStyle(
                color: UIHelp().accent,
                fontSize: 24.0,
                // fontFamily: 'mont',
                fontWeight: FontWeight.w900),
          ),
          actions: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 8.0),
              child: IconButton(
                  padding: EdgeInsets.all(0),
                  color: UIHelp().accent,
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(50.0)),
                  icon: Icon(Icons.add_comment, color: UIHelp().textColor),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => AddPostPage(),
                            fullscreenDialog: false));
                  }),
            )
          ],
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.language),
                text: 'Posts',
              ),
              Tab(
                icon: Icon(Icons.album),
                text: 'Album',
              ),
              Tab(
                icon: Icon(Icons.photo_filter),
                text: 'Photo',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            viewState == ViewState.busyPost ||
                    viewState == ViewState.busyAlbum ||
                    viewState == ViewState.busyPhoto
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        postList(),
                        SizedBox(
                          height: 20.0,
                        ),
                        id != 10
                            ? Center(
                                child: viewState == ViewState.loadingPosts
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(),
                                      )
                                    : FlatButton(
                                        child: Text(
                                          "Load More",
                                          style: TextStyle(
                                            color: UIHelp().accent,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            id++;
                                          });
                                          loadPost(id);
                                        },
                                      ),
                              )
                            : Container(),
                        SizedBox(
                          height: id != 10 ? 20.0 : 0,
                        )
                      ],
                    ),
                  ),
            albumList(),
            photoList(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          mini: true,
          backgroundColor: UIHelp().accent,
          child: Icon(
            Icons.person,
            color: UIHelp().textColor,
          ),
          onPressed: () {
            showCupertinoModalPopup(
                context: context, builder: (context) => actionSheet(context));
          },
        ),
      ),
    );
  }
}
