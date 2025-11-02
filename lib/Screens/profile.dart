import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_app/Database/lists.dart';
import 'package:health_app/Components/timeline.dart';
import 'package:health_app/Components/alertDialogue.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class Profile extends StatefulWidget {
  final String doctorName;
  final String description;

  const Profile({
    super.key,
    required this.doctorName,
    required this.description,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime; // Save picked time

  /// Save appointment to global list
  void _bookAppointment() {
    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a time")),
      );
      return;
    }
    
    Provider.of<DataBank1>(context, listen: false).bookedAppointments.add({
      "doctor": widget.doctorName,
      "description": widget.description,
      "date": "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
      "time": _selectedTime,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Appointment booked successfully!")),
    );

    Navigator.pop(context); // Go back after booking
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            /// Doctor card
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
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
                          widget.doctorName,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(child: Text(widget.description)),
                        MaterialButton(
                          color: Colors.blueAccent,
                          onPressed: () {
                            showReusableAlertDialog(
                              context: context,
                              title: 'Confirm',
                              message: 'Are you sure you want to book this appointment?',
                            );
                          },
                          child: const Text('Call'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// Date Picker
            const SizedBox(height: 10),
            const Text('Select Date', style: TextStyle(fontSize: 17)),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: EasyDateTimeLine(
                initialDate: _selectedDate,
                onDateChange: (date) {
                  setState(() => _selectedDate = date);
                },
                headerProps: const EasyHeaderProps(
                  monthPickerType: MonthPickerType.switcher,
                  dateFormatter: DateFormatter.fullDateDMY(),
                ),
                dayProps: const EasyDayProps(
                  dayStructure: DayStructure.dayStrDayNum,
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff3371FF), Color(0xff8426D6)],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// Time Picker
            const SizedBox(height: 10),
            const Text('Select Time', style: TextStyle(fontSize: 17)),
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TimeGridPicker(
                onTimeSelected: (time) {
                  setState(() {
                    _selectedTime = time;
                  });
                },
              ),
            ),

            /// Buttons
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple[100],
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.chat, color: Colors.blueAccent),
                  ),
                ),
                Container(
                  width: 250,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueAccent,
                  ),
                  child: MaterialButton(
                    onPressed: _bookAppointment,
                    color: Colors.blueAccent,
                    child: const Text('Book Appointment'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
