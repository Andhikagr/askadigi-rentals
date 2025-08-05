import 'package:car_rental/widget/boxtext.dart';
import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/help.dart';
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
                        boxShadow: [
                          BoxShadow(
                            color: inverseSurfaceColor(
                              context,
                            ).withValues(alpha: 0.15),
                            blurRadius: 6,
                            spreadRadius: 1,
                            offset: Offset(2, 4),
                          ),
                        ],
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
                      width: context.deviceWidth * 0.18,
                      height: context.deviceHeight * 0.09,
                      decoration: BoxDecoration(
                        color: surfContainerColor(context),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: inverseSurfaceColor(
                              context,
                            ).withValues(alpha: 0.15),
                            blurRadius: 6,
                            spreadRadius: 1,
                            offset: Offset(2, 4),
                          ),
                        ],
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

                SizedBox(height: context.deviceHeight * 0.03),
                BoxText(label: "search cars", iconData: Icons.search),
                SizedBox(height: context.deviceHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Brands",
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
