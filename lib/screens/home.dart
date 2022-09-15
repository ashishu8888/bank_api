import 'package:bank_api/data/overview_data.dart';
import 'package:bank_api/data/performance.dart';
import 'package:bank_api/models/overview_model.dart';
import 'package:bank_api/models/performance_model.dart';
import 'package:bank_api/widgets/company_widgets.dart';
import 'package:bank_api/widgets/performance_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true;
  Overview o = Overview();
  List<Performance> pr = [];
  @override
  void initState() {
    getOverviewRep();
    getPerformanceRep();
    super.initState();
  }

  getOverviewRep() async {
    OverviewData overviewData = OverviewData();
    await overviewData.getOverview();
    o = overviewData.overV;
    setState(() {
      _loading = false;
    });
  }

  getPerformanceRep() async {
    PerformData pe = PerformData();
    await pe.getperformance();
    pr = pe.p.cast<Performance>();
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'bank share analysis',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: _loading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Overview',
                        style: GoogleFonts.arvo(
                            textStyle: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  CompEquityInf(o),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Performance',
                        style: GoogleFonts.arvo(
                            textStyle: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  PerfWidget(pr),
                ],
              ),
            ),
    );
  }
}
