// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CountryDetails extends StatefulWidget {
  CountryDetails(
      {super.key,
      required this.img,
      required this.name,
      required this.cases,
      required this.todayCases,
      required this.deaths,
      required this.todayDeaths,
      required this.recovered,
      required this.todayRecovered,
      required this.active,
      required this.critical});
  String img;
  String name;
  int cases,
      todayCases,
      deaths,
      todayDeaths,
      recovered,
      todayRecovered,
      active,
      critical;

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 50.0),
                    alignment: Alignment.center,
                    height: 150.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 50.0,
                        top: 50.0,
                      ),
                      alignment: Alignment.center,
                      height: 200.0,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.img),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Gap(40.0),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, top: 20.0, right: 0.0, bottom: 20.0),
                    child: Card(
                      child: Column(
                        children: [
                          ReuseWidget(
                            title: 'Active',
                            value: widget.active.toString(),
                          ),
                          ReuseWidget(
                              title: 'Critical',
                              value: double.parse(
                                widget.critical.toString(),
                              ).toString()),
                          ReuseWidget(
                              title: 'Recovered',
                              value: double.parse(widget.recovered.toString())
                                  .toString()),
                          ReuseWidget(
                              title: 'TodayRecovered',
                              value: widget.todayRecovered.toString()),
                          ReuseWidget(
                              title: 'Cases', value: widget.cases.toString()),
                          ReuseWidget(
                              title: 'TodayCases',
                              value: widget.todayCases.toString()),
                          ReuseWidget(
                              title: 'Deaths', value: widget.deaths.toString()),
                          ReuseWidget(
                              title: 'todayDeaths',
                              value: widget.todayDeaths.toString()),
                        ],
                      ),
                    ),
                  ),
                ],
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
