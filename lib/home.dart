import 'dart:async';

import 'package:final_osg4/card_detail.dart';
import 'package:final_osg4/card_item.dart';
import 'package:final_osg4/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model.dart';

class HomeScreen extends StatelessWidget {

  final String title;

  const HomeScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CardRepository repo = CardRepository();

      void _showDialog() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Are you sure want to exit the app?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () {
                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    },
                  ),
                  FlatButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              _showDialog();
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: repo.getCards(),
        builder: (context,snapshot){

          List<Widget> _fetchData(){
            return (snapshot.data as List<Cards>).map((data){
              return CardItem(
                  name: data.name,
                  desc: data.desc,
                  image_url: data.cardImages[0].imageUrlSmall,
                  onTap: (){
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(data.name+" detail"),
                    ));
                    new Timer(Duration(milliseconds: 500),(){
                      Navigator.of(context).push(
                        new MaterialPageRoute(builder: (context){
                          return DetailScreen(card: data);
                        })
                      );
                    });
                  },
              );
            }).toList();
          }
          
          return ListView(
            children: <Widget>[
              if(snapshot.hasData)
                ..._fetchData()
              else
                Center(child: CircularProgressIndicator(),)
            ],
          );
        },
      )
    );
  }
}