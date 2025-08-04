import 'package:car_rental/help/boxtext.dart';
import 'package:car_rental/help/colors.dart';
import 'package:car_rental/help/help.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.deviceWidth * 0.04),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: context.deviceHeight * 0.05,
                      height: context.deviceWidth * 0.10,
                      decoration: BoxDecoration(
                        color: surfContainerColor(context),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Icon(Icons.place)),
                    ),
                    SizedBox(width: context.deviceWidth * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Your location", style: TextStyle(fontSize: 11)),
                          Text(
                            "Banjarnegara, Central Java",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      padding: EdgeInsets.all(context.deviceWidth * 0.02),
                      width: context.deviceHeight * 0.09,
                      height: context.deviceWidth * 0.18,
                      decoration: BoxDecoration(
                        color: surfContainerColor(context),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/image/man.png',
                          width: context.deviceWidth * 0.13,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.deviceHeight * 0.02),
                Container(
                  padding: EdgeInsets.all(context.deviceWidth * 0.02),
                  width: double.infinity,
                  height: context.deviceWidth * 0.45,
                  decoration: BoxDecoration(
                    color: primaryColor(context),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Select or search your favourite vehicle",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                            height: 1.15,
                            fontWeight: FontWeight.bold,
                            color: surfContainerColor(context),
                          ),
                        ),
                        SizedBox(height: context.deviceHeight * 0.02),
                        BoxText(label: "search", iconData: Icons.search),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: context.deviceHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Brands",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        height: 1.15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "View All",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.15,
                        fontWeight: FontWeight.bold,
                        color: primaryColor(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
