import 'package:flutter/material.dart';
import'authentication.dart';


class HomePage extends StatefulWidget
{


  HomePage
      ({
    this.auth,
    this.onSignedOut,
});
  final AuthImplementation auth;
  final VoidCallback onSignedOut;
  @override
   State<StatefulWidget> createState()
  {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  void _logOutUser() async
  {
  try{
    await widget.auth.signOut();
    widget.onSignedOut();
  }

  catch(e)
    {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold (
        appBar: new AppBar(
          title: Text ("Home"),
        ),
        body: new Container
          (

        ),
        bottomNavigationBar: new BottomAppBar(
            color: Colors.pink,

            child: new Container(

              margin: const EdgeInsets.only(left: 70.0, right: 50.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,

                  children: <Widget>[
                    IconButton (
                      icon: Icon (Icons.local_car_wash),
                      iconSize: 50,
                      color: Colors.white,

                      onPressed: _logOutUser,
                    ),
                    IconButton (
                      icon: Icon (Icons.add_a_photo),
                      iconSize: 40,
                      color: Colors.white,

                      onPressed: null,
                    ),
                  ],

                )

            )
        )
    );
  }
}