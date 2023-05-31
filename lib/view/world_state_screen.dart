// ignore_for_file: must_be_immutable

import 'package:covid_19/model/world_state_model.dart';
import 'package:covid_19/services/states_services.dart';
import 'package:covid_19/view/search_countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldState extends StatefulWidget {
  const WorldState({super.key});

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState>
    with SingleTickerProviderStateMixin {
  List<Color> colorList = <Color>[Colors.green, Colors.blue, Colors.red];
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void initState() {
    setState(() {
      _controller;
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              FutureBuilder(
                future: statesServices.fetchWorldStateData(),
                builder: (context, AsyncSnapshot<worldStateModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: Center(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          controller: _controller,
                          size: 50.0,
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Active':
                                double.parse(snapshot.data!.active.toString())
                                    .toDouble(),
                            'Death':
                                double.parse(snapshot.data!.deaths.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered.toString()),
                            'Critical': double.parse(
                                snapshot.data!.critical.toString()),
                            'Total':
                                double.parse(snapshot.data!.cases.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: false,
                            decimalPlaces: 1,
                          ),
                          chartType: ChartType.ring,
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                            showLegends: true,
                          ),
                          colorList: colorList,
                          animationDuration: const Duration(seconds: 3),
                          chartRadius: 150.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 20.0, right: 10.0, bottom: 20.0),
                          child: Card(
                            child: Column(
                              children: [
                                ReuseWidget(
                                    title: 'Active',
                                    value: snapshot.data!.active.toString()),
                                ReuseWidget(
                                    title: 'Death',
                                    value: double.parse(
                                            snapshot.data!.deaths.toString())
                                        .toString()),
                                ReuseWidget(
                                    title: 'Recovered',
                                    value: double.parse(
                                            snapshot.data!.recovered.toString())
                                        .toString()),
                                ReuseWidget(
                                    title: 'Critical',
                                    value: snapshot.data!.critical.toString()),
                                ReuseWidget(
                                    title: 'Total',
                                    value: snapshot.data!.cases.toString()),
                              ],
                            ),
                          ),
                        ),
                        const Gap(26.0),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SearchCountries()));
                          },
                          child: Container(
                            height: 46.0,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.green,
                            ),
                            child: const Center(
                              child: Text('Take Countries'),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseWidget extends StatelessWidget {
  ReuseWidget({super.key, required this.title, required this.value});
  String title, value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
