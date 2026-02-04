import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wise_players/model/movie/media_item.dart';


class MediaCard extends ConsumerStatefulWidget {
  final MediaItem item;
  final bool isTV;
  final bool isMobile;

  const MediaCard({
    super.key,
    required this.item,
    required this.isTV,
    required this.isMobile,
  });

  @override
  ConsumerState<MediaCard> createState() => _MediaCardState();
}

class _MediaCardState extends ConsumerState<MediaCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isFavorite = ref.watch(favoritesProvider).contains(widget.item.id);

    return Focus(
      child: Builder(
        builder: (context) {
          final isFocused = Focus.of(context).hasFocus;
          return MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: GestureDetector(
              onTap: () => _onCardTapped(context),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: (isFocused || _isHovered)
                      ? [
                    BoxShadow(
                      color: Color(0xFFE74C3C).withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ]
                      : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Movie poster
                      _buildPosterImage(isFocused || _isHovered),

                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.8),
                            ],
                            stops: [0.5, 1.0],
                          ),
                        ),
                      ),

                      // Content overlay
                      Positioned(
                        left: 8,
                        right: 8,
                        bottom: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Title
                            Text(
                              widget.item.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.isTV
                                    ? 13
                                    : (widget.isMobile ? 11 : 12),
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      // Top badges
                      Positioned(
                        top: 8,
                        left: 8,
                        right: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Rating badge
                            if (widget.item.rating > 0)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFF39C12),
                                      size: widget.isTV ? 14 : 12,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      widget.item.rating.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: widget.isTV ? 11 : 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            // Favorite button
                            GestureDetector(
                              onTap: () => _toggleFavorite(),
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite
                                      ? Color(0xFFE74C3C)
                                      : Colors.white,
                                  size: widget.isTV ? 18 : 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Quality badge
                      if (widget.item.quality != null)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF27AE60),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              widget.item.quality!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.isTV ? 10 : 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                      // Focus border
                      if (isFocused)
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFE74C3C),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPosterImage(bool isHighlighted) {
    return AnimatedScale(
      scale: isHighlighted ? 1.05 : 1.0,
      duration: Duration(milliseconds: 200),
      child: widget.item.imageUrl.isNotEmpty
          ? Image.network(
        widget.item.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildPlaceholder();
        },
      )
          : _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Color(0xFF34495E),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.movie_outlined,
              size: widget.isTV ? 48 : (widget.isMobile ? 32 : 40),
              color: Colors.white24,
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.item.title,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: widget.isTV ? 12 : (widget.isMobile ? 10 : 11),
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFavorite() {
    ref.read(favoritesProvider.notifier).toggleFavorite(widget.item.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ref.read(favoritesProvider).contains(widget.item.id)
              ? 'Added to favorites'
              : 'Removed from favorites',
        ),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xFF27AE60),
      ),
    );
  }

  void _onCardTapped(BuildContext context) {
    // Navigate to detail screen
    showDialog(
      context: context,
      builder: (context) => _buildDetailDialog(context),
    );
  }

  Widget _buildDetailDialog(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFF2C3E50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: widget.isTV ? 600 : (widget.isMobile ? 300 : 450),
        padding: EdgeInsets.all(widget.isTV ? 32 : 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: widget.isTV ? 28 : (widget.isMobile ? 20 : 24),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              widget.item.description,
              style: TextStyle(
                color: Colors.white70,
                fontSize: widget.isTV ? 16 : (widget.isMobile ? 13 : 14),
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Play media
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE74C3C),
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    'Play',
                    style: TextStyle(
                      fontSize: widget.isTV ? 16 : 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: widget.isTV ? 16 : 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MediaGrid extends ConsumerStatefulWidget {
  final List<MediaItem> items;
  final bool isTV;
  final bool isMobile;
  final ScrollController scrollController;

  const MediaGrid({
    Key? key,
    required this.items,
    required this.isTV,
    required this.isMobile,
    required this.scrollController,
  });

  @override
  ConsumerState<MediaGrid> createState() => _MediaGridState();
}

class _MediaGridState extends ConsumerState<MediaGrid> {
  @override
  Widget build(BuildContext context) {
    // Calculate grid dimensions based on screen size
    final crossAxisCount = widget.isTV ? 6 : (widget.isMobile ? 2 : 4);
    final childAspectRatio = widget.isTV ? 0.68 : (widget.isMobile ? 0.65 : 0.67);

    return Container(
      color: Color(0xFF1E1E2E),
      child: GridView.builder(
        controller: widget.scrollController,
        padding: EdgeInsets.all(widget.isTV ? 20 : (widget.isMobile ? 12 : 16)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: widget.isTV ? 16 : (widget.isMobile ? 10 : 12),
          mainAxisSpacing: widget.isTV ? 20 : (widget.isMobile ? 12 : 16),
        ),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return MediaCard(
            item: widget.items[index],
            isTV: widget.isTV,
            isMobile: widget.isMobile,
          );
        },
      ),
    );
  }
}


class CategorySidebar extends StatelessWidget {
  final List<Category> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final bool isTV;
  final bool isMobile;

  const CategorySidebar({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.isTV,
    required this.isMobile,
  }) : super(key: key);

  Color _getCategoryColor(CategoryColor color) {
    switch (color) {
      case CategoryColor.yellow:
        return Color(0xFFF39C12);
      case CategoryColor.orange:
        return Color(0xFFE67E22);
      case CategoryColor.blue:
        return Color(0xFF3498DB);
      case CategoryColor.purple:
        return Color(0xFF9B59B6);
      case CategoryColor.green:
        return Color(0xFF27AE60);
      case CategoryColor.red:
        return Color(0xFFE74C3C);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Container(); // Hide sidebar on mobile, use drawer instead
    }

    final sidebarWidth = isTV ? 220.0 : 180.0;

    return Container(
      width: sidebarWidth,
      decoration: BoxDecoration(
        color: Color(0xFF2C3E50),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 0),
          ),
        ],
      ),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category.id == selectedCategory;

          return _buildCategoryItem(
            category: category,
            isSelected: isSelected,
            onTap: () => onCategorySelected(category.id),
          );
        },
      ),
    );
  }

  Widget _buildCategoryItem({
    required Category category,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Focus(
      child: Builder(
        builder: (context) {
          final isFocused = Focus.of(context).hasFocus;

          return GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              margin: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isTV ? 16 : 12,
                vertical: isTV ? 14 : 12,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? _getCategoryColor(category.color)
                    : (isFocused
                    ? Color(0xFF34495E)
                    : Colors.transparent),
                borderRadius: BorderRadius.circular(8),
                border: isFocused && !isSelected
                    ? Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 2,
                )
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      category.name,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontSize: isTV ? 14 : 12,
                        fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (category.itemCount > 0) ...[
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.black.withOpacity(0.2)
                            : Color(0xFFE74C3C),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        category.itemCount.toString(),
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontSize: isTV ? 11 : 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class MoviesScreen extends ConsumerStatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends ConsumerState<MoviesScreen> {
  final ScrollController _scrollController = ScrollController();
  int _focusedCategoryIndex = 0;
  int _focusedMediaIndex = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTV = size.width > 800;
    final isMobile = size.width < 600;

    final categories = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final mediaItems = ref.watch(filteredMediaItemsProvider);

    return Scaffold(
      backgroundColor: Color(0xFF1E1E2E),
      body: SafeArea(
        child: Row(
          children: [
            // Sidebar
            CategorySidebar(
              categories: categories,
              selectedCategory: selectedCategory,
              onCategorySelected: (categoryId) {
                ref.read(selectedCategoryProvider.notifier).state = categoryId;
              },
              isTV: isTV,
              isMobile: isMobile,
            ),

            // Main content area
            Expanded(
              child: Column(
                children: [
                  // Header
                  _buildHeader(selectedCategory, categories, isTV, isMobile),

                  // Media Grid
                  Expanded(
                    child: mediaItems.when(
                      data: (items) {
                        if (items.isEmpty) {
                          return _buildEmptyState(isTV, isMobile);
                        }
                        return MediaGrid(
                          items: items,
                          isTV: isTV,
                          isMobile: isMobile,
                          scrollController: _scrollController,
                        );
                      },
                      loading: () => _buildLoadingState(),
                      error: (error, stack) => _buildErrorState(error, isTV),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
      String selectedCategory,
      List<Category> categories,
      bool isTV,
      bool isMobile,
      ) {
    final category = categories.firstWhere(
          (cat) => cat.id == selectedCategory,
      orElse: () => categories.first,
    );

    return Container(
      padding: EdgeInsets.all(isTV ? 24 : (isMobile ? 12 : 16)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2C3E50),
            Color(0xFF1E1E2E).withOpacity(0.5),
          ],
        ),
      ),
      child: Row(
        children: [
          // Title - Wise Player
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Wise ',
                  style: TextStyle(
                    fontSize: isTV ? 32 : (isMobile ? 22 : 26),
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: 'Player',
                  style: TextStyle(
                    fontSize: isTV ? 32 : (isMobile ? 22 : 26),
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE74C3C),
                  ),
                ),
              ],
            ),
          ),

          Spacer(),

          // Search button (optional)
          if (!isMobile)
            IconButton(
              icon: Icon(Icons.search, color: Colors.white70),
              iconSize: isTV ? 28 : 24,
              onPressed: () {
                // Implement search
              },
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Color(0xFFE74C3C),
          ),
          SizedBox(height: 16),
          Text(
            'Loading media...',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isTV, bool isMobile) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.movie_outlined,
            size: isTV ? 100 : (isMobile ? 60 : 80),
            color: Colors.white24,
          ),
          SizedBox(height: 16),
          Text(
            'No media found',
            style: TextStyle(
              color: Colors.white70,
              fontSize: isTV ? 24 : (isMobile ? 16 : 20),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try selecting a different category',
            style: TextStyle(
              color: Colors.white38,
              fontSize: isTV ? 16 : (isMobile ? 12 : 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error, bool isTV) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: isTV ? 100 : 80,
            color: Color(0xFFE74C3C),
          ),
          SizedBox(height: 16),
          Text(
            'Error loading media',
            style: TextStyle(
              color: Colors.white,
              fontSize: isTV ? 24 : 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            error.toString(),
            style: TextStyle(
              color: Colors.white54,
              fontSize: isTV ? 14 : 12,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Retry
              ref.invalidate(mediaItemsProvider);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFE74C3C),
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
            child: Text(
              'Retry',
              style: TextStyle(
                fontSize: isTV ? 16 : 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class MediaService {
  // Replace with your actual API endpoint
  final String baseUrl = 'https://api.example.com';

  // Get media items by category
  Future<List<MediaItem>> getMediaByCategory(String category) async {
    // For demo purposes, return mock data
    // Replace this with actual API call
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return _getMockData(category);
  }

  // Mock data for demonstration
  List<MediaItem> _getMockData(String category) {
    final now = DateTime.now();

    final List<MediaItem> allItems = [
      MediaItem(
        id: '1',
        title: 'AVATAR : Fire and Ash',
        imageUrl: 'https://image.tmdb.org/t/p/w500/path_to_avatar.jpg',
        type: MediaType.movie,
        rating: 1,
        views: 0,
        categories: ['recently_added', 'netflix'],
        description: 'Avatar sequel',
        year: 2024,
        addedDate: now.subtract(Duration(days: 1)),
      ),
      MediaItem(
        id: '2',
        title: '28 Years Later: The Bone Temple (2026)',
        imageUrl: 'https://image.tmdb.org/t/p/w500/path_to_28years.jpg',
        type: MediaType.movie,
        rating: 7,
        views: 0,
        categories: ['recently_added', 'hbo_prime'],
        description: 'Horror movie sequel',
        year: 2026,
        addedDate: now.subtract(Duration(days: 2)),
      ),
      MediaItem(
        id: '3',
        title: 'Zootopia 2',
        imageUrl: 'https://image.tmdb.org/t/p/w500/path_to_zootopia.jpg',
        type: MediaType.movie,
        rating: 1,
        views: 0,
        categories: ['recently_added', 'disney'],
        description: 'Animated adventure',
        year: 2025,
        addedDate: now.subtract(Duration(days: 3)),
      ),
      MediaItem(
        id: '4',
        title: 'The Housemaid',
        imageUrl: 'https://image.tmdb.org/t/p/w500/path_to_housemaid.jpg',
        type: MediaType.movie,
        rating: 0,
        views: 0,
        categories: ['recently_added', 'paramount'],
        description: 'Thriller movie',
        year: 2024,
        addedDate: now.subtract(Duration(days: 4)),
      ),
      MediaItem(
        id: '5',
        title: 'Marty Supreme',
        imageUrl: 'https://image.tmdb.org/t/p/w500/path_to_marty.jpg',
        type: MediaType.movie,
        rating: 0,
        views: 0,
        categories: ['recently_added', 'netflix'],
        description: 'Drama',
        year: 2024,
        addedDate: now.subtract(Duration(days: 5)),
      ),
    ];

    // Filter by category
    if (category == 'recently_added' || category == 'favorites') {
      return allItems;
    }

    return allItems.where((item) => item.categories.contains(category)).toList();
  }

  // API call example (replace mock data with this)
  Future<List<MediaItem>> fetchMediaFromAPI(String category) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/media?category=$category'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => MediaItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load media');
      }
    } catch (e) {
      throw Exception('Error fetching media: $e');
    }
  }

  // Toggle favorite
  Future<void> toggleFavorite(String mediaId, bool isFavorite) async {
    // Call API to save favorite status
    await Future.delayed(Duration(milliseconds: 300));
    // await http.post(Uri.parse('$baseUrl/favorites/$mediaId'), ...);
  }

  // Get favorites
  Future<List<MediaItem>> getFavorites() async {
    // Call API to get user's favorites
    await Future.delayed(Duration(seconds: 1));
    return _getMockData('favorites');
  }
}


// providers/media_provider.dart


// Selected category provider
final selectedCategoryProvider = StateProvider<String>((ref) => 'recently_added');

// Media items provider
final mediaItemsProvider = FutureProvider.family<List<MediaItem>, String>(
      (ref, category) async {
    final service = ref.read(mediaServiceProvider);
    return await service.getMediaByCategory(category);
  },
);

// Favorites provider
final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<String>>(
      (ref) => FavoritesNotifier(),
);

class FavoritesNotifier extends StateNotifier<List<String>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(String mediaId) {
    if (state.contains(mediaId)) {
      state = state.where((id) => id != mediaId).toList();
    } else {
      state = [...state, mediaId];
    }
  }

  bool isFavorite(String mediaId) {
    return state.contains(mediaId);
  }
}

// Categories provider
final categoriesProvider = Provider<List<Category>>((ref) {
  return [
    Category(
      id: 'favorites',
      name: 'Favorites List',
      itemCount: 0,
      color: CategoryColor.yellow,
    ),
    Category(
      id: 'recently_added',
      name: 'Recently Added',
      itemCount: 100,
      color: CategoryColor.yellow,
    ),
    Category(
      id: 'multi_netflix',
      name: 'MULTI ! NETFLIX SERIES',
      itemCount: 0,
      color: CategoryColor.orange,
    ),
    Category(
      id: 'f1_4k',
      name: 'F1 ? 4k SERIES',
      itemCount: 0,
      color: CategoryColor.orange,
    ),
    Category(
      id: 'netflix',
      name: 'NETFLIX',
      itemCount: 0,
      color: CategoryColor.orange,
    ),
    Category(
      id: 'hbo_prime',
      name: 'HBO ! PRIME VIDEO',
      itemCount: 0,
      color: CategoryColor.orange,
    ),
    Category(
      id: 'disney',
      name: 'DISNEY +',
      itemCount: 0,
      color: CategoryColor.orange,
    ),
    Category(
      id: 'paramount',
      name: 'PARAMOUNT +',
      itemCount: 0,
      color: CategoryColor.orange,
    ),
  ];
});

// Media service provider
final mediaServiceProvider = Provider<MediaService>((ref) {
  return MediaService();
});

// Search query provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Filtered media items based on search
final filteredMediaItemsProvider = Provider<AsyncValue<List<MediaItem>>>((ref) {
  final category = ref.watch(selectedCategoryProvider);
  final searchQuery = ref.watch(searchQueryProvider);
  final mediaItems = ref.watch(mediaItemsProvider(category));

  return mediaItems.when(
    data: (items) {
      if (searchQuery.isEmpty) {
        return AsyncValue.data(items);
      }
      final filtered = items.where((item) {
        return item.title.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
      return AsyncValue.data(filtered);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});


