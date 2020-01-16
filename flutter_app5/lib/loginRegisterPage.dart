import 'package:flutter/material.dart';
import 'authentication.dart';
import'package:flutter_app5/loginRegisterPage.dart';
import'package:flutter_app5/mapping.dart';

class loginRegisterPage extends StatefulWidget
{
  loginRegisterPage
      ({
   this.auth,
   this.onSignedIn, onSignedOut,
});

  final AuthImplementation auth;
  final VoidCallback onSignedIn;

  State<StatefulWidget> createState()
  {
    return _loginRegisterState();
  }


}

enum FormType
{
  login,
  register
}

class _loginRegisterState extends State<loginRegisterPage> {
  //specifying the methods

  final formKey = GlobalKey <FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password= "";

  bool validateAndSave()
  {
  final form = formKey.currentState;
  if(form.validate())
    {
      form.save();
      return true;
    }
  else
    {
      return false;
    }

}

void validateAndSubmit() async      //call this function whenever the user call this method
{
  if(validateAndSave())
    {
      try
      {
        if(_formType == FormType.login)
          {
            String userId = await widget.auth.signIn(_email, _password);
            print("Login userId = " + userId);
          }
        else
          {
            String userId = await widget.auth.signUp(_email, _password);
            print("Register userId = " + userId);

          }
        widget.onSignedIn();

      }
      catch(e)
  {
    print("Error =" + e.toString());
  }
    }
}
void moveToRegister()
{
  formKey.currentState.reset();

  setState(() {
    _formType = FormType.register;
  });
}

  void moveToLogin()
  {
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.login;
    });
  }



  //Design

  @override

  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold (
      appBar: AppBar (
        title: Text ("Flutter Blog App"),

      ),
      body: Container (

        margin: EdgeInsets.all (15.0),
        child: Form (
          key:formKey,
          child: Column (
            children: createInputs() + createButtons(),

          ),
        ),


      ),


    );
  }

  List<Widget> createInputs()
  {
    return [
      SizedBox (height: 10.0),

      logo(),
      SizedBox (height: 20.0),

      TextFormField
        (
        decoration: InputDecoration (labelText: 'Email'),
        //adding validation
        validator: (value)
          {
            return value.isEmpty ? 'Email is required.':null;
          },

        onSaved : (value)
          {
            return _email =value;
          },
      ),
      SizedBox (height: 10.0),
      TextFormField (
        decoration: InputDecoration (labelText: 'Password'),
  obscureText: true,
  validator: (value)
  {
  return value.isEmpty ? 'password is required.':null;
  },

  onSaved : (value)
    {
    return _email =value;
    }
      ),
      SizedBox (height: 20.0),

    ];
  }


  Widget logo() {
    return Hero (
      tag:'hero',
        child: CircleAvatar (
          backgroundColor: Colors.transparent,
          radius: 110.0,
          child: Image.asset ('images/background1.jpg'),
        ),
    );
  }

  List<Widget>createButtons()
  {
    if (_formType == FormType.login)
      {
        return [
          RaisedButton
            (
              child:Text("Login",style:TextStyle(
                  fontSize: 20.0
              )
              ),
              textColor: Colors.cyan,
              color:Colors.red,

              onPressed: validateAndSave,
          ),
          FlatButton
            (
            child:Text("Not have an account?Create account?",style:TextStyle(
                fontSize: 14.0
            )
            ),
            textColor: Colors.cyan,
            onPressed: moveToRegister,

          ),
        ];
      }
    else
      {
        return [
          RaisedButton
            (
              child:Text("Create Account",style:TextStyle(
                  fontSize: 20.0
              )
              ),
              textColor: Colors.blueAccent,
              color:Colors.pink,

              onPressed: validateAndSubmit,
          ),
          FlatButton
            (
            child:Text("Already have an Account? Login Now",style:TextStyle(
                fontSize: 14.0
            )
            ),
            textColor: Colors.blueAccent,
            onPressed: moveToLogin,

          ),
        ];
      }
  }


}


