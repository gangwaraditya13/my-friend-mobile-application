import 'package:flutter/material.dart';

class RandomUserChat extends StatelessWidget {
  const RandomUserChat({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random User Chat"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Text("Coming Soon.."),
        ),
      ),
    );
  }
}
