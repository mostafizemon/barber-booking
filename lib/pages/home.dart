import 'package:barber_booking/services/shared_preference.dart';
import 'package:barber_booking/widget/build_homeprofilesection.dart';
import 'package:barber_booking/widget/buildhomegrid.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? name,image;
  getdatafromsharedpreferences() async{
    name=await SharedPreferenceHelper().getUserName();
    image=await SharedPreferenceHelper().getUserImage();
    setState(() {
    });
  }
  getontheload() async{
    await getdatafromsharedpreferences();
    setState(() {
    });
  }
  @override
  void initState() {
    getontheload();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 12.0, right: 12.0,top: 10.00),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildHomeProfileSection().buildHomeProfileSection(name ?? "Anonymous"),
              const SizedBox(
                height: 15.0,
              ),
              const Divider(
                color: Colors.white,
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Text(
                "Services",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20.0,
              ),
              BuildHomeGrid().buildHomeGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
