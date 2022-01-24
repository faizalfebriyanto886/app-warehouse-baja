import 'package:flutter/material.dart';
import '../static/color_app.dart';
import '../static/hexa_color.dart';

class AppButton {
  double roundedCorner = 6;

  mainButton({
    required String textButton,
    Color? textButtonColor,
    Color? buttonColor,
    required Function function,
  }) {
    return Center(
      child: ButtonTheme(
        minWidth: double.infinity,
        child: RaisedButton(
          elevation: 0,
          color: buttonColor == null ? ColorApp.mainColorApp : buttonColor,
          highlightElevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            textButton,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: textButtonColor == null ? Colors.white : textButtonColor,
              fontSize: 15,
            ),
          ),
          onPressed: () {
            function();
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(roundedCorner)),
        ),
      ),
    );
  }

  whiteButton({
    required String textButton,
    Color? textButtonColor,
    Color? buttonColor,
    required Function function,
  }) {
    return Center(
      child: ButtonTheme(
        minWidth: double.infinity,
        child: RaisedButton(
          elevation: 0,
          color: buttonColor ?? Colors.white,
          highlightElevation: 0,
          highlightColor: ColorApp.mainColorApp.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(textButton,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: textButtonColor == null
                      ? ColorApp.mainColorApp
                      : textButtonColor,
                  fontSize: 15)),
          onPressed: () {
            function();
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(roundedCorner)),
        ),
      ),
    );
  }

  redButton({
    required String textButton,
    required Function function,
  }) {
    return Center(
      child: ButtonTheme(
        minWidth: double.infinity,
        child: RaisedButton(
          elevation: 0,
          color: HexaColor("#F98080"),
          highlightElevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(textButton,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 15)),
          onPressed: () {
            function();
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(roundedCorner)),
        ),
      ),
    );
  }

  iconButton({
    required String textButton,
    Color? colorTextButton,
    Color? buttonColor,
    required Icon icon,
    required Function function,
  }) {
    return Center(
      child: ButtonTheme(
        minWidth: double.infinity,
        child: RaisedButton.icon(
          icon: icon,
          elevation: 0.1,
          highlightElevation: 1,
          color: buttonColor == null ? ColorApp.mainColorApp : buttonColor,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          label: Text(textButton,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: colorTextButton,
                  fontSize: 15)),
          onPressed: () {
            function();
          },
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(roundedCorner),
          ),
        ),
      ),
    );
  }
}
