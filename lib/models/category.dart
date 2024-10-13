class Category {
  final String categoryId;
  final String name; 
  int totalExpenses;
  final String icon; 
  final String color; 

  Category({
    required this.categoryId,
    required this.name,
    required this.totalExpenses,
    required this.icon,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'name': name,
      'totalExpenses': totalExpenses,
      'icon': icon,
      'color': color,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      categoryId: map['categoryId'],
      name: map['name'],
      totalExpenses: map['totalExpenses'],
      icon: map['icon'],
      color: map['color'],
    );
  }
}
