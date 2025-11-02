import 'package:flutter/material.dart';
import 'package:health_app/Screens/profile.dart';

/// Simple Doctor model
class Doctor {
  final String name;
  final String specialty;
  final String details;

  Doctor({
    required this.name,
    required this.specialty,
    required this.details,
  });

  @override
  String toString() => name; // needed for Autocomplete
}

/// Search Bar with Dropdown Autocomplete
class DoctorSearchBar extends StatelessWidget {
  DoctorSearchBar({super.key});

  final TextEditingController _controller = TextEditingController();

  // Dummy doctor list
  final List<Doctor> doctors = [
    Doctor(
      name: "Dr. John Doe",
      specialty: "Cardiologist",
      details: "10 years of experience in heart disease treatment.",
    ),
    Doctor(
      name: "Dr. Jane Smith",
      specialty: "Dermatologist",
      details: "Specialist in skin conditions and allergy care.",
    ),
    Doctor(
      name: "Dr. Michael Brown",
      specialty: "Neurologist",
      details: "Expert in brain and nervous system disorders.",
    ),
    Doctor(
      name: "Dr. Emily White",
      specialty: "Pediatrician",
      details: "Provides care for infants and young children.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Doctor>(
      optionsBuilder: (TextEditingValue value) {
        if (value.text.isEmpty) {
          return doctors; // show all doctors when empty
        }
        return doctors.where((doctor) =>
            doctor.name.toLowerCase().contains(value.text.toLowerCase()) ||
            doctor.specialty.toLowerCase().contains(value.text.toLowerCase()));
      },
      displayStringForOption: (Doctor doctor) => doctor.name,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        _controller.value = textEditingController.value; // sync controller
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: 'Search for Doctor...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final Doctor option = options.elementAt(index);
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(option.name),
                    subtitle: Text(option.specialty),
                    onTap: () => onSelected(option),
                  );
                },
              ),
            ),
          ),
        );
      },
      onSelected: (Doctor doctor) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Profile(doctorName: doctor.name, description: doctor.details),
          ),
        );
      },
    );
  }
}

/// Doctor Details Page
class DoctorDetailsPage extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailsPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(doctor.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(doctor.name,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(doctor.specialty,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.blue)),
            const SizedBox(height: 16),
            Text(doctor.details,
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
