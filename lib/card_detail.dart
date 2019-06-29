import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'model.dart';

class DetailScreen extends StatelessWidget {

  final Cards card;

  const DetailScreen({Key key, this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _image = Container(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          ...card.cardImages.map((data){
            return Container(
              padding: EdgeInsets.only(left: 75,right: 75),
              height: 300,
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: data.imageUrl,
                )
            );
          }).toList()
        ],
      ),  
    );

    Widget _text(textName, value){
      return Card(
        child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(textName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Text(value)
            ],
          ),
        ),
      );
    }

    String cardSet(List<CardSets> cardSets){
      String sets_str = "";

      for (var card_set in cardSets) {
        sets_str +=  "Set name: "+card_set.setName+"\n"+
        "Set Code: "+card_set.setCode+"\n"+
        "Set Rarity: "+card_set.setRarity+"\n"+
        "Set Price : "+card_set.setPrice+"\n"+
        "\n";
      }
      return sets_str;
    }

    String cardPrice(CardPrices cardPrice){
      return "Card market: "+cardPrice.cardmarketPrice+"\n"+
      "TCG Player: "+cardPrice.tcgplayerPrice+"\n"+
      "Ebay : "+cardPrice.ebayPrice+"\n"+
      "Amazon : "+cardPrice.amazonPrice+"\n";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            if(card.cardImages != null)
              _image,
            if(card.name != null)
              _text("Name", card.name),
            if(card.desc != null)
              _text("Description", card.desc),
            if(card.type != null)
              _text("Card Type", card.type),
            if(card.race != null)
              _text("Race", card.race),
            if(card.archetype != null)
              _text("Arche Type", card.archetype),
            if(card.cardSets != null)
              _text("Sets", cardSet(card.cardSets)),
            if(card.cardPrices != null)
              _text("Prices", cardPrice(card.cardPrices))
          ],
        ),
      ),
    );
  }
}