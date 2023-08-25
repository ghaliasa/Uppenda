import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double height1;
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    height1 = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple,
              Colors.deepPurple,
            ],
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
          ),
        ),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('profile');
                            },
                            child: Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: 22,
                            )),
                        CircleAvatar(
                          maxRadius: 60,
                          backgroundColor: Colors.transparent,
                          child: Text(
                            "Settings",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 41,
                              fontFamily: 'DancingScript',
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('profile');
                            },
                            child: Icon(
                              Icons.home,
                              color: Colors.white,
                              size: 22,
                            ))
                      ],
                    ),
                  ]))),
          Card(
              margin: EdgeInsets.only(left: 14, right: 14, bottom: 10),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50)),
              //child: SafeArea(
              child: Container(
                  height: ((3 * height) / 4) + ((height / 4) - 145),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: ListView(
                    children: setting_element(),
                  ))),
        ]));
  }

  List<Widget> setting_element() {
    bool isSwitched = false;
    List<Widget> list = List();

    list.add(ListTile(
      title: Text(
        "Show Friends",
        style: TextStyle(
            color: Colors.deepPurple,
            //    fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Merienda'),
      ),
      trailing: Icon(
        Icons.people,
        color: Colors.deepPurple,
      ),
      onTap: () {},
    ));

    list.add(
      Divider(
        color: Colors.deepPurple,
        thickness: 0.6,
      ),
    );

    list.add(
      ListTile(
        title: Text(
          "Show Pages",
          style: TextStyle(
            color: Colors.deepPurple,
            fontFamily: 'Merienda',
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          Icons.description,
          color: Colors.deepPurple,
        ),
        onTap: () {
          Navigator.of(context).pushNamed('pages');
        },
      ),
    );

    list.add(
      Divider(
        color: Colors.deepPurple,
        thickness: 0.6,
      ),
    );

    list.add(
      ListTile(
        title: Text(
          "Show Groups",
          style: TextStyle(
            color: Colors.deepPurple,
            fontFamily: 'Merienda',
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          Icons.supervised_user_circle,
          color: Colors.deepPurple,
        ),
        onTap: () {},
      ),
    );
    list.add(
      Divider(
        color: Colors.deepPurple,
        thickness: 0.6,
      ),
    );

    list.add(
      ListTile(
        title: Text(
          " Sign Out ",
          style: TextStyle(
              color: Colors.deepPurple,
              fontFamily: 'Merienda',
              fontWeight: FontWeight.bold),
        ),
        trailing: Icon(
          Icons.exit_to_app_outlined,
          color: Colors.deepPurple,
        ),
      ),
    );
    list.add(
      Divider(
        color: Colors.deepPurple,
        thickness: 0.8,
      ),
    );
    return list;
  }
}
