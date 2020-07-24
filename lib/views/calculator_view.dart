import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/services.dart';

class CalculatorView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalculatorView();
}

class _CalculatorView extends State<CalculatorView> {
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String gender;
  String result = 'Ergebnis.....';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rechner"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: DropDownFormField(
                      titleText: 'Männlich / Weiblich',
                      hintText: 'Bitte Geschlecht wählen',
                      value: gender,
					  validator: (dynamic value){
						  if (value == null) {
							return 'Pflichtfeld!';
						  }
					  },
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                      dataSource: [
                        {
                          "display": "Männlich",
                          "value": "m",
                        },
                        {
                          "display": "Weiblich",
                          "value": "w",
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: ageController,
                      validator: (String value) {
                        String convertedValue = tryConvertValueToInt(value);
                        if (value.isEmpty) {
                          return 'Pflichtfeld!';
                        } else if (convertedValue == 'null') {
                          return 'Wert ist nicht gültig! (nur Ganzzahlen erlaubt!)';
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: 'Alter (z.B. 30)',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: weightController,
                      validator: (String value) {
                        String convertedValue = tryConvertValueToDouble(value);
                        if (value.isEmpty) {
                          return 'Pflichtfeld!';
                        } else if (convertedValue == 'null') {
                          return 'Wert ist nicht gültig! ( z.B. 80.5 )';
                        }
                      },
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        BlacklistingTextInputFormatter(
                            new RegExp('[\\,\\-\\+\\*\\:\\#|\\ ]'))
                      ],
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: 'Gewicht in kg (z.B 80.5)',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 50, left: 16),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Ihr optimaler Fettverbrennungspuls beträgt:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, -1.0),
                                blurRadius: 3.0,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 16, left: 16, right: 16),
                    child: TextField(
                      readOnly: true,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: result,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 140, bottom: 16, left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                width: 120,
                                child: Row(children: [
                                  Icon(Icons.navigate_before,
                                      color: Colors.white),
                                  Text('Zurück',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ]))),
                        RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              setState(() {
                                if (formKey.currentState.validate()) {
                                  result = calculateValues();
                                }
                              });
                            },
                            child: Container(
                                width: 120,
                                child: Row(children: [
                                  Text('Berechnen',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                  Icon(Icons.navigate_next,
                                      color: Colors.white),
                                ]))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String calculateValues() {
    double age = double.parse(ageController.text);
    double weight = double.parse(weightController.text);
    double genderValue;
    String result = '';

    if (gender == 'm') {
      genderValue = 214 - 0.5 * age - 0.11 * weight;
    } else {
      genderValue = 210 - 0.5 * age - 0.11 * weight;
    }
    double doubleResultMin = genderValue * 0.6;
    double doubleResultMax = genderValue * 0.7;
    int min = doubleResultMin.round();
    int max = doubleResultMax.round();
    result = 'Zwischen $min und $max';
    return result;
  }

  String tryConvertValueToDouble(String value) {
    double convertedValue = double.tryParse(value);
    return convertedValue.toString();
  }

  String tryConvertValueToInt(String value) {
    int convertedValue = int.tryParse(value);
    return convertedValue.toString();
  }
}
