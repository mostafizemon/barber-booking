import 'package:barber_booking/services/database.dart';
import 'package:flutter/material.dart';

import '../services/shared_preference.dart';
import '../widget/bookingdateandtime.dart';
import 'home.dart';

class Booking extends StatefulWidget {
  final String servicename;

  const Booking({super.key, required this.servicename});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  String? name, image, email;

  getdatafromsharedpreferences() async {
    name = await SharedPreferenceHelper().getUserName();
    image = await SharedPreferenceHelper().getUserImage();
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  getontheload() async {
    await getdatafromsharedpreferences();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  void _handleDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _handleTimeSelected(TimeOfDay time) {
    setState(() {
      selectedTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                      (Route<dynamic> route) => false);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Let's the\njourney begin",
                style: TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
              const SizedBox(height: 20),
              Image.asset(
                "assets/images/barbershopbanner.png",
                width: screensize.width,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 30),
              Text(
                widget.servicename,
                style: const TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const SizedBox(height: 20),
              Bookingdateandtime(
                screensize: screensize,
                context: context,
                onDateSelected: _handleDateSelected,
                onTimeSelected: _handleTimeSelected,
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: () async {
                  Map<String, dynamic> userBookingMap = {
                    "Service": widget.servicename,
                    "Date": selectedDate != null
                        ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                        : "Not selected",
                    "Time": selectedTime != null
                        ? selectedTime!.format(context)
                        : "Not selected",
                    "UserName": name,
                    "Image": image,
                    "Email": email
                  };
                  await DatabaseMethod()
                      .addUserBooking(userBookingMap)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Service has benn Booked Successfully!!!",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ),
                        (Route<dynamic> route) => false);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  width: screensize.width,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                      child: Text(
                    "Book Now",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
