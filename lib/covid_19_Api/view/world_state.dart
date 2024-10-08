import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:covid_19/covid_19_Api/Services/states_services.dart';
import 'package:covid_19/covid_19_Api/model/world_states_model.dart';
import 'package:covid_19/covid_19_Api/view/countries_list.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color.fromARGB(255, 14, 156, 61),
    const Color.fromARGB(255, 143, 15, 4),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .01),
            FutureBuilder(
              future: statesServices.fetchWorldStatesRcords(),
              builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ));
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total":
                              double.parse(snapshot.data!.cases.toString()),
                          "recoverd":
                              double.parse(snapshot.data!.recovered.toString()),
                          "death":
                              double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        chartRadius: MediaQuery.of(context).size.width / 5.2,
                        legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left),
                        animationDuration: const Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: colorList,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.01),
                        child: Card(
                          child: Column(
                            children: [
                              Reusable(
                                title: 'Total',
                                value: snapshot.data!.cases.toString(),
                              ),
                              Reusable(
                                title: 'Deaths',
                                value: snapshot.data!.deaths.toString(),
                              ),
                              Reusable(
                                title: 'Recovered',
                                value: snapshot.data!.recovered.toString(),
                              ),
                              Reusable(
                                title: 'Active',
                                value: snapshot.data!.active.toString(),
                              ),
                              Reusable(
                                title: 'Critical',
                                value: snapshot.data!.critical.toString(),
                              ),
                              Reusable(
                                title: 'Today Deaths',
                                value: snapshot.data!.todayDeaths.toString(),
                              ),
                              Reusable(
                                title: 'Todays Recoverd',
                                value: snapshot.data!.todayRecovered.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:(){
Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesListScreen())) ;
                        } ,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.green.shade400,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text('Track Countries'),
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}

class Reusable extends StatelessWidget {
  String title, value;
  Reusable({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}
