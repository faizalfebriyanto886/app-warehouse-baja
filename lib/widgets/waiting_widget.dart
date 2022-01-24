import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sologwarehouseapp/static/color_app.dart';

class WaitingWidget extends StatelessWidget {
  final String? message;
  final double? marginTop;

  const WaitingWidget({Key? key, this.message, this.marginTop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: marginTop == null ? 50 : marginTop!,
        left: 60,
        right: 60,
      ),
      child: Text(
        message == null ? "Sedang memuat data" : message!,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Colors.grey[400], fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class WaitingWidgetV2 extends StatelessWidget {
  final Color? color;

  const WaitingWidgetV2({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            child: LoadingIndicator(
              indicatorType: Indicator.orbit,
              color: color == null ? Colors.grey[300] : ColorApp.mainColorApp,
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  final String? message;
  final IconData? icon;
  final Color? color;
  final double? marginTop;

  const EmptyWidget(
      {Key? key, this.message, this.icon, this.color, this.marginTop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      margin: EdgeInsets.only(
          top: marginTop == null ? 50 : marginTop!, left: 60, right: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor:
                  color == null ? Colors.grey[200] : color!.withOpacity(0.4),
              radius: 30,
              child: Icon(
                icon == null ? Icons.access_time_rounded : icon,
                color: color == null ? Colors.grey[400] : color,
                size: 35,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              message == null ? "Tidak ada data yang tersedia" : message!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
