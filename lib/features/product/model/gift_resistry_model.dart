// gift_registry_item.dart
import 'package:common_user/features/product/model/product_model.dart';
import 'package:common_user/features/product/model/event_model.dart';

class GiftRegistryItem {
  final Product product;
  final EventModel event;

  GiftRegistryItem({
    required this.product,
    required this.event,
  });
}
