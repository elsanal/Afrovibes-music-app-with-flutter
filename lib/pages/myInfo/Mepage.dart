import 'package:afromuse/sharedPage/gradients.dart';
import 'package:flutter/material.dart';

class Mepage extends StatefulWidget {
  @override
  _MepageState createState() => _MepageState();
}

class _MepageState extends State<Mepage> {
  @override
  Widget build(BuildContext context) {
    final mediaquery  = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
          height: height,
          color: Colors.grey[400],
          child: ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Center(
                child: new Container(
                  decoration: BoxDecoration(
                    gradient: gradient
                  ),
                  height: mediaquery*(3/5),
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
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                    Card(
                      child: new ListTile(
                        leading: Icon(Icons.view_comfy, color: Colors.black,),
                        title: Text("My posts"),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: (){
                            Navigator.pushNamed(context, '/myPost');
                        },
                      ),
                      color: Colors.white,
                    ),
                  Card(
                    child: new ListTile(
                      leading: Icon(Icons.library_add, color: Colors.black,),
                      title: Text("Library"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){},
                    ),
                    color: Colors.white,
                  ),
                  Card(
                    child: new ListTile(
                      leading: Icon(Icons.person_outline, color: Colors.black,),
                      title: Text("Followers"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){},
                    ),
                    color: Colors.white,
                  ),
                  Card(
                    child: new ListTile(
                      leading: Icon(Icons.settings, color: Colors.black,),
                      title: Text("Settings"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){},
                    ),
                    color: Colors.white,
                  ),

                  Card(
                    child: new ListTile(
                      leading: Icon(Icons.power_settings_new, color: Colors.black,),
                      title: Text("Log out"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){},
                    ),
                    color: Colors.white,
                  ),
                  Card(
                    child: new ListTile(
                      leading: Icon(Icons.delete, color: Colors.black,),
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
