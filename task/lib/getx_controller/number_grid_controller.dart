import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberGridController extends GetxController {
  RxList<int> gridNumbers = List.generate(100, (index) => index + 1).obs;
  RxSet<int> highlightedNumbers = <int>{}.obs;
  Rx<Color> highlightColor = Colors.grey.obs;
  RxString selectedRule = ''.obs;

  void applyRuleWithTransition(String rule, String color) {
    if (selectedRule.value == rule) {
      highlightedNumbers.clear();
      selectedRule.value = '';
      highlightColor.value = Colors.grey;
    } else {
      highlightedNumbers.clear();
      highlightColor.value = _getColorFromString(color);

      if (rule == 'Odd') {
        highlightedNumbers.addAll(gridNumbers.where((num) => num.isOdd));
      } else if (rule == 'Even') {
        highlightedNumbers.addAll(gridNumbers.where((num) => num.isEven));
      } else if (rule == 'Prime') {
        highlightedNumbers.addAll(gridNumbers.where(isPrime));
      } else if (rule == 'Fibonacci') {
        highlightedNumbers.addAll(gridNumbers.where(isFibonacci));
      }

      selectedRule.value = rule;
    }
  }

  bool isPrime(int num) {
    if (num < 2) return false;
    for (int i = 2; i <= num ~/ 2; i++) {
      if (num % i == 0) return false;
    }
    return true;
  }

  bool isFibonacci(int num) {
    int a = 0, b = 1;
    while (b < num) {
      int temp = b;
      b = a + b;
      a = temp;
    }
    return b == num || num == 0;
  }

  Color _getColorFromString(String color) {
    switch (color) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }
}
