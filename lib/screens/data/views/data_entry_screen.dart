import 'package:flutter/material.dart';

import 'package:my_windows_app/constants.dart';
import 'package:my_windows_app/route/route_constants.dart';

class DataEntryScreen extends StatefulWidget {
  const DataEntryScreen({super.key});

  @override
  DataEntryScreenState createState() => DataEntryScreenState();
}

class DataEntryScreenState extends State<DataEntryScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _date;
  TimeOfDay? _time;
  String _casValue = 'Own';
  String _watchListValue = 'Yes';

  List<String> _incidentTypes = [
    'Fire Raid',
    'IED Attk',
    'Abduction',
    'Tgy Killing',
    'Ambush',
    'Extortion',
    'SB Attk',
    'Polioi Incidents',
    'Robberies',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double textWidth = 200;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/full_color.png',
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                  ),
                  width: width,
                  height: height,
                ),
                Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Text(
                        "Data Entry",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 217, 102),
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.8),
                              offset: const Offset(2, 2),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        // Items align start
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                _buildRow(
                                  label: 'Date:',
                                  child: TextFormField(
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10.0),
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (pickedDate != null) {
                                        setState(() {
                                          _date = pickedDate;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildRow(
                                  label: 'Time:',
                                  child: TextFormField(
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10.0),
                                    ),
                                    onTap: () async {
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (pickedTime != null) {
                                        setState(() {
                                          _time = pickedTime;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildRow(
                                  label: 'Organization:',
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildRow(
                                  label: 'Sub Organization:',
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildRow(
                                  label: 'Name:',
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildRow(
                                  label: 'Comds:',
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildRow(
                                  label: 'Brief/Description:',
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildRow(
                                  label: 'Upload Photo:',
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Implement file picker logic here
                                    },
                                    child: const Text('Select File'),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Type of Incidents',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: _incidentTypes.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Checkbox(
                                            value: false,
                                            onChanged: (value) {}),
                                        Text(_incidentTypes[index]),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 50),
                          Expanded(
                            child: Column(
                              children: [
                                _buildRow(
                                  label: 'Area:',
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildRow(
                                  label: 'Cas:',
                                  child: DropdownButton<String>(
                                    value: _casValue,
                                    items: <String>['Own', 'TS']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      if (value != null) {
                                        setState(() {
                                          _casValue = value;
                                        });
                                      }
                                    },
                                    dropdownColor: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildRow(
                                  label: 'Martyped:',
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Injured
                                _buildRow(
                                  label: 'Injured:',
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Killed
                                _buildRow(
                                  label: 'Killed:',
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Latitute, Longitude
                                _buildRow(
                                  label: 'Latitute:',
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildRow(
                                  label: 'Longitude:',
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Give Case ID #
                                _buildRow(
                                  label: 'Give Case ID #:',
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Watch List // Yes or No
                                _buildRow(
                                  label: 'Watch List:',
                                  child: DropdownButton<String>(
                                    value: _watchListValue,
                                    items: <String>['Yes', 'No']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      if (value != null) {
                                        setState(() {
                                          _casValue = value;
                                        });
                                      }
                                    },
                                    dropdownColor: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 50),
                                // Import GOE .kmz button
                                ElevatedButton(
                                  onPressed: () {
                                    // Implement file picker logic here
                                  },
                                  child: const Text('Import GOE .kmz'),
                                ),
                                const SizedBox(height: 10),
                                // Explore Google Eearth
                                ElevatedButton(
                                  onPressed: () {
                                    // Implement file picker logic here
                                  },
                                  child: const Text('Explore Google Earth'),
                                ),
                                const SizedBox(height: 10),
                                // Low Down Button
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, mainScreenRoute);
                                  },
                                  child: const Text('Low Down'),
                                ),
                                const SizedBox(height: 10),
                                // Save Data
                                ElevatedButton(
                                  onPressed: () {
                                    // Implement save data logic here
                                  },
                                  child: const Text('Save Data'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow({required String label, required Widget child}) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}
