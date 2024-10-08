import 'package:flutter/material.dart';
import 'package:covid_19/covid_19_Api/view/world_state.dart';

class DetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final int totalCases;
  final int totalDeaths;
  final int totalRecoverd;
  final int active;
  final int critical;
  final int todayRecoverd;
  final int test;

  const DetailScreen({super.key, 
    required this.name,
    required this.image,
    required this.todayRecoverd,
    required this.totalCases,
    required this.test,
    required this.totalDeaths,
    required this.totalRecoverd,
    required this.active,
    required this.critical,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .02),
                        Reusable(
                            title: 'Cases',
                            value: widget.totalCases.toString()),
                        Reusable(
                            title: 'Recovered',
                            value: widget.totalRecoverd.toString()),
                        Reusable(
                            title: 'Deaths',
                            value: widget.totalDeaths.toString()),
                        Reusable(
                            title: 'Critical',
                            value: widget.critical.toString()),
                        Reusable(
                            title: 'Today Recovered',
                            value: widget.todayRecoverd.toString()),
                        Reusable(
                            title: 'Active', value: widget.active.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
