import 'package:get/get_state_manager/get_state_manager.dart';

class ConTroller extends GetxController {
  int _x = 0;
  int get x => _x;

  void plus() {
    _x++;
    update();
  }

  void minus() {
    _x--;
    update();
  }
}
