import 'package:flutter/material.dart';

class AppBarUI {
  bool centerTitle = true;

  sliverAppBar({
    required String title,
    List<Widget>? actionButton,
  }) {
    return SliverAppBar(
      elevation: 1,
      automaticallyImplyLeading: true,
      forceElevated: false,
      snap: false,
      centerTitle: centerTitle,
      floating: false,
      pinned: true,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.5,
        ),
      ),
      actions: actionButton,
    );
  }

  sliverAppBarWithBackButton({
    required Function actionBackButton,
    required String title,
    List<Widget>? actionButton,
  }) {
    return SliverAppBar(
      elevation: 1,
      automaticallyImplyLeading: true,
      forceElevated: false,
      snap: false,
      centerTitle: centerTitle,
      floating: false,
      pinned: true,
      leading: Container(
        margin: EdgeInsets.only(left: 20.0),
        alignment: Alignment.centerLeft,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            actionBackButton();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.keyboard_backspace_rounded,
              size: 22,
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.5,
        ),
      ),
      actions: actionButton,
    );
  }

  appBar({
    required String title,
    List<Widget>? actionButton,
  }) {
    return AppBar(
      elevation: 0.8,
      automaticallyImplyLeading: true,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.5,
        ),
      ),
      actions: actionButton,
    );
  }

  appBarWithBackButton({
    required Function actionBackButton,
    required String title,
    List<Widget>? actionButton,
  }) {
    return AppBar(
      elevation: 0.8,
      automaticallyImplyLeading: true,
      centerTitle: centerTitle,
      leading: Container(
        margin: EdgeInsets.only(left: 20.0),
        alignment: Alignment.centerLeft,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            actionBackButton();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.keyboard_backspace_rounded,
              size: 22,
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.5,
        ),
      ),
      actions: actionButton,
    );
  }
}
