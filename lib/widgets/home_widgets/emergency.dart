import 'package:flutter/material.dart';
import 'package:safetyapp/widgets/home_widgets/emergencies/Fakecall.dart';
import 'emergencies/AmbulanceEmergency.dart';
import 'emergencies/GeneralEmergency.dart';
import 'emergencies/FirebrigadeEmergency.dart';
import 'emergencies/PoliceEmergency.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Fakecall(),
          GeneralEmergency(),
          PoliceEmergency(),
          AmbulanceEmergency(),
          FirebrigadeEmergency(),
        ],
      ),
    );
  }
}
