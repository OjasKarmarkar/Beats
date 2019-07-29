import 'package:beats/Models/Username.dart';
import 'package:beats/screens/Recents.dart';
import 'package:beats/models/PlaylistRepo.dart';
//import 'package:beats/Models/playlist_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'PlayList.dart';

double height, width;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Username username;

  @override
  Widget build(BuildContext context) {
    username = Provider.of<Username>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: <Widget>[
          Container(
            height: height * 0.25,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.08, left: width * 0.1),
                      child: Text(
                        username.getName() + ",",
                        style: Theme.of(context).textTheme.headline,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.005, left: width * 0.1),
                      child: Text("Welcome",
                          style: Theme.of(context).textTheme.subhead),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Image.asset("assets/headphone.png"))
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: height * 0.04),
              child: SizedBox(
                height: height * 0.31,
                child: Consumer<PlaylistRepo>(
                  builder: (context, playlistRepo, _) => ListView.builder(
                    itemCount: playlistRepo.playlist.length + 1,
                    itemBuilder: (context, pos) {
                      var padd = (pos == 0) ? width * 0.08 : 5.0;
                      if (pos == (playlistRepo.playlist.length)) {
                        return Card(
                          margin: EdgeInsets.only(left: padd, right: 5.0),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: width * 0.4,
                                child: Center(child: Icon(Icons.add)),
                              )),
                        );
                      } else {
                        return Card(
                          margin: EdgeInsets.only(left: padd, right: 5.0),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: GestureDetector(
                            onTap: () {
                              playlistRepo.selected = pos;
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) => new PLayListScreen()));
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: width * 0.4,
                                  color: Colors.blue,
                                  child: Center(
                                      child: Text(playlistRepo.playlist[pos],
                                          style:
                                              TextStyle(color: Colors.white))),
                                )),
                          ),
                        );
                      }
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: height * 0.03, left: 20.0),
            child: Text(
              "Recently Played",
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          Expanded(
            child: LastPlayed(),
          )
        ],
      ),
    );
  }
}
