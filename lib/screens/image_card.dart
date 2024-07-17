import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final String description;

  ImageCard({
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Add a shadow to the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15).r, // Set rounded corner radius
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover, // Ensure the image covers the entire space
              height: 200.h, // Adjust the height as needed
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 16.spMin,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}