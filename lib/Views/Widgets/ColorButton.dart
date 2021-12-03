import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  const ColoredButton(
      {Key? key,
      this.enabled,
      this.long,
      this.size,
      @required this.text,
      @required this.callback})
      : super(key: key);
  final double? size;
  final bool? long;
  final String? text;
  final bool? enabled;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: enabled ?? true ? Colors.black : Colors.black45,
        elevation: 0,
        alignment: Alignment.center,
        minimumSize: Size(long ?? false ? double.infinity : 0, 0),
        textStyle: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
      onPressed: (enabled ?? true) ? callback : () {},
      child: Text(
        text ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: size ?? 18),
      ),
    );
  }
}
