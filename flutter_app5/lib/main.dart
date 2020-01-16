import 'package:flutter/material.dart';
import'mapping.dart';
import'authentication.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.pink,
      ),
      home: MappingPage(auth: Auth(),),     //our app will directly go to the mapping page

    );
  }
}





//our app starts from the main page and directly go the mapping page