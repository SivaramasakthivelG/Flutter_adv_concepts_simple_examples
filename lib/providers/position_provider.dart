
import 'package:flutter/cupertino.dart';

class PositionProvider extends ChangeNotifier{

  double left = 300;
  double top = 600;

  void updatePosition(double dx, double dy,double height, double width){
      left += dx;
      top += dy;
    notifyListeners();
  }

}