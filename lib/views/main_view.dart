import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Optimaler Fettverbrennungspuls',
            style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              description,
              pic,
              description2,
              Container(
                  margin: const EdgeInsets.only(top: 85),
                  child: RaisedButton(
                      color: Colors.green,
                      onPressed: () {
                        Navigator.pushNamed(context, '/second');
                      },
                      child: Container(
                          width: 120,
                          child: Row(children: [
                            Text('Rechner',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            Icon(Icons.navigate_next, color: Colors.white),
                          ]))))
            ],
          ),
        ),
      ),
    );
  }

  Widget description = Container(
      margin: const EdgeInsets.only(top: 24.0, bottom: 12, left: 24, right: 24),
      padding: const EdgeInsets.all(12),
      color: Colors.green[100],
      child: Column(children: [
        Text(
          'Fettverbrennungspuls warum ist dieser so wichtig?',
          style: TextStyle(fontSize: 16, color: Colors.black),
          textAlign: TextAlign.left,
        ),
      ]));

  Widget pic = Container(
      margin: const EdgeInsets.only(top: 12.0, bottom: 12, left: 24, right: 24),
      child: Column(children: [Image.asset('lib/assets/images/logo.jpg')]));

  Widget description2 = Container(
      margin: const EdgeInsets.only(top: 12.0, bottom: 12, left: 24, right: 24),
      padding: const EdgeInsets.all(12),
      color: Colors.green[100],
      child: Column(children: [
        Text(
          'Für eine wirklich effektive Ausdauertrainingseinheit, die durchweg Fett verbrennt, ist es äußerst wichtig, dass Sie in Ihrer optimalen Trainingsherzfrequenz (im Fettstoffwechselbereich) zum Abnehmen trainieren.\nOptimales Fettstoffwechseltraining findet bei 60 bis 70 Prozent der maximalen Herzfrequenz statt, in der Sportwissenschaft wird dieser Bereich als Grundlagenausdauer oder als extensiver Dauerlauf bezeichnet.',
          style: TextStyle(color: Colors.black),
        ),
        Text('\n(Quelle: https://www.juhle.de/)',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ))
      ]));
}
