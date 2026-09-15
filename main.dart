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

  void printReceipt() {
    print('Receipt:');

    for (MediaItem item in _items) {
      print(item.getDetails());

      if (item is Downloadable) {
        item.download(item.title);
      }
    }
  }
}

void main() {
  ShoppingCart cart = ShoppingCart();

  Audiobook audiobook1 = Audiobook(
    id: 'A1',
    title: 'Atomic Habits',
    price: 18.0,
    durationHours: 5.5,
    narrator: 'James Clear',
  );

  Audiobook audiobook2 = Audiobook(
    id: 'A2',
    title: 'The Hobbit',
    price: 22.0,
    durationHours: 11.0,
    narrator: 'Andy Serkis',
  );

  EBook ebook1 = EBook(
    id: 'E1',
    title: 'Clean Code',
    price: 15.0,
    fileSizeMB: 4.5,
    author: 'Robert C. Martin',
  );

  EBook ebook2 = EBook(
    id: 'E2',
    title: '1984',
    price: 9.0,
    fileSizeMB: 2.1,
    author: 'George Orwell',
  );

  cart.addItem(audiobook1);
  cart.addItem(audiobook2);
  cart.addItem(ebook1);
  cart.addItem(ebook2);

  cart.printReceipt();

  print('Total with tax: ${cart.calculateTotalWithTax()}');

  print('Items with price <= 15:');
  List<MediaItem> filteredItems = cart.filterByMaxPrice(15.0);

  for (MediaItem item in filteredItems) {
    print(item.getDetails());
  }
}
