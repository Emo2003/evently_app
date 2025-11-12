import 'package:flutter/material.dart';

import '../../../core/resourse/ColorsManager.dart';

class CustomDropDownButton extends StatelessWidget {
  void Function(String?) onChange;
  String value1;
  String value2;
  String item1;
  String item2;
  String value;

  CustomDropDownButton({
    super.key,
    required this.onChange,
    required this.value,
    required this.value1,
    required this.value2,
    required this.item1,
    required this.item2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorsManager.blue),
      ),
      child: DropdownButton<String>(
        value: value,
        dropdownColor: ColorsManager.backgroundLight,
        borderRadius: BorderRadius.circular(20),
        padding: EdgeInsets.symmetric(horizontal: 10),
        underline: Container(),
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down, color: ColorsManager.blue, size: 35),
        items: [
          DropdownMenuItem(
            value: value1,
            child: Text(
              item1,
              style: Theme.of(context).dropdownMenuTheme.textStyle,
            ),
          ),
          DropdownMenuItem(
            value: value2,
            child: Text(
              item2,
              style: Theme.of(context).dropdownMenuTheme.textStyle,
            ),
          ),
        ],
        onChanged: onChange,
      ),
    );
  }
}
