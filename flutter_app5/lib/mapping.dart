import'package:flutter/material.dart';
import'loginRegisterPage.dart';
import'homePage.dart';
import'authentication.dart';


class MappingPage extends StatefulWidget
{
  final AuthImplementation auth;

  MappingPage
      (
  {
    this.auth,
}
      );

  State<StatefulWidget>createState()
  {
    return _MappingPageState();
  }
}



enum AuthStatus
{
  notSignedIn,
  signedIn,
}



class _MappingPageState extends State<MappingPage>
{

  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  //code will check the suth state of the currw=ent user.THrowing the user from the main app
  void initState()
  {
  super.initState();
  widget.auth.getCurrentUser().then((firebaseUserId)
  {
    setState((){
      authStatus = firebaseUserId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
  });
  });
  }

  void _signedIn()
  {
    setState((){
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signOut()
  {
    setState((){
      authStatus = AuthStatus.notSignedIn;
    });
  }


  @override
  Widget build(BuildContext context) {
    switch(authStatus)
    {
      case AuthStatus.notSignedIn:
        return new loginRegisterPage
    (
    auth:widget.auth,
    onSignedIn :_signedIn,
    );
      case AuthStatus.signedIn:
        return new HomePage
          (
          auth:widget.auth,
          onSignedOut :_signOut,
        );

    }

    return null;

  }
}

//the map page will check the auth from authimplementation the user is signed in or not.
// If user is signed in  then it will basically allow the user to go to the home page and from their thr user can log out.
//If the user is not signed in then it will allow the user to log in.