import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:health_app/Screens/userProfile.dart';
import 'package:health_app/Components/calender.dart';
import 'package:health_app/Components/searchbar.dart';
import 'package:health_app/Components/bottomsheet.dart';
import 'package:health_app/Components/reusablecard.dart';
import 'package:health_app/Components/alertDialogue.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  final _searchController = TextEditingController();
  List<dynamic> services = [
    [
      'Emergency and Critical Care Services',
      'Emergency Department, Intensive Care Unit(ICU), Neonatal Intensive Care Unit(NICU), Surgical Emergency Services',
    ],
    [
      'Diagnostic and Laboratory Services',
      'Blood test, Urine test, Imaging, Pathology and history, Endoscopy and colonoscopy, ECG, EEG, echocardiography',
    ],
    [
      'Inpatient and Outpatient Services',
      'Inpatient care, Outpatient clinic, Day care and minor procedures',
    ],
    [
      'Specialist and General Care Services',
      'General medicine/ Internal medicine, Pediatics, Obstetrics and gynecology, Surgery Oncology, Cardiology, Neurology, Dermatology, Psychiatry and mental health services',
    ],
    [
      'Pharmacy Services',
      'Dispensing prescription medications, Counseling on drug use and side effects and supply vaccines and preventive medicine',
    ],
    [
      'Rehabilitation and Support Services',
      'Physiotherapy and occupational therapy, speech therapy, Nutritional counseling/dietetics, pain management clinics, counseling and psychological support',
    ],
    [
      'Maternal and child Health Services',
      'Antenatal and postnatal care, Family planning and reproductive health, Child immunizations and growth monitoring',
    ],
    [
      'Administrative and Support Services',
      'Patient registration and medical records, Health insurance processing, Social work support, Palliative and hospice care',
    ],
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Function to make phonecalls
  Future<void> callNumber(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Hello,', style: TextStyle(fontSize: 25)),
                            Text(
                              'Brandon Sagana',
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  showCustomBottomSheet(
                                    context,
                                    title: 'Notifications',
                                    body: Expanded(
                                      child: ListView.builder(
                                        itemCount: services.length,
                                        padding: EdgeInsets.only(top: 10),
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            contentPadding: EdgeInsets.all(10),
                                            title: Text('${services[index][0]}', style: TextStyle(fontWeight: FontWeight.bold),),
                                            subtitle: Text('${services[index][1]}'),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.notifications),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => UserProfile(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    'assets/images/avatar.png',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Search bar and filter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 50, width: 270, child: DoctorSearchBar()),
                  const SizedBox(width: 10),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text('Current Doctor on Duty'),
              const SizedBox(height: 10),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.asset('assets/images/doctor.png'),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Dr. Onyango Munie',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Orthopedic, Consultation(Foot and Ankle)',
                                ),
                                MaterialButton(
                                  color: Colors.blueAccent,
                                  onPressed: () {
                                    showReusableAlertDialog(
                                      context: context,
                                      title: 'Confirm',
                                      message:
                                          'Are you sure you want to book this appointment?',
                                    );
                                  },
                                  child: Text('Book Now'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CalendarDateContainer(date: DateTime.now()),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      callNumber('0741176650');
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.call, color: Colors.blueAccent),
                          Text('Call'),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Location Successfully pinged'),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(milliseconds: 700),
                        ),
                      );
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.location_pin, color: Colors.blueAccent),
                          Text('Ping'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Couresel slider
              Text('Available Services'),
              const SizedBox(height: 10),
              SizedBox(
                height: 225,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ReusableCard(
                      title: services[index][0],
                      body: services[index][1],
                      buttonText: 'Book Now',
                      onPressed: () {
                        showReusableAlertDialog(
                          context: context,
                          title: services[index][0],
                          message: services[index][1],
                        );
                      },
                    );
                  },
                  itemCount: services.length,
                ),
              ),

              //Buttons for booking an appointment
            ],
          ),
        ),
      ),
    );
  }
}
