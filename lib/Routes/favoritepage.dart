// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Controllers/authcontroller.dart';

import 'package:projet_fin_etude/Views/announceHview.dart';
import 'package:projet_fin_etude/Views/loginview.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {  
  bool isloged = false;
  checklogin()async{
    String? token = await AuthController.checklogin();
    if(token!=null){
      setState(() {
        isloged =true;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    checklogin();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  bool isfavorite = false;
  Icon favorite = Icon(
    Icons.favorite_rounded,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color(0xfff8f9fa),
      appBar: AppBar(
        backgroundColor: Color(0xfff8f9fa),
        elevation: 0,
        title: Text(
          'Wishlists',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.sort_outlined , color: Colors.black,)),
        ],
      ),
      // check if the user is logged if not list of instruction and button of login shows
      body: Center(
        child: isloged == false
            ? Column(
                children: [
                  const Text('Log in to view your wishlists'),
                  const Text('You can create, view, or edit Wishlists once you'
                      've logged in'),
                  ElevatedButton(
                      onPressed: () { 
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute<void>(
                        //     builder: (BuildContext context) =>
                        //         LoginView(),
                        //   ));
                          },
                      child: Text('Log in')),
                ],
              )
            //elsse it will show the list of
            //favorite announces
            : Text('data')
      ),
    );
  }
}
