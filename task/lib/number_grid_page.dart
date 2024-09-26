import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/getx_controller/number_grid_controller.dart';

final NumberGridController controller = Get.put(NumberGridController());

class NumberGridScreen extends StatelessWidget {
  const NumberGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Number Pattern Switcher',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
          toolbarHeight: 75,
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Select a button to apply the appropriate number rule.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontFamily: 'Arial',
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildActionChips(),
            const SizedBox(height: 50),
            Obx(() => _buildGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChips() {
    return Wrap(
      spacing: 10.0,
      alignment: WrapAlignment.center,
      children: [
        _buildChip('Odd', 'red', Icons.filter_1),
        _buildChip('Even', 'blue', Icons.filter_2),
        _buildChip('Prime', 'green', Icons.filter_3),
        _buildChip('Fibonacci', 'orange', Icons.filter_4),
      ],
    );
  }

  // Helper function to build each chip
  Widget _buildChip(String rule, String color, IconData icon) {
    return Obx(() {
      bool isSelected = controller.selectedRule.value == rule;
      return ActionChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) Icon(icon, color: Colors.white, size: 16),
            SizedBox(width: isSelected ? 6 : 0),
            Text(
              rule,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor:
            isSelected ? controller.highlightColor.value : Colors.blueGrey,
        onPressed: () => controller.applyRuleWithTransition(rule, color),
      );
    });
  }

  Widget _buildGrid() {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: controller.gridNumbers.length,
        itemBuilder: (BuildContext context, int index) {
          final number = controller.gridNumbers[index];
          return Obx(() => _buildGridTile(number));
        },
      ),
    );
  }

  Widget _buildGridTile(int number) {
    bool isHighlighted = controller.highlightedNumbers.contains(number);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastEaseInToSlowEaseOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isHighlighted
              ? [
                  controller.highlightColor.value.withOpacity(0.7),
                  controller.highlightColor.value
                ]
              : [
                  Colors.grey[300] as Color,
                  Colors.grey[400] as Color,
                ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'Courier',
            color: isHighlighted ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
