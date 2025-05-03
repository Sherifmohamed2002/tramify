import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String activeTab = 'tram';
  String selectedLine = 'line1';
  String? expandedStation;

  final List<Map<String, dynamic>> tramLines = [
    {'id': 'line1', 'name': 'Bakos Line (Line 1)'},
    {'id': 'line2', 'name': 'El-Nasr Line (Line 2)'},
  ];

  final Map<String, List<Map<String, dynamic>>> stations = {
    'line1': [
      {
        'id': 'raml1',
        'name': 'Raml Station',
        'times': ['06:00', '06:20', '06:40', '07:00', '12:00', '12:20', '18:00', '18:20'],
      },
      {
        'id': 'ibrahim1',
        'name': 'Gama\'a Ibrahim',
        'times': ['06:05', '06:25', '06:45', '07:05', '12:05', '12:25', '18:05', '18:25'],
      },
      {
        'id': 'hassan1',
        'name': 'Hassan Rasem / El-Azarita',
        'times': ['06:09', '06:29', '06:49', '07:09', '12:09', '12:29', '18:09', '18:29'],
      },
      {
        'id': 'mostafa1',
        'name': 'Mostafa Zidan',
        'times': ['06:12', '06:32', '06:52', '07:12', '12:12', '12:32', '18:12', '18:32'],
      },
      {
        'id': 'shaban1',
        'name': 'El-Shaban El-Muslimeen',
        'times': ['06:15', '06:35', '06:55', '07:15', '12:15', '12:35', '18:15', '18:35'],
      },
    ],
    'line2': [
      {
        'id': 'raml2',
        'name': 'Raml Station',
        'times': ['06:10', '06:30', '06:50', '07:10', '12:10', '12:30', '18:10', '18:30'],
      },
      {
        'id': 'ibrahim2',
        'name': 'Gama\'a Ibrahim',
        'times': ['06:15', '06:35', '06:55', '07:15', '12:15', '12:35', '18:15', '18:35'],
      },
      {
        'id': 'hassan2',
        'name': 'Hassan Rasem / El-Azarita',
        'times': ['06:19', '06:39', '06:59', '07:19', '12:19', '12:39', '18:19', '18:39'],
      },
      {
        'id': 'mostafa2',
        'name': 'Mostafa Zidan',
        'times': ['06:22', '06:42', '07:02', '07:22', '12:22', '12:42', '18:22', '18:42'],
      },
      {
        'id': 'shaban2',
        'name': 'El-Shaban El-Muslimeen',
        'times': ['06:25', '06:45', '07:05', '07:25', '12:25', '12:45', '18:25', '18:45'],
      },
    ],
  };

  void _handleStationTap(String stationId) {
    setState(() {
      if (expandedStation == stationId) {
        expandedStation = null;
      } else {
        expandedStation = stationId;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tabs
        Row(
          children: [
            _buildTab('Tram', 'tram'),
            _buildTab('Buses', 'buses'),
          ],
        ),

        // Content based on active tab
        Expanded(
          child: activeTab == 'tram' ? _buildTramContent() : _buildBusesContent(),
        ),
      ],
    );
  }

  Widget _buildTab(String title, String tabId) {
    final bool isActive = activeTab == tabId;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            activeTab = tabId;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF0A1744) : Colors.grey[300],
            border: Border(
              bottom: BorderSide(color: Colors.grey[400]!, width: 1.0),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTramContent() {
    return Column(
      children: [
        // Line Selector
        Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Line',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedLine,
                    items: tramLines.map((line) {
                      return DropdownMenuItem<String>(
                        value: line['id'],
                        child: Text(line['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedLine = value!;
                        expandedStation = null;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        // Stations List
        Expanded(
          child: ListView.builder(
            itemCount: stations[selectedLine]!.length,
            itemBuilder: (context, index) {
              final station = stations[selectedLine]![index];
              final isExpanded = expandedStation == station['id'];

              return Column(
                children: [
                  InkWell(
                    onTap: () => _handleStationTap(station['id']),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200]!,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.blue[700], size: 20.0),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Text(
                              station['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Icon(
                            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: Colors.grey[500],
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (isExpanded)
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.grey[50],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16.0, color: Colors.grey[600]),
                              const SizedBox(width: 6.0),
                              Text(
                                'Schedule Times',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1.8,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: station['times'].length,
                            itemBuilder: (context, timeIndex) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  station['times'][timeIndex],
                                  style: TextStyle(
                                    color: Colors.blue[800],
                                    fontSize: 13.0,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBusesContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_bus_outlined, size: 48.0, color: Colors.grey[400]),
          const SizedBox(height: 16.0),
          Text(
            'Bus schedules will be available soon',
            style: TextStyle(color: Colors.grey[500], fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
