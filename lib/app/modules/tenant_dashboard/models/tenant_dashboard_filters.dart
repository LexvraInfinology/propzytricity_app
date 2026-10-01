enum BudgetFilter {
  under15k('Under ₹15,000', 0, 15000),
  from15kTo30k('₹15,000 – ₹30,000', 15000, 30000),
  above30k('Above ₹30,000', 30000, 100000000);

  const BudgetFilter(this.label, this.min, this.max);
  final String label;
  final int min;
  final int max;

  bool matches(int price) => price >= min && price < max;
}

enum BhkFilter {
  one(1, '1 BHK'),
  two(2, '2 BHK'),
  three(3, '3 BHK'),
  fourPlus(4, '4+ BHK');

  const BhkFilter(this.count, this.label);
  final int count;
  final String label;

  bool matches(int bhk) => this == BhkFilter.fourPlus ? bhk >= count : bhk == count;
}

enum SortOption {
  relevance('Relevance'),
  priceLowToHigh('Price: Low to High'),
  priceHighToLow('Price: High to Low'),
  newest('Newest first');

  const SortOption(this.label);
  final String label;
}
