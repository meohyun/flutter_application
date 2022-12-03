import 'package:flutter/material.dart';
import 'package:flutter_application/getx_example/controller.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';

class ScreenA extends StatefulWidget {
  @override
  State<ScreenA> createState() => _ScreenAState();
}

class _ScreenAState extends State<ScreenA> {
  int number = 0;
  //ConTroller _conTroller = Get.put(ConTroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            GetBuilder<ConTroller>(
                init: ConTroller(),
                builder: (_) => Text("${Get.find<ConTroller>().x}")),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.find<ConTroller>().plus();
                  },
                  icon: Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {
                    Get.find<ConTroller>().minus();
                  },
                  icon: Icon(Icons.remove),
                ),
              ],
            ),
            Container(
              color: number >= 5 ? Colors.deepPurple : Colors.deepOrange,
              height: 30,
            )
          ],
        ));
  }
}
