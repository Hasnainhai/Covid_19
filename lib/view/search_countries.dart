import 'package:covid_19/services/states_services.dart';
import 'package:covid_19/view/country_details_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class SearchCountries extends StatefulWidget {
  const SearchCountries({super.key});

  @override
  State<SearchCountries> createState() => _SearchCountriesState();
}

class _SearchCountriesState extends State<SearchCountries> {
  // late final AnimationController _controller =
  //     AnimationController(duration: const Duration(seconds: 3), vsync: this)q
  //       ..repeat();
  final TextEditingController _tController = TextEditingController();
  @override
  void initState() {
    setState(() {
      // _controller;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
    const TickerCanceled();
  }

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const Gap(20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: _tController,
                decoration: InputDecoration(
                  hintText: 'Search a country',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            const Gap(20.0),
            Expanded(
              child: FutureBuilder(
                future: statesServices.countriesApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade900,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                height: 50.0,
                                width: 50.0,
                                color: Colors.grey.shade600,
                              ),
                              title: Container(
                                height: 10.0,
                                width: double.infinity,
                                color: Colors.grey.shade600,
                              ),
                              subtitle: Container(
                                height: 10.0,
                                width: 80.0,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                    // const Expanded(
                    //   flex: 1,
                    //   child: Center(
                    //     child: SpinKitFadingCircle(
                    //       color: Colors.white,
                    //       size: 50.0,
                    //     ),
                    //   ),
                    // );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name =
                            snapshot.data![index]['country'].toString();
                        if (_tController.text.isEmpty) {
                          return ListTile(
                            title: Text(
                                snapshot.data![index]['country'].toString()),
                            leading: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CountryDetails(
                                      img: snapshot.data![index]['countryInfo']
                                          ['flag'],
                                      name: name,
                                      cases: snapshot.data![index]['cases'],
                                      todayCases: snapshot.data![index]
                                          ['todayCases'],
                                      deaths: snapshot.data![index]['deaths'],
                                      todayDeaths: snapshot.data![index]
                                          ['todayDeaths'],
                                      recovered: snapshot.data![index]
                                          ['recovered'],
                                      todayRecovered: snapshot.data![index]
                                          ['todayRecovered'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]
                                          ['critical'],
                                    ),
                                  ),
                                );
                              },
                              child: Image(
                                height: 50.0,
                                width: 50.0,
                                image: NetworkImage(
                                  snapshot.data![index]['countryInfo']['flag'],
                                ),
                              ),
                            ),
                            subtitle:
                                Text(snapshot.data![index]['cases'].toString()),
                          );
                          /*
                          This is for search countries with name
                          */
                        } else if (name
                            .toLowerCase()
                            .contains(_tController.text.toLowerCase())) {
                          return ListTile(
                            title: Text(
                                snapshot.data![index]['country'].toString()),
                            leading: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CountryDetails(
                                      img: snapshot.data![index]['countryInfo']
                                          ['flag'],
                                      name: name,
                                      cases: snapshot.data![index]['cases'],
                                      todayCases: snapshot.data![index]
                                          ['todayCases'],
                                      deaths: snapshot.data![index]['deaths'],
                                      todayDeaths: snapshot.data![index]
                                          ['todayDeaths'],
                                      recovered: snapshot.data![index]
                                          ['recovered'],
                                      todayRecovered: snapshot.data![index]
                                          ['todayRecovered'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]
                                          ['critical'],
                                    ),
                                  ),
                                );
                              },
                              child: Image(
                                height: 50.0,
                                width: 50.0,
                                image: NetworkImage(
                                  snapshot.data![index]['countryInfo']['flag'],
                                ),
                              ),
                            ),
                            subtitle:
                                Text(snapshot.data![index]['cases'].toString()),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
