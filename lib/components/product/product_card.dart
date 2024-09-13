import 'package:flutter/material.dart';

import '../../constants.dart';
import '../network_image_with_loader.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.press,
  });

  final String image, name;
  final double price;
  final VoidCallback press;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _isHovered = true;
        });
        widget.press();
        Future.delayed(const Duration(milliseconds: 200), () {
          setState(() {
            _isHovered = false;
          });
        });
      },
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(150, 150),
        maximumSize: const Size(150, 150),
        padding: const EdgeInsets.all(0),
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: NetworkImageWithLoader(widget.image,
                      radius: defaultBorderRadious),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? Colors.white.withOpacity(0)
                        : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(defaultBorderRadious),
                  ),
                ),
                Positioned(
                  left: defaultPadding / 2,
                  top: defaultPadding / 2,
                  right: defaultPadding / 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
                Positioned(
                  right: defaultPadding / 2,
                  bottom: defaultPadding / 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child: Text(
                      "${widget.price} kr",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
