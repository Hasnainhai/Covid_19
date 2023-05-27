import 'package:covid_19/model/world_state_model.dart';
import 'package:covid_19/services/states_services.dart';
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
    with SingleTickerProviderStateMixin
    implements TickerProvider {
  List<Color> colorList = <Color>[Colors.green, Colors.blue, Colors.red];
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

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
                    if (snapshot.hasData) {
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              controller: _controller,
                              size: 50.0,
                            ),
                          ));
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              'Total':
                                  double.parse(snapshot.data!.cases.toString()),
                              'Recovered': double.parse(
                                  snapshot.data!.recovered.toString()),
                              'Death': double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                            chartType: ChartType.ring,
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            colorList: colorList,
                            animationDuration: const Duration(seconds: 3),
                            chartRadius: 150.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0,
                                top: 20.0,
                                right: 10.0,
                                bottom: 20.0),
                            child: Card(
                              child: Column(
                                children: [
                                  ReuseWidget(
                                      title: 'Cases',
                                      value: double.parse(
                                              snapshot.data!.cases.toString())
                                          .toString()),
                                  ReuseWidget(
                                      title: 'Active',
                                      value: double.parse(
                                              snapshot.data!.active.toString())
                                          .toString()),
                                  ReuseWidget(
                                      title: 'Deaths',
                                      value: double.parse(
                                              snapshot.data!.deaths.toString())
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                          const Gap(26.0),
                          Container(
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
                        ],
                      );
                    }
                    return const CircularProgressIndicator();
                  }),
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
