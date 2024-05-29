import 'package:flutter/material.dart';

class CustomButtonView extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final Color? disableColor;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final double radius;
  final bool disable;
  final AlignmentGeometry alignment;
  final Widget? postfix;
  final TextStyle? textStyle;
  final VoidCallback? isForceClick;
  final double? borderWidth;
  final Color? borderColor;
  final double elevation;

  const CustomButtonView(this.text, this.onPressed,
      {super.key,
      this.color,
      this.textColor,
      this.disableColor,
      this.radius = 30,
      this.textStyle,
      this.disable = false,
      this.borderColor,
      this.borderWidth,
      this.alignment = Alignment.center,
      this.postfix,
      this.isForceClick,
      this.padding = const EdgeInsets.all(16),
      this.elevation = 0});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: MaterialButton(
        elevation: elevation,
        color: disable
            ? (disableColor ?? Colors.black.withOpacity(0.5))
            : (color ?? Colors.amber),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            side: BorderSide(
                color: borderColor ?? Colors.transparent,
                width: borderWidth ?? 0.0)),
        onPressed: isForceClick ?? (disable ? () {} : onPressed),
        child: Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: alignment,
                child: Text(
                  text,
                  maxLines: 1,
                  style: textStyle ??
                      TextStyle(
                          color: textColor ?? Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                ),
              ),
              postfix == null
                  ? const SizedBox()
                  : Container(
                      margin: const EdgeInsets.only(left: 12), child: postfix)
            ],
          ),
        ),
      ),
    );
  }
}
