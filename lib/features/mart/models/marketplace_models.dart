class CategoryModel {
  final String name;
  final String icon; // Using String for asset path or we can use IconData if using built-in icons. User prompt said IconData.

  CategoryModel({required this.name, required this.icon});
}

class ServiceModel {
  final String name;
  final double rating;
  final int reviews;
  final String distance;
  final bool fastResponse;
  final String image;

  ServiceModel({
    required this.name,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.fastResponse,
    required this.image,
  });
}

class DealModel {
  final String title;
  final String description;
  final String discount;

  DealModel({
    required this.title,
    required this.description,
    required this.discount,
  });
}

class ProductModel {
  final String name;
  final String price;
  final int minOrder;
  final String supplier;
  final String location;
  final String image;

  ProductModel({
    required this.name,
    required this.price,
    required this.minOrder,
    required this.supplier,
    required this.location,
    required this.image,
  });
}
