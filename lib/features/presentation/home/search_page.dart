// ignore_for_file: unnecessary_string_interpolations, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:green_cart/config/animations/animations.dart';
import 'package:green_cart/config/themes/colors.dart';
import 'package:green_cart/features/categories/fruits/fruits_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _searchResults = [];
  bool _isLoading = false;

  void _simulateSearch(String query) {
    if (query.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      final mockResults = List.generate(
        3,
        (i) => {
          'id': '$i',
          'name': '$query Result $i',
          'type': i % 2 == 0 ? 'Vegetables' : 'Vegetables',
          'typeName': i % 2 == 0 ? 'Fruits' : 'Fruits',
        },
      );

      setState(() {
        _searchResults = mockResults;
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildResults() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final item = _searchResults[index];
        return ListTile(
          title: Text(item['name'] ?? ''),
          subtitle: Text('${item['typeName']}'),
          onTap: () {
            Navigator.push(
              context,
              CustomPageRoute(
                child: FruitsScreen(),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: KColors.background,
        elevation: 0,
        surfaceTintColor: KColors.background,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: _simulateSearch,
                decoration: InputDecoration(
                  hintText: 'Search Here',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, size: 16, color: Colors.grey),
                    onPressed: () {
                      _controller.clear();
                      setState(() {
                        _searchResults = [];
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: _buildResults(),
      ),
    );
  }
}
