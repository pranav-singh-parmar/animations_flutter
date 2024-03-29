import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? titleString;
  final Widget? title;
  final bool? centerTitle;

  const CustomAppBar(
      {Key? key, this.titleString, this.title, this.centerTitle = true})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: widget.centerTitle,
      title: widget.title ?? Text(widget.titleString ?? ""),
    );
  }
}
