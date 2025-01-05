import 'package:flutter/material.dart';
import 'car.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _minPrice = 0;
  double _maxPrice = 99999;
  String? _selectedCategory;
  final List<String> _categories = ['Sedan', 'SUV', 'Truck', 'Sports'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Search'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                fetchCars(_minPrice, _maxPrice, _selectedCategory);
              });
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Min Price'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _minPrice = double.tryParse(value) ?? 0;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Max Price'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _maxPrice = double.tryParse(value) ?? 99999;
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Category'),
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
              items: _categories.map<DropdownMenuItem<String>>((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ShowCars(),
          ),
        ],
      ),
    );
  }
}