// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Widgets/announcedetails.dart';

class AnnounceWidget extends StatefulWidget {
  const AnnounceWidget({ Key? key }) : super(key: key);

  @override
  _AnnounceWidgetState createState() => _AnnounceWidgetState();
}

class _AnnounceWidgetState extends State<AnnounceWidget> {
  bool isfavorite= false ;
  Icon favorite = Icon(Icons.favorite_border_outlined);
  //when u click the announce widget the announcedtails shows up
  void _gotoAnnounceDetails(BuildContext context){
    Navigator.push(context,     MaterialPageRoute<void>(
      builder: (BuildContext context) => const AnnounceDetails(),
    ),);
  }
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'AnnounceDetails',
      child: GestureDetector(
        onTap: () => _gotoAnnounceDetails(context),
        child: Container(
          width: 250,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3.0,
              blurRadius: 5.0)
              ],
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          child: Card(
            elevation: 0,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.asset('Assets/images/house.jfif'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: IconButton(icon : favorite,splashColor: Colors.transparent,highlightColor: Colors.transparent, color: Colors.grey,onPressed: (){
                      // to change the icon if u liked it or dislike it
                      setState(() { 
                        if(isfavorite == true){
                          isfavorite =false;
                          favorite = Icon(Icons.favorite_border_outlined);
                        }else{
                          isfavorite = true;
                          favorite = Icon(Icons.favorite,color: Colors.red,);
                        }
                      });
                    },),
                  ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, top: 5,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text('Okinawa Summer House', style: TextStyle( fontWeight: FontWeight.bold),),
                      ),
                      Text('NYC   .  200m²   .  F3  ')
                    ],
                  ),
                ),
              ], 
            ), 
          ),
        ),
      ),
    );
  }
}