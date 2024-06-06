class Recipe {
  final String name;
  final String images;
  final double rating;
  final String totalTime;

  Recipe({
    required this.name,
    required this.images,
    required this.rating,
    required this.totalTime,
  });

  factory Recipe.fromJson(dynamic json) {
    // Handle potential missing or null values gracefully
    return Recipe(
      name: json['name'] as String,
      images: (json['images'] != null && json['images'].isNotEmpty)
          ? json['images'][0]['hostedLargeUrl'] as String
          : '', // Provide a default or empty string if image is not available
      rating: (json['rating'] != null)
          ? json['rating'].toDouble()
          : 0.0, // Provide default rating if null
      totalTime: json['totalTime'] as String? ??
          '', // Provide a default or empty string if totalTime is null
    );
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }
}
