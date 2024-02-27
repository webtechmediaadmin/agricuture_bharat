import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String price;
  final String discountPrice;

  const ItemCard({
    Key? key,
    required this.title,
    required this.price,
    required this.discountPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
     
    );
  }
}
