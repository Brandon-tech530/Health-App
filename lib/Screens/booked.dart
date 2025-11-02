import 'package:flutter/material.dart';

class MyBookingsPage extends StatelessWidget {
  final List<Map<String, dynamic>> bookedServices; // e.g. [{'title': 'Dental Checkup', 'date': 'Oct 10, 2025'}]

  const MyBookingsPage({
    super.key,
    required this.bookedServices,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Appointments"),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
      ),
      body: bookedServices.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookedServices.length,
              itemBuilder: (context, index) {
                final service = bookedServices[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: const Icon(Icons.calendar_today, color: Colors.blueAccent),
                    title: Text(service['title'] ?? "Unknown Service"),
                    subtitle: Text("Appointment: ${service['date'] ?? "N/A"}"),
                    trailing: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("More details for ${service['title']}")),
                        );
                      },
                      child: const Text("Details"),
                    ),
                  ),
                );
              },
            )
          : _buildEmptyStateWithAds(),
    );
  }

  /// Show ads if no bookings exist
  Widget _buildEmptyStateWithAds() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.event_busy, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            "No upcoming appointments",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 30),

          /// Placeholder for Advertisements
          Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blueAccent, width: 2),
            ),
            child: const Center(
              child: Text(
                "Advertisement Space",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
