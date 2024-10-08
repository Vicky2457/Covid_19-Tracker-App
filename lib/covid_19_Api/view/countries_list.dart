import 'package:flutter/material.dart';
import 'package:covid_19/covid_19_Api/Services/states_services.dart';
import 'package:covid_19/covid_19_Api/view/detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  StatesServices statesServices = StatesServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 10, // Show 10 shimmer items
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: ListTile(
                            title: Container(height: 10, width: 80, color: Colors.white),
                            subtitle: Container(height: 10, width: 80, color: Colors.white),
                            leading: Container(height: 50, width: 50, color: Colors.white),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (searchController.text.isEmpty ||
                            name.toLowerCase().contains(searchController.text.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'],
                                    todayRecoverd: snapshot.data![index]['todayRecovered'] ?? 0,
                                    test: snapshot.data![index]['tests'] ?? 0,
                                    totalCases: snapshot.data![index]['cases'] ?? 0,
                                    totalDeaths: snapshot.data![index]['deaths'] ?? 0,
                                    totalRecoverd: snapshot.data![index]['recovered'] ?? 0,
                                    active: snapshot.data![index]['active'] ?? 0,
                                    critical: snapshot.data![index]['critical'] ?? 0,
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                              leading: Image.network(
                                snapshot.data![index]['countryInfo']['flag'],
                                height: 50,
                                width: 50,
                                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }

                  return Center(child: Text('No data available'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
