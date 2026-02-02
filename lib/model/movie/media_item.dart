
class MediaItem {
  final String id;
  final String title;
  final String imageUrl;
  final MediaType type;
  final double rating;
  final int views;
  final String? quality; // 4K, HD, etc.
  final List<String> categories;
  final String description;
  final int year;
  final bool isFavorite;
  final DateTime addedDate;

  MediaItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.type,
    this.rating = 0.0,
    this.views = 0,
    this.quality,
    this.categories = const [],
    this.description = '',
    required this.year,
    this.isFavorite = false,
    required this.addedDate,
  });

  MediaItem copyWith({
    String? id,
    String? title,
    String? imageUrl,
    MediaType? type,
    double? rating,
    int? views,
    String? quality,
    List<String>? categories,
    String? description,
    int? year,
    bool? isFavorite,
    DateTime? addedDate,
  }) {
    return MediaItem(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      rating: rating ?? this.rating,
      views: views ?? this.views,
      quality: quality ?? this.quality,
      categories: categories ?? this.categories,
      description: description ?? this.description,
      year: year ?? this.year,
      isFavorite: isFavorite ?? this.isFavorite,
      addedDate: addedDate ?? this.addedDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'type': type.toString(),
      'rating': rating,
      'views': views,
      'quality': quality,
      'categories': categories,
      'description': description,
      'year': year,
      'isFavorite': isFavorite,
      'addedDate': addedDate.toIso8601String(),
    };
  }

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      type: MediaType.values.firstWhere(
            (e) => e.toString() == json['type'],
        orElse: () => MediaType.movie,
      ),
      rating: json['rating']?.toDouble() ?? 0.0,
      views: json['views'] ?? 0,
      quality: json['quality'],
      categories: List<String>.from(json['categories'] ?? []),
      description: json['description'] ?? '',
      year: json['year'],
      isFavorite: json['isFavorite'] ?? false,
      addedDate: DateTime.parse(json['addedDate']),
    );
  }
}

enum MediaType {
  movie,
  series,
}

class Category {
  final String id;
  final String name;
  final int itemCount;
  final CategoryColor color;

  Category({
    required this.id,
    required this.name,
    required this.itemCount,
    this.color = CategoryColor.yellow,
  });
}

enum CategoryColor {
  yellow,
  orange,
  blue,
  purple,
  green,
  red,
}