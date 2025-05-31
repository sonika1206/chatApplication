import 'package:flutter/material.dart';

class ErrorMsg extends StatelessWidget {
  final String message;
  final String? imagePath;

  const ErrorMsg({Key? key, required this.message, this.imagePath})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 1000,
        color: Colors.grey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),
            Image.network(
              "https://i.pinimg.com/originals/7c/1d/ab/7c1dab157f34e603487b5d0b057da448.gif",
            ),
            //Icon(Icons.chat_bubble_outline, size: 100, color: Colors.grey[400]),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
