import 'package:car_rental/help/colors.dart';
import 'package:car_rental/help/help.dart';
import 'package:flutter/material.dart';

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
      body: Padding(
        padding: EdgeInsets.all(context.deviceWidth * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: context.deviceHeight * 0.05,
                  height: context.deviceWidth * 0.10,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
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
                    color: Colors.grey.shade200,
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
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(context.deviceWidth * 0.02),
              width: context.deviceHeight * 0.09,
              height: context.deviceWidth * 0.18,
              decoration: BoxDecoration(
                color: primaryColor(context),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(),
            ),
          ],
        ),
      ),
    );
  }
}
