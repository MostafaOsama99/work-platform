import 'package:flutter/material.dart';

class CircularCheckBox extends StatelessWidget {
  final Function(bool value) onChanged;
  final Color activeColor;
  final Color checkColor;

  final Color splashColor;
  final Color inactiveColor;
  final Color borderColor;
  final double borderWidth;
  final bool value;

  const CircularCheckBox(
      {Key key,
      this.onChanged,
      this.activeColor,
      this.checkColor = Colors.white,
      this.inactiveColor,
      this.value,
      this.splashColor,
      this.borderColor,
      this.borderWidth = 1.1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: Checkbox(
        value: value,
        side: BorderSide(
            color: borderColor ?? Theme.of(context).appBarTheme.color,
            width: borderWidth),
        onChanged: onChanged,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        checkColor: checkColor,
        activeColor: activeColor,
        overlayColor: MaterialStateProperty.all(splashColor),
        splashRadius: 18,
        fillColor: MaterialStateProperty.all(inactiveColor),
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
    );
  }
}
