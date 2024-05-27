import 'package:flutter/material.dart';

typedef TitleBuilder<T> = Widget Function(T item);
typedef OnTap<T> = Function(T item);

class CustomListView<T> extends StatefulWidget {
  final List<T> data;
  final TitleBuilder<T> titleBuilder;
  final Icon? leadingIcon;
  final Icon? trailingIcon;
  final OnTap<T>? onTap;
  final double separatorHeight;
  final Color? borderColor;
  final double? borderRadius;
  final double? borderWidth;

  const CustomListView({
    super.key,
    required this.data,
    required this.titleBuilder,
    this.leadingIcon,
    this.trailingIcon,
    this.onTap,
    this.separatorHeight = 7,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
  });

  @override
  State<CustomListView<T>> createState() => _CustomListViewState<T>();
}

class _CustomListViewState<T> extends State<CustomListView<T>> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.data.length,
      itemBuilder: (_, index) {
        return ListTile(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: widget.borderColor ?? Colors.transparent,
                    width: widget.borderWidth ?? 0),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 0)),
            leading: widget.leadingIcon,
            title: widget.titleBuilder(widget.data[index]),
            onTap: () => setState(() {
                  widget.onTap!(widget.data[index]);
                }));
      },
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: widget.separatorHeight),
    );
  }
}
