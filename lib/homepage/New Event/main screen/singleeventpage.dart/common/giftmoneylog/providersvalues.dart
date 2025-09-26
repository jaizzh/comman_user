import 'package:flutter/material.dart';

class formvalues extends ChangeNotifier {
  final List<Map<String, String>> values = [];

  // ✅ Add both methods for compatibility
  void addvalues(Map<String, String> add) {
    print('🟢 addvalues called with: $add'); // Debug print
    values.add(add);
    print('🟢 Total items now: ${values.length}'); // Debug print
    notifyListeners();
  }

  // ✅ Add alias method
  void addValue(Map<String, String> add) {
    print('🟢 addValue called with: $add'); // Debug print
    addvalues(add); // Call the original method
  }

  List<Map<String, String>> getAllValues() {
    print(
        '🟢 getAllValues called, returning ${values.length} items'); // Debug print
    return List.unmodifiable(values);
  }

  int get totalCount => values.length;

  int get cashCount =>
      values.where((item) => item['amountType'] == 'Cash').length;

  int get onlineCount =>
      values.where((item) => item['amountType'] == 'Online Payment').length;

  double get totalAmount {
    double total = 0.0;
    for (var item in values) {
      final amount = double.tryParse(item['amount'] ?? '0') ?? 0.0;
      total += amount;
    }
    return total;
  }
}
