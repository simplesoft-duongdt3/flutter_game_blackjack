import 'package:flutter/material.dart';

import 'card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    int cardWidth = (MediaQuery.of(context).size.width ~/ 4) - 16;
    int cardHeight = CardUtil.getHeightCardFromWidth(cardWidth);
    return Scaffold(
      backgroundColor: Colors.green[900],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                createCard(
                  cardWidth,
                  cardHeight,
                  CardSuit.heart,
                  CardSymbol.four,
                ),
                createCard(
                  cardWidth,
                  cardHeight,
                  CardSuit.diamond,
                  CardSymbol.king,
                ),
                createCard(
                  cardWidth,
                  cardHeight,
                  CardSuit.spade,
                  CardSymbol.nine,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardBackWidget(
                cardWidth: cardWidth,
                cardHeight: cardHeight,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                createCard(
                  cardWidth,
                  cardHeight,
                  CardSuit.club,
                  CardSymbol.two,
                ),
                createCard(
                  cardWidth,
                  cardHeight,
                  CardSuit.spade,
                  CardSymbol.ten,
                ),
                createCard(
                  cardWidth,
                  cardHeight,
                  CardSuit.diamond,
                  CardSymbol.queen,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding createCard(
      int cardWidth, int cardHeight, CardSuit suit, CardSymbol symbol) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CardFrontWidget(
        cardWidth: cardWidth,
        cardHeight: cardHeight,
        card: CardInfo(
          suit: suit,
          symbol: symbol,
        ),
      ),
    );
  }
}
