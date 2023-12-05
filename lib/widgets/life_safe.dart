import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safetyapp/widgets/home_widgets/live_safe/BusStationCard.dart';
import 'package:safetyapp/widgets/home_widgets/live_safe/HospitalCard.dart';
import 'package:safetyapp/widgets/home_widgets/live_safe/PharmacyCard.dart';
import 'package:safetyapp/widgets/home_widgets/live_safe/PoliceStationCard.dart';
import 'package:safetyapp/widgets/home_widgets/live_safe/MetroStationCard.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({Key? key}) : super(key: key);

  static Future<void> openMap(String location) async {
    String googleUrl = 'https://www.google.com/maps/search/$location';
    final Uri _url = Uri.parse(googleUrl);
    try {
      await launchUrl(_url);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'something went wrong! call emergency number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceStationCard(onMapFunction: openMap),
          HospitalCard(onMapFunction: openMap),
          PharmacyCard(onMapFunction: openMap),
          BusStationCard(onMapFunction: openMap),
          MetroStationCard(onMapFunction: openMap)
        ],
      ),
    );
  }
}
