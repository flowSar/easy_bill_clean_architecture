void main() {
  List<int> ids = [1, 3, 5];
  List<int> numbers = [1, 6, 1, 5, 3, 3, 1];

  print(numbers.where((num) => ids.contains(num)));
}
