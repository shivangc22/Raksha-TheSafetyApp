import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:vibration/vibration.dart';

class Fakecall extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _FakecallState createState() => _FakecallState();
}

class _FakecallState extends State<Fakecall>
    with SingleTickerProviderStateMixin {
  bool isRinging = false;
  late AnimationController _animationController;

  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  void startFakeCall() async {
    setState(() {
      isRinging = true;
    });

    // Play ringtone
    FlutterRingtonePlayer.playRingtone();

    // Simulate call for 10 seconds (adjust duration as needed)
    await Future.delayed(const Duration(seconds: 10));

    // Stop ringtone
    FlutterRingtonePlayer.stop();

    setState(() {
      isRinging = false;
    });
  }

  void _showFakeCallDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Align caller name to the top
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    Text(
                      _generateRandomName(),
                      style: const TextStyle(
                        fontSize: 30, // Increased font size for the caller name
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "+91823457890",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.of(context).pop();
                            startFakeCall();
                            _callNumber('98765432110');

                            if (await Vibration.hasCustomVibrationsSupport() ??
                                false) {
                              Vibration.vibrate(duration: 500);
                            }
                          },
                          child: AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return const CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 35,
                                child: IconButton(
                                  icon: Icon(Icons.call,
                                      size: 30), // Increased icon size
                                  onPressed: null,
                                ),
                              );
                            },
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 35,
                          child: IconButton(
                            icon: const Icon(Icons.call_end,
                                size: 30), // Increased icon size
                            onPressed: () {
                              Navigator.of(context).pop();
                              FlutterRingtonePlayer.stop();
                              setState(() {
                                isRinging = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _generateRandomName() {
    final List<String> names = [
      'Mom',
      'Dad',
      'Bestie',
      'Shriya',
      'Tarun',
      'Taruna',
      'Shivang'
    ]; // Add more names if needed
    return names[DateTime.now().millisecondsSinceEpoch % names.length];
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          onTap: () {
            startFakeCall();
            _showFakeCallDialog();
          },
          child: Container(
            height: 180,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFD8080),
                  Color(0xFFFB8580),
                  Color(0xFFFBD079),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white.withOpacity(0.5),
                    child: Image.asset('assets/fakecall.png'),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Fake Call",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
                        ),
                        Text(
                          "Need a reason to leave?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
