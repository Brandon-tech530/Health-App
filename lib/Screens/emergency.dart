import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:url_launcher/url_launcher.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    // Function to make phonecalls
    Future<void> callNumber(String phoneNumber) async {
      final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw 'Could not launch $phoneNumber';
      }
    }

    TextEditingController description = TextEditingController();

    showdialogue(String title, String message) {
      return showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text(title),
              content: TextField(
                controller: description,
                maxLines: 3,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: message,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Send')
                ),
              ],
            ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[300], // Light pink background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              /// Big Emergency Button
              AvatarGlow(
                glowColor: Colors.blueAccent,
                child: Center(
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [Colors.blue.shade300, Colors.blue.shade700],
                        center: Alignment.center,
                        radius: 0.85,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withValues(),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.notifications_active,
                            size: 48,
                            color: Colors.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Emergency Alert",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),

              /// Emergency Options (Grid)
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildEmergencyCard(
                    Icons.local_hospital,
                    "Medical",
                    () => showdialogue("How can we assit", 'Describe your Emergency'),
                  ),
                  _buildEmergencyCard(
                    Icons.local_fire_department,
                    "Fire Force",
                    () => callNumber('0741176650'),
                  ),
                  _buildEmergencyCard(
                    Icons.medical_services,
                    "Ambulance",
                    () => callNumber('0741176650'),
                  ),
                  _buildEmergencyCard(
                    Icons.local_police,
                    "Police",
                    () => callNumber('0741176650'),
                  ),
                ],
              ),
              const Spacer(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable Card
  Widget _buildEmergencyCard(IconData icon, String title, Function call) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              call();
            },
            icon: Icon(icon, color: Colors.blueAccent, size: 40),
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
