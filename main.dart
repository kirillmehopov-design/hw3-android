abstract class MediaItem {
  String id;
  String title;
  double price;

  MediaItem({
    required this.id,
    required this.title,
    required this.price,
  });

  String getDetails();
}

mixin Downloadable {
  void download(String title) {
    print('Downloading $title...');
  }
}

class Audiobook extends MediaItem with Downloadable {
  double durationHours;
  String narrator;

  Audiobook({
    required super.id,
    required super.title,
    required super.price,
    required this.durationHours,
    required this.narrator,
  });

  @override
  String getDetails() {
    return 'Audiobook: $title, Narrator: $narrator, Duration: $durationHours hours, Price: $price';
  }
}

class EBook extends MediaItem with Downloadable {
  double fileSizeMB;
  String author;

  EBook({
    required super.id,
    required super.title,
    required super.price,
    required this.fileSizeMB,
    required this.author,
  });

  @override
  String getDetails() {
    return 'EBook: $title, Author: $author, Size: $fileSizeMB MB, Price: $price';
  }
}

class ShoppingCart {
  final List<MediaItem> _items = [];

  void addItem(MediaItem item) {
    _items.add(item);
  }

  double calculateTotalWithTax({double taxRate = 0.12}) {
    double subtotal = _items.fold(
      0.0,
      (sum, item) => sum + item.price,
    );

    return subtotal + subtotal * taxRate;
  }

  List<MediaItem> filterByMaxPrice(double maxPrice) {
    return _items.where((item) => item.price <= maxPrice).toList();
  }
}

void main() {}
