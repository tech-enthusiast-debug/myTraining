import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'filter_sheet.dart';

class TrainingApp extends StatelessWidget {
  const TrainingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrainingHomePage(),
    );
  }
}

class TrainingHomePage extends StatelessWidget {
  final List<Map<String, String>> trainingData = [
    {
      "date": "Oct 11 - 13, 2019",
      "title": "Safe Scrum Master (4.6)",
      "time": "08:30 am - 12:30 pm",
      "location": "Convention Hall, Greater Des Moines",
      "status": "Filling Fast!",
      "speaker": "Helen Gribble",
    },
    {
      "date": "Nov 20 - 22, 2019",
      "title": "Advanced Scrum Master (5.0)",
      "time": "09:00 am - 01:00 pm",
      "location": "Hilton, Chicago",
      "status": "Early Bird!",
      "speaker": "John Smith",
    },
  ];

  final List<Map<String, String>> highlightsData = [
    {
      "title": "Safe Scrum Master",
      "location": "West Des Moines, IA",
      "date": "30 Oct - 31 Oct",
      "price": "\$825",
    },
    {
      "title": "Advanced Scrum Master",
      "location": "Chicago, IL",
      "date": "15 Nov - 16 Nov",
      "price": "\$750",
    },
  ];

   TrainingHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.red,
        title: const Text("Trainings", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Highlights carousel
          SizedBox(
            height: 250,
            child: Stack(children:[Container(height: 150,color:Colors.red ,),Positioned(
                child: _buildHighlightsCarousel())] ),
          ),

          // Filter button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                FilterBottomSheetDemo().showFilterBottomSheet(context);

              },
              icon: const Icon(Icons.filter_list),
              label: const Text("Filter"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.grey[300],
              ),
            ),
          ),

          // Training list
          Expanded(
            child: ListView.builder(
              itemCount: trainingData.length,
              itemBuilder: (context, index) {
                final training = trainingData[index];
                return _buildTrainingCard(training, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Highlights carousel
  Widget _buildHighlightsCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
      ),
      items: highlightsData.map((highlight) {
        return Builder(
          builder: (BuildContext context) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://via.placeholder.com/400x200"), // Placeholder image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          highlight['title']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${highlight['location']!}, ${highlight['date']!}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          highlight['price']!,
                          style: const TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  // Training card
  Widget _buildTrainingCard(Map<String, String> training, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4,
      child: Row(
        children: [
          // Left section
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(training['date']!, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(
                    training['title']!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(training['time']!),
                  Text(training['location']!),
                ],
              ),
            ),
          ),

          // Vertical divider
          Container(
            height: 100,
            width: 1,
            color: Colors.grey[300],
          ),

          // Right section
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      training['status']!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("Keynote Speaker: ${training['speaker']}"),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _showTrainingDetails(context, training);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Enroll Now"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Training details dialog
  void _showTrainingDetails(BuildContext context, Map<String, String> training) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(training['title']!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Date: ${training['date']!}"),
              Text("Time: ${training['time']!}"),
              Text("Location: ${training['location']!}"),
              Text("Keynote Speaker: ${training['speaker']}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
