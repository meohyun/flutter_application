import 'package:flutter/material.dart';

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ScreenB"),
      ),
      body: Center(
        child: Column(
          children: [Text("스크린 b입니다.")],
        ),
      ),
    );
  }
}
