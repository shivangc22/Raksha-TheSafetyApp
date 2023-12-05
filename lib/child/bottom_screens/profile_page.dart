import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../child_login_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // or another loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Map<String, dynamic> userData =
                snapshot.data?.data() as Map<String, dynamic>;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Name: ${userData['name'] ?? 'N/A'}",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Email: ${userData['childEmail'] ?? 'N/A'}", // Assuming childEmail is the email field
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Phone: ${userData['phone'] ?? 'N/A'}",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        goTo(context, LoginScreen());
                      } on FirebaseAuthException catch (e) {
                        dialogueBox(context, e.toString());
                      }
                    },
                    child: Text(
                      "SIGN OUT",
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<DocumentSnapshot> getUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      return FirebaseFirestore.instance.collection('users').doc(uid).get();
    } else {
      throw Exception('User not authenticated');
    }
  }
}
