import 'package:flutter/material.dart';



class FilterBottomSheetDemo extends StatelessWidget {
  const FilterBottomSheetDemo({super.key});

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sort and Filters",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Content
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Menu (Dropdown Options)
                    SizedBox(
                      width: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMenuItem("Sort by", isSelected: true),
                          _buildMenuItem("Location"),
                          _buildMenuItem("Training Name"),
                          _buildMenuItem("Trainer"),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Right Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSearchField(),
                          const SizedBox(height: 16),
                          _buildLocationFilters(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(String title, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: isSelected
          ? BoxDecoration(
        border: const Border(
          left: BorderSide(color: Colors.red, width: 4),
        ),
        color: Colors.grey[200],
      )
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.red : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildLocationFilters() {
    final List<String> locations = [
      "West Des Moines",
      "Chicago, IL",
      "Phoenix, AZ",
      "Dallas, TX",
      "San Diego, CA",
      "San Francisco, CA",
      "New York, ZK",
    ];

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: locations
              .map((location) => CheckboxListTile(
            value: location == "West Des Moines",
            onChanged: (value) {},
            title: Text(location),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.red,
          ))
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Bottom Sheet UI"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => showFilterBottomSheet(context),
          child: const Text("Open Filter Bottom Sheet"),
        ),
      ),
    );
  }
}
