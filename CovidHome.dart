import 'dart:convert';
import 'package:apis/Covid19_app/Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'CountriesLIst.dart';
import 'CovidModels.dart';


class CovidHome extends StatefulWidget {
  const CovidHome({super.key});

  @override
  State<CovidHome> createState() => _CovidHomeState();
}

class _CovidHomeState extends State<CovidHome> with TickerProviderStateMixin{

  late final animatedController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animatedController.dispose();
  }

  final colors = Colors.grey.shade900;


  final List colorss = <Color> [
    Colors.blue,
    Colors.red,
    Colors.green,
  ];

  Future <CovidModels> getApi () async {
    Apis apis = Apis();
    final response = await http.get(Uri.parse(apis.allData));
    final data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return CovidModels.fromJson(data);
    }
    return CovidModels.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors,
      body: SafeArea(
        bottom: true,
        child: FutureBuilder(
                  future: getApi(),
                  builder: (context, AsyncSnapshot<CovidModels> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Container(
                            height: 100,
                            width: 100,
                            child: SpinKitFadingCircle(
                                color: Colors.white,
                                size: 50.0,
                                controller: animatedController,
                              ),
                            ),
                      );
                    }else{
                      return Align(
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PieChart (
                                  dataMap: {
                                'Total' : double.parse(snapshot.data!.cases.toString()),
                                    'Recovered' : double.parse(snapshot.data!.recovered.toString()),
                                    'Deaths' : double.parse(snapshot.data!.deaths.toString()),
                                  },
                                  chartValuesOptions: ChartValuesOptions(

                                    showChartValuesInPercentage: true,
                                  ),
                                  chartRadius: 175,
                                  legendOptions: LegendOptions(
                                    legendTextStyle: TextStyle(
                                      fontFamily: 'poppins',
                                      color: Colors.white,
                                    )
                                  ),
                                  chartType: ChartType.ring,
                                  animationDuration: Duration(milliseconds: 1500),
                                ),
                                SizedBox(height: 40,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                  child: Card(
                                    color: Colors.grey.shade800,
                                    child: Column(
                                              children: [
                                                Reusable(title: 'Death', value: snapshot.data!.deaths.toString()),
                                                Reusable(title: 'Active', value: snapshot.data!.active.toString()),
                                                Reusable(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                              ],
                                            ),
                                  ),
                                ),
                                SizedBox(height: 30,),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesLIst()));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 15),
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: Center(
                                      child: Text('Track Countries', style: TextStyle(
                                          color: Colors.white,fontFamily: 'poppins')),
                                    ),
                                  ),
                                )
                              ],
                          ),
                        ),
                      );
                    }
                  }),
        ),
    );
  }}

class Reusable extends StatelessWidget {

 final String title;
 final  String value;

  Reusable({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(color: Colors.white,fontFamily: 'poppins'),),
              Text(value, style: TextStyle(color: Colors.white, fontFamily: 'poppins'),),
            ],
          ),
        ),
        SizedBox(height: 5,),
      ],
    );
  }
}
