import 'package:flutter/material.dart';
import 'dart:math';

class CardUtil {
  static int getHeightCardFromWidth(int cardWidth) {
    return cardWidth * 250 ~/ 176;
  }

  static int getWidthCardFromHeight(int cardHeight) {
    return cardHeight * 176 ~/ 250;
  }

  static double radians2Degrees = 180.0 / pi;

  static double degrees2Radians = pi / 180.0;

  /// Convert [radians] to degrees.
  static double degrees(double radians) => radians * radians2Degrees;

  /// Convert [degrees] to radians.
  static double radians(double degrees) => degrees * degrees2Radians;
}

class CardBackWidget extends StatelessWidget {
  final int cardWidth;
  final int cardHeight;

  const CardBackWidget({
    Key? key,
    this.cardWidth = 176,
    this.cardHeight = 250,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: cardWidth.toDouble(),
        height: cardHeight.toDouble(),
        color: Colors.white,
        child: Image.asset(
          "images/card_back_black.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

enum CardSuit {
  //clubs (♣), diamonds (♦), hearts (♥), and spades (♠).
  heart,
  diamond,
  club,
  spade
}

extension CardSuitEx on CardSuit {
  Color getColor() {
    if (this == CardSuit.heart || this == CardSuit.diamond) {
      return Colors.red.shade700;
    } else {
      return Colors.black;
    }
  }

  String getText() {
    String value = "";
    switch (this) {
      case CardSuit.heart:
        value = "♥";
        break;
      case CardSuit.diamond:
        value = "♦";
        break;
      case CardSuit.club:
        value = "♣";
        break;
      case CardSuit.spade:
        value = "♠";
        break;
      default:
        value = "";
    }
    return value;
  }
}

enum CardSymbol {
  ace,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king,
}

extension CardSymbolEx on CardSymbol {
  String getText() {
    String value = "";
    switch (this) {
      case CardSymbol.ace:
        value = "A";
        break;
      case CardSymbol.two:
        value = "2";
        break;
      case CardSymbol.three:
        value = "3";
        break;
      case CardSymbol.four:
        value = "4";
        break;
      case CardSymbol.five:
        value = "5";
        break;
      case CardSymbol.six:
        value = "6";
        break;
      case CardSymbol.seven:
        value = "7";
        break;
      case CardSymbol.eight:
        value = "8";
        break;
      case CardSymbol.nine:
        value = "9";
        break;
      case CardSymbol.ten:
        value = "10";
        break;
      case CardSymbol.jack:
        value = "J";
        break;
      case CardSymbol.queen:
        value = "Q";
        break;
      case CardSymbol.king:
        value = "K";
        break;
      default:
        value = "";
    }
    return value;
  }
}

class CardInfo {
  final CardSuit suit;
  final CardSymbol symbol;

  CardInfo({required this.suit, required this.symbol});
}

extension CardInfoEx on CardInfo {
  String getCardText() {
    return symbol.getText();
  }

  String getSuitText() {
    return suit.getText();
  }

  Color getCardColor() {
    return suit.getColor();
  }
}

class CardFrontWidget extends StatelessWidget {
  final int cardWidth;
  final int cardHeight;
  final CardInfo card;

  const CardFrontWidget({
    Key? key,
    this.cardWidth = 176,
    this.cardHeight = 250,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: cardWidth.toDouble(),
        height: cardHeight.toDouble(),
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 4,
              top: 4,
              child: Text(
                card.getCardText(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: card.getCardColor(),
                  fontSize: 20,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                card.getSuitText(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: card.getCardColor(),
                  fontSize: 30,
                ),
              ),
            ),
            Positioned(
              right: 4,
              bottom: 4,
              child: Transform.rotate(
                angle: CardUtil.radians(180),
                child: Text(
                  card.getCardText(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: card.getCardColor(),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimationCardWidget extends StatefulWidget {
  final CardInfo card;
  final int cardWidth;
  final int cardHeight;

  const AnimationCardWidget({
    Key? key,
    required this.card,
    required this.cardWidth,
    required this.cardHeight,
  }) : super(key: key);

  @override
  _AnimationCardWidgetState createState() => _AnimationCardWidgetState();
}

class _AnimationCardWidgetState extends State<AnimationCardWidget>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateY(CardUtil.radians(180 - (_animation!.value * 180))),
      child: GestureDetector(
        onTap: () {
          if (_animationStatus == AnimationStatus.dismissed) {
            _controller?.forward();
          } else {
            _controller?.reverse();
          }
        },
        child: _animation != null && _animation!.value > 0.5
            ? CardFrontWidget(
                cardWidth: widget.cardWidth,
                cardHeight: widget.cardHeight,
                card: widget.card,
              )
            : const CardBackWidget(),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
