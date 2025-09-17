// gift_registry_provider.dart
import 'package:common_user/features/product/model/gift_resistry_model.dart';
import 'package:flutter/material.dart';
import 'package:common_user/features/product/model/product_model.dart';
import 'package:common_user/features/product/model/event_model.dart';

class GiftRegistryProvider with ChangeNotifier {
  final List<GiftRegistryItem> _registry = [];

  List<GiftRegistryItem> get registry => _registry;

  void addToRegistry(Product product, EventModel event) {
    _registry.add(GiftRegistryItem(product: product, event: event));
    notifyListeners();
  }

  void removeFromRegistry(GiftRegistryItem item) {
    _registry.remove(item);
    notifyListeners();
  }

  void clearRegistry() {
    _registry.clear();
    notifyListeners();
  }
}
