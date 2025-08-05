import 'package:car_rental/core/utils/size_helper.dart';
import 'package:car_rental/widget/boxtext.dart';
import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<String> brand = [
    "assets/image/toyota.png",
    "assets/image/honda.png",
    "assets/image/hyundai.png",
    "assets/image/daihatsu.png",
    "assets/image/suzuki.png",
    "assets/image/mitsubishi.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.shortp(0.04)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: context.shortp(0.12),
                      height: context.shortp(0.12),
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
                        child: Icon(Icons.place, size: context.shortp(0.06)),
                      ),
                    ),
                    SizedBox(width: context.shortp(0.03)),
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
                    Container(
                      padding: EdgeInsets.all(context.widthp(0.02)),
                      width: context.shortp(0.20),
                      height: context.shortp(0.20),
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
                          width: context.shortp(0.16),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.shortp(0.04)),
                BoxText(label: "search cars", iconData: Icons.search),
                SizedBox(height: context.shortp(0.04)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Brands",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
