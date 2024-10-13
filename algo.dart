void main() {
  Map<String, double> spending = {
    'Bill': 250.0,
    'Food': 300.0,
    'Entertainment': 150.0,
    'Shopping': 200.0,
    'Save': 100.0,
  };

  double saveTarget = 200.0;
  int months = 6; // Number of months to save
  double monthlySaveTarget = saveTarget / months;

  double decrementSpend = monthlySaveTarget - spending['Save']!;

  List<String> unnecessary = ['Entertainment', 'Shopping'];
  unnecessary.sort((a, b) => spending[b]!.compareTo(spending[a]!));

  for (String category in unnecessary) {
    if (decrementSpend <= 0) break;

    double down = spending[category]! < decrementSpend ? spending[category]! : decrementSpend;
    spending[category] = spending[category]! - down;
    decrementSpend -= down;
  }

  spending['Save'] = spending['Save']! + (monthlySaveTarget - spending['Save']!);

  print('Solution recommendation for $months months:');
  spending.forEach((category, money) {
    print('$category: ${money.toStringAsFixed(2)} \$');
  });
}
