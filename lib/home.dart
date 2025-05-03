import 'package:flutter/material.dart';

class LocationModel {
  final String name;
  bool isFavorite;
  DateTime lastVisited;

  LocationModel({
    required this.name,
    required this.isFavorite,
    required this.lastVisited,
  });
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Sample data - in a real app, this would come from a database or API
  final List<LocationModel> _allLocations = [
    LocationModel(
      name: '14th of May Bridge Rd',
      isFavorite: true,
      lastVisited: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    LocationModel(
      name: 'Smouha Club',
      isFavorite: false,
      lastVisited: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    LocationModel(
      name: 'Alexandria Stadium',
      isFavorite: false,
      lastVisited: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    LocationModel(
      name: 'Montaza Palace',
      isFavorite: false,
      lastVisited: DateTime.now().subtract(const Duration(days: 1)),
    ),
    LocationModel(
      name: 'San Stefano Grand Plaza',
      isFavorite: false,
      lastVisited: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  // Get favorite locations
  List<LocationModel> get _favoriteLocations {
    return _allLocations.where((location) => location.isFavorite).toList();
  }

  // Get the three most recent locations
  List<LocationModel> get _recentLocations {
    final List<LocationModel> sortedLocations = List.from(_allLocations)
      ..sort((a, b) => b.lastVisited.compareTo(a.lastVisited));

    return sortedLocations.take(3).toList();
  }

  // Toggle favorite status for a location
  void _toggleFavorite(LocationModel location) {
    setState(() {
      location.isFavorite = !location.isFavorite;
    });
  }

  // Add a new location
  void _addNewLocation() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add New Location'),
            content: TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Enter location name',
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _allLocations.add(
                      LocationModel(
                        name: value,
                        isFavorite: true,
                        lastVisited: DateTime.now(),
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('CANCEL'),
              ),
              TextButton(
                onPressed: () {
                  // This will be handled by the onSubmitted of the TextField
                  Navigator.pop(context);
                },
                child: const Text('ADD'),
              ),
            ],
          ),
    );
  }

  // Handle searching for a location
  void _handleSearch() {
    if (_searchController.text.isEmpty) return;

    // Check if location already exists
    LocationModel? existingLocation = _allLocations.firstWhere(
      (loc) => loc.name.toLowerCase() == _searchController.text.toLowerCase(),
      orElse:
          () => LocationModel(
            name: _searchController.text,
            isFavorite: false,
            lastVisited: DateTime.now(),
          ),
    );

    setState(() {
      // If it's a new location, add it
      if (!_allLocations.contains(existingLocation)) {
        _allLocations.add(existingLocation);
      } else {
        // Update the last visited time for existing location
        int index = _allLocations.indexOf(existingLocation);
        _allLocations[index].lastVisited = DateTime.now();
      }
    });

    // Clear search
    _searchController.clear();
    _searchFocusNode.unfocus();

    // Show confirmation snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Location "${existingLocation.name}" searched'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'ADD TO FAVORITES',
          onPressed: () {
            setState(() {
              existingLocation.isFavorite = true;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset:
          true, // Ensures the screen adjusts for the keyboard
      body: SafeArea(
        child: SingleChildScrollView(
          // Makes the content scrollable
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar with enhanced UX
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.shade50,
                ),
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Where to?',
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                    suffixIcon:
                        _searchController.text.isNotEmpty
                            ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                              },
                            )
                            : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onChanged: (value) {
                    setState(() {}); // Rebuild to show/hide clear button
                  },
                  onSubmitted: (_) => _handleSearch(),
                ),
              ),
              const SizedBox(height: 12),

              // Find on Map Button - Enhanced style
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSearch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D47A1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Find on Map',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Favourites Section
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1.5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Favourites',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(Icons.add, size: 16),
                      ),
                      onPressed: _addNewLocation,
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(),
                      tooltip: 'Add to favorites',
                    ),
                  ],
                ),
              ),

              // Favourite Locations List
              if (_favoriteLocations.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'No favorite locations yet',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _favoriteLocations.length,
                  itemBuilder: (context, index) {
                    return _buildLocationItem(
                      _favoriteLocations[index],
                      onTap: () {
                        // Simulate selecting this location
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Selected: ${_favoriteLocations[index].name}',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    );
                  },
                ),

              const SizedBox(height: 12),

              // Recent Section
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1.5),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Recent',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),

              // Recent Locations - Limited to 3
              if (_recentLocations.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'No recent searches',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _recentLocations.length,
                  itemBuilder: (context, index) {
                    return _buildLocationItem(
                      _recentLocations[index],
                      onTap: () {
                        // Update last visited time when tapped
                        setState(() {
                          _recentLocations[index].lastVisited = DateTime.now();
                        });

                        // Simulate selecting this location
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Selected: ${_recentLocations[index].name}',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationItem(
    LocationModel location, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_on_outlined,
                size: 20,
                color: Colors.black54,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(location.name, style: const TextStyle(fontSize: 14)),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => _toggleFavorite(location),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    location.isFavorite ? Icons.star : Icons.star_border,
                    size: 20,
                    color: location.isFavorite ? Colors.amber : Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
