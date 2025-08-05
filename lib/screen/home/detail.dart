import 'dart:convert';
import 'package:car_rental/model/car_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  List<CarModel> cars = [];

  Future<void> loadData() async {
    final String response = await rootBundle.loadString(
      'assets/data/carsrent.json',
    );
    final List<dynamic> data = json.decode(response);
    setState(() {
      cars = data.map((json) => CarModel.fromJson(json)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Semua Mobil')),
      body: cars.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(
                      car.image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text('${car.brand} ${car.model}'),
                    subtitle: Text(
                      '${car.year} - ${car.transmission} - ${car.pricePerDay} / hari',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
