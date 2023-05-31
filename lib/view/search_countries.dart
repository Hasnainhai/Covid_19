import 'package:covid_19/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';

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
              child: TextFormField(
                onTap: () {
                  _tController;
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
                    return const Expanded(
                      flex: 1,
                      child: Center(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title:
                              Text(snapshot.data![index]['country'].toString()),
                          leading: Image(
                            height: 50.0,
                            width: 50.0,
                            image: NetworkImage(
                              snapshot.data![index]['countryInfo']['flag'],
                            ),
                          ),
                          subtitle:
                              Text(snapshot.data![index]['cases'].toString()),
                        );
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
