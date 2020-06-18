import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
          children: <Widget>[
            headerSection(),
            
            textSection(),
            textopuropapu(),
            buttonSection(),
            botonFacebook(),
            spotify(),
            
           
            
          ],
        ),
      ),
    );
  }
  
  Container textopuropapu(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          Align(alignment: Alignment.centerRight,
          child: Text(
            "Forgott Password",
            style: TextStyle(color: Colors.green,
            fontSize:13),
          
          
          )),

        ],
      ),
    );
  }


  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'password': pass
    };
    var jsonResponse = null;

    var response = await http.post("http://192.168.0.7:8000/api/login", body: data);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if(jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }
 



  Container spotify(){
    
    return Container(
    padding: EdgeInsets.all(15),
    child: Row(

      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("New to Spotify?"),
        Text(" Register",
        style: TextStyle(color: Colors.green),
        ),

      ],
    ),
    );
  }

  Container botonFacebook(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 35.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        elevation: 0.0,
        color: Colors.white,
          
                            
            child: Text("f Log in with Facebook", style: TextStyle(color: Colors.black)),
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(color: Colors.black)
              
              ),
              onPressed: () {  },
      ),
    );
  }
  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 35.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text);
        },
        elevation: 0.0,
        color: Colors.green,
        child: Text("L O G I N", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: 'EMAIL',
                labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,

              ),
             
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              
              labelText: 'PASSWORD',
                labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
              ),
              
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      
      child: Text("Hello There .",
          style: TextStyle(
              color: Colors.black,
              fontSize: 70.0,
              fontWeight: FontWeight.bold)),
    );
  }
  





}
