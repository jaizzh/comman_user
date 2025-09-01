import 'package:flutter/foundation.dart';

class EventGate {
  // Home page shows EventSummaryCard only when this is true
  static final ValueNotifier<bool> showEventSummary = ValueNotifier<bool>(false);
}
