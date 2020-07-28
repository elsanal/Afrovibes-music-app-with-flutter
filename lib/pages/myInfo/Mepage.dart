import 'package:flutter/material.dart';

class Mepage extends StatefulWidget {
  @override
  _MepageState createState() => _MepageState();
}

class _MepageState extends State<Mepage> {
  @override
  Widget build(BuildContext context) {
    final mediaquery  = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
          color: Colors.grey[500],
          child: ListView(
            children: <Widget>[
              Center(
                child: new Container(
                  color: Colors.black,
                  height: mediaquery*(1/3),
                  width: mediaquery,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  child: FittedBox(
                    child: CircleAvatar(
                      backgroundImage: new AssetImage("assets/profile.jpeg"),
                    ),
                  ),
                ),
              ),
              new ListView(
                shrinkWrap: true,
                //physics: ClampingScrollPhysics(),
                children: <Widget>[
                    Card(
                      child: new ListTile(
                        leading: Icon(Icons.view_comfy),
                        title: Text("My posts"),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: (){},
                      ),
                      color: Colors.white,
                    ),
                  Card(
                    child: new ListTile(
                      leading: Icon(Icons.library_add),
                      title: Text("Library"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){},
                    ),
                    color: Colors.white,
                  ),
                  Card(
                    child: new ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text("Followers"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){},
                    ),
                    color: Colors.white,
                  ),
                  Card(
                    child: new ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("Settings"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){},
                    ),
                    color: Colors.white,
                  ),

                  Card(
                    child: new ListTile(
                      leading: Icon(Icons.power_settings_new),
                      title: Text("Log out"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){},
                    ),
                    color: Colors.white,
                  ),
                  Card(
                    child: new ListTile(
                      leading: Icon(Icons.delete),
                      title: Text("Delete account"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){},
                    ),
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
