import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarRatebar extends StatefulWidget {
  const StarRatebar({super.key,required this.text,required this.controller});
  final TextEditingController controller;
  final String text;
  // final double rating;

  @override
  State<StarRatebar> createState() => _StarRatebarState();
}

class _StarRatebarState extends State<StarRatebar> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          widget.text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 5),
        RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star_rounded,
            color: Colors.amber,
          ),
          glow: true,
          glowRadius: 3,
          glowColor: Colors.amber,
          onRatingUpdate: (rating) {
            setState(() {
              // _rating = rating;
              widget.controller.text=rating.toString();
            });
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
