import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {

  final String name;
  final String desc;
  final String image_url;
  final GestureTapCallback onTap;

  const CardItem({Key key, this.name, this.desc, this.image_url, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _image = Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
        fit: BoxFit.fill,
        image: NetworkImage(image_url)
      )
    ));

    Widget _text = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(desc, style: TextStyle(fontSize: 10)),
        ],
      ),
    );

    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              _image,
              SizedBox(width: 10,),
              _text
            ],
          ),
        ),
      ),
    );
  }
}