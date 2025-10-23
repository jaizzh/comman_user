import 'package:flutter/material.dart';

class NotificationItem {
  final String heading;
  final String content;
  final DateTime createdAt;
  bool isRead;

  NotificationItem({
    required this.heading,
    required this.content,
    required this.createdAt,
    this.isRead = false,
  });
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _scrollCtrl = ScrollController();

  late List<NotificationItem> _items = [
    NotificationItem(
      heading: 'MangalMall',
      content: 'You are successfully registered to the MangalMall.',
      createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
      isRead: false,
    ),
    NotificationItem(
      heading: 'MangalMall Plan Activation',
      content:
          'Your MangalMall premium plan activation was successfully completed at 20/10/2025.',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: true,
    ),
    NotificationItem(
      heading: 'MangalMall Event Created',
      content:
          "You've created a new event using MangalMall. Upgrade your event plan to get more features.",
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      isRead: false,
    ),
  ];

  Future<void> _refresh() async {
    // Simulate refresh; replace with real fetch if needed.
    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) setState(() {});
  }

  void _clearAll() async {
    if (_items.isEmpty) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear all notifications?'),
        content:
            const Text('This will remove all notifications from the list.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Clear all'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      setState(() => _items.clear());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All notifications cleared')),
        );
      }
    }
  }

  void _toggleRead(int index) {
    setState(() => _items[index].isRead = !_items[index].isRead);
  }

  void _deleteItem(int index) {
    final removed = _items.removeAt(index);
    setState(() {});
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed: ${removed.heading}'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() => _items.insert(index, removed));
          },
        ),
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final d = DateTime.now().difference(dt);
    if (d.inMinutes < 1) return 'just now';
    if (d.inMinutes < 60) return '${d.inMinutes}m ago';
    if (d.inHours < 24) return '${d.inHours}h ago';
    if (d.inDays == 1) return 'yesterday';
    return '${d.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Responsive: center content and limit width on large screens
    Widget content = RefreshIndicator(
      onRefresh: _refresh,
      child: _items.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                _EmptyState(onRefresh: _refresh),
              ],
            )
          : ListView.separated(
              controller: _scrollCtrl,
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: _items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = _items[index];
                return Dismissible(
                  key: ValueKey(
                      'notif_$index${item.heading}_${item.createdAt.millisecondsSinceEpoch}'),
                  direction: DismissDirection.endToStart,
                  background: _SwipeBg(color: theme.colorScheme.error),
                  onDismissed: (_) => _deleteItem(index),
                  child: _NotificationCard(
                    item: item,
                    timeLabel: _timeAgo(item.createdAt),
                    onDelete: () => _deleteItem(index),
                    onToggleRead: () => _toggleRead(index),
                  ),
                );
              },
            ),
    );

    content = Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: content,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        surfaceTintColor: theme.colorScheme.surface,
        title: const Text(
          'Notifications',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            tooltip: 'Mark all as read',
            onPressed: _items.isEmpty
                ? null
                : () => setState(() {
                      for (final i in _items) i.isRead = true;
                    }),
            icon: const Icon(Icons.done_all_rounded),
          ),
          IconButton(
            tooltip: 'Clear all',
            onPressed: _items.isEmpty ? null : _clearAll,
            icon: const Icon(Icons.delete_sweep_rounded),
          ),
        ],
      ),
      body: SafeArea(child: content),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem item;
  final String timeLabel;
  final VoidCallback onDelete;
  final VoidCallback onToggleRead;

  const _NotificationCard({
    required this.item,
    required this.timeLabel,
    required this.onDelete,
    required this.onToggleRead,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unreadDot = Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: item.isRead
            ? Colors.transparent
            : theme.colorScheme.primary.withOpacity(0.95),
        shape: BoxShape.circle,
      ),
    );

    return Card(
      elevation: 1.5,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      surfaceTintColor: theme.colorScheme.surfaceTint,
      child: InkWell(
        onLongPress: onToggleRead,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Leading Icon (auto theme)
              Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 10),
                child: Icon(
                  _iconFor(item.heading),
                  size: 26,
                ),
              ),

              // Texts
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title row
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            item.heading,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: item.isRead
                                  ? FontWeight.w600
                                  : FontWeight.w700,
                              fontSize: 15.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        unreadDot,
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.content,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.schedule_rounded,
                            size: 14, color: theme.hintColor),
                        const SizedBox(width: 4),
                        Text(
                          timeLabel,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.hintColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Actions
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    tooltip: 'Remove',
                    onPressed: onDelete,
                    icon: const Icon(Icons.close_rounded),
                    splashRadius: 22,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconFor(String heading) {
    final h = heading.toLowerCase();
    if (h.contains('plan')) return Icons.workspace_premium_rounded;
    if (h.contains('event')) return Icons.event_rounded;
    if (h.contains('register') || h.contains('registered')) {
      return Icons.check_circle_rounded;
    }
    return Icons.notifications_rounded;
    // You can expand with more keywords -> icons if needed.
  }
}

class _SwipeBg extends StatelessWidget {
  final Color color;
  const _SwipeBg({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      color: color,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.delete_rounded, color: Colors.white),
          SizedBox(width: 6),
          Text('Delete', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final Future<void> Function() onRefresh;
  const _EmptyState({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(Icons.notifications_off_rounded,
            size: 64, color: theme.colorScheme.primary),
        const SizedBox(height: 12),
        Text(
          'No notifications',
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Text(
          'You’re all caught up!',
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
        ),
        const SizedBox(height: 16),
        FilledButton.tonal(
          onPressed: onRefresh,
          child: const Text('Refresh'),
        )
      ],
    );
  }
}
