import 'dart:io';
import 'package:common_user/common/mobile%20contacts/groupingcontact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class ImageGridMultiSelect extends StatefulWidget {
  const ImageGridMultiSelect({super.key});

  @override
  State<ImageGridMultiSelect> createState() => _ImageGridMultiSelectState();
}

class _ImageGridMultiSelectState extends State<ImageGridMultiSelect> {
    List<Contact> _allContacts = [];
  List<Contact> _selectedContacts = [];
  List<String> _groupingList = [
    "family","friends","relatives"
  ];

  Future<void> _pickMultipleContacts() async {
    PermissionStatus status = await Permission.contacts.status;
    if (!status.isGranted) {
      status = await Permission.contacts.request();
      if (!status.isGranted) {
        if (status.isPermanentlyDenied) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Permission required'),
              content: const Text('Please enable contacts permission in app settings to select contacts.'),
              actions: [
                TextButton(
                  onPressed: () {
                    openAppSettings();
                    Navigator.pop(context);
                  },
                  child: const Text('Open Settings'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          );
          return;
        } else {
          // Permission denied (not permanent)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contacts permission denied')),
          );
          return;
        }
      }
    }

    // Permission granted, fetch contacts
    bool flutterContactPermission = await FlutterContacts.requestPermission();
    if (!flutterContactPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contacts permission denied')),
      );
      return;
    }

    List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
    setState(() {
      _allContacts = contacts;
    //  _selectedContacts.clear();
    });

    // Open selection page
    final List<Contact>? results = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ContactSelectionPage(
          contacts: _allContacts,
          initiallySelected: _selectedContacts,
        ),
      ),
    );

    // Get selected contacts result
    if (results != null) {
      setState(() {
        _selectedContacts = results;
      });

      for (var c in _selectedContacts) {
        print('Selected: ${c.displayName}');
      }
    }
  }
  final List<String> pictures = [
    "assets/venue_images/v1.jpg",
    "assets/venue_images/v2.jpg",
    "assets/venue_images/v3.jpg",
    "assets/venue_images/v4.jpg",
    "assets/venue_images/v5.jpg",
    "assets/venue_images/v1.jpg",
    "assets/venue_images/v2.jpg",
    "assets/venue_images/v3.jpg",
    "assets/venue_images/v4.jpg",
    "assets/venue_images/v5.jpg",
    "assets/venue_images/v1.jpg",
    "assets/venue_images/v2.jpg",
    "assets/venue_images/v3.jpg",
    "assets/venue_images/v4.jpg",
    "assets/venue_images/v5.jpg",
    "assets/venue_images/v1.jpg",
    "assets/venue_images/v2.jpg",
    "assets/venue_images/v3.jpg",
    "assets/venue_images/v4.jpg",
    "assets/venue_images/v5.jpg",
    "assets/venue_images/v1.jpg",
    "assets/venue_images/v2.jpg",
    "assets/venue_images/v3.jpg",
    "assets/venue_images/v4.jpg",
    "assets/venue_images/v5.jpg",
  ];

  bool selectionMode = false;      // show checkboxes for ALL when true
  final Set<int> selected = {};    // store selected indices

  // --- helpers ---
  List<String> get selectedPaths => selected.map((i) => pictures[i]).toList();
  bool get hasSelection => selected.isNotEmpty;

  void _enterSelection(int index) {
    setState(() {
      selectionMode = true;
      selected.add(index);
    });
  }

  void _toggle(int index) {
    setState(() {
      if (selected.contains(index)) {
        selected.remove(index);
      } else {
        selected.add(index);
      }
      if (selected.isEmpty) selectionMode = false;
    });
  }

  void _clear() {
    setState(() {
      selected.clear();
      selectionMode = false;
    });
  }

  void _deleteSelected() {
    if (selected.isEmpty) return;
    final toDelete = selected.toList()..sort((a, b) => b.compareTo(a)); // delete from end
    setState(() {
      for (final i in toDelete) {
        pictures.removeAt(i);
      }
      selected.clear();
      selectionMode = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Deleted selected images')),
    );
  }

  void _openFull(String path) {
    if (selectionMode) return; // don’t open while selecting
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(child: Image.asset(path, fit: BoxFit.contain)),
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      );
    }));
  }

  // ---------------------------------------------------------
  // SHARE HELPERS
  // ---------------------------------------------------------

  Future<void> _shareSelectedAssetsAsFiles(List<String> assetPaths) async {
    if (assetPaths.isEmpty) return;

    final tempDir = await getTemporaryDirectory();
    final files = <XFile>[];

    // Copy each asset -> temp file
    for (final asset in assetPaths) {
      final data = await rootBundle.load(asset);
      final bytes = data.buffer.asUint8List();
      final filename = asset.split('/').last;
      final file = File('${tempDir.path}/$filename');
      await file.writeAsBytes(bytes, flush: true);
      files.add(XFile(file.path));
    }

    await Share.shareXFiles(
      files,
      text: 'Sharing ${assetPaths.length} photo(s)',
      subject: 'Event Photos',
    );
  }

  void _navigateWithSelected() {
    if (selected.isEmpty) return;
    final paths = selectedPaths;
    _showShareBottomSheet(context, paths);
  }

  // ---------------------------------------------------------
  // BOTTOM SHEET
  // ---------------------------------------------------------
  Future<void> _showShareBottomSheet(BuildContext context, List<String> pathscount) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        final sheet = Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            boxShadow: [BoxShadow(spreadRadius: 1, blurRadius: 12, color: Colors.black26)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Selected (${pathscount.length}) Photos",
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Your custom flows (placeholders)
              _shareTile(
                title: "Share To Grouping Contacts",
                icon: Icons.group,
                color: Colors.deepPurple,
                onTap: alertdialogueds,
              ),
              const SizedBox(height: 12),
              _shareTile(
                title: "Share To Contacts",
                icon: Icons.contacts,
                color: Colors.blueAccent,
                onTap: () {
                  _pickMultipleContacts();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Contacts share tapped')),
                  );
                },
              ),

              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Container(height: 1, width: MediaQuery.of(context).size.width * 0.4, color: Colors.black38),
                    const SizedBox(width: 10),
                    const Text("OR", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.black54)),
                    const SizedBox(width: 10),
                    Container(height: 1, width: MediaQuery.of(context).size.width * 0.4, color: Colors.black38),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Native mobile share
              _shareTile(
                title: "Others Sharing Via Mobile",
                icon: Icons.mobile_friendly_rounded,
                color: Colors.green,
                onTap: () async {
                  // Share the selected images as files (from assets -> temp)
                  await _shareSelectedAssetsAsFiles(pathscount);

                 // (Optional) If you only want to share text/link instead:
                  // final box = context.findRenderObject() as RenderBox?;
                  // await Share.share(
                  //   "Hello! Check this out: https://example.com",
                  //   subject: "Shared from my Mangal Mall",
                  //   sharePositionOrigin: box != null
                  //       ? box.localToGlobal(Offset.zero) & box.size
                  //       : const Rect.fromLTWH(0, 0, 0, 0),
                  // );

                  // if (context.mounted) Navigator.pop(context);
                },
              ),

              const SizedBox(height: 16),
            ],
          ),
        );

        return SafeArea(
          top: false,
          child: sheet,
        );
      },
    );
  }

  Widget _shareTile({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: const [BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.black26)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16.0, color: color),
              const SizedBox(width: 6.0),
              Text(
                title,
                style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // UI
  // ---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final title = selectionMode ? "${selected.length} selected" : "Event Images";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 44,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0.6,
        leading: selectionMode
            ? IconButton(
                tooltip: 'Close selection',
                icon: const Icon(Icons.close, color: Colors.black87),
                onPressed: _clear,
              )
            : null,
        centerTitle: false,
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        actions: [
          if (selectionMode)
            IconButton(
              tooltip: 'Share selected',
              icon: const Icon(Icons.share, color: Colors.black87, size: 18.0),
              onPressed: hasSelection ? _navigateWithSelected : null,
            ),
          if (selectionMode)
            IconButton(
              tooltip: 'Delete selected',
              icon: const Icon(Icons.delete, color: Colors.red, size: 20.0),
              onPressed: hasSelection ? _deleteSelected : null,
            ),
        ],
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8,
        ),
        itemCount: pictures.length,
        itemBuilder: (context, index) {
          final img = pictures[index];
          final isChecked = selected.contains(index);

          return GestureDetector(
            onLongPress: () => _enterSelection(index),
            onTap: () => selectionMode ? _toggle(index) : _openFull(img),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(img, fit: BoxFit.cover),
                ),

                if (selectionMode)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 120),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(isChecked ? 0.20 : 0.08),
                      border: Border.all(
                        color: isChecked ? Colors.green : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),

                if (selectionMode)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      height: 16.0,
                      width: 16.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
                      ),
                      child: Checkbox(
                        value: isChecked,
                        onChanged: (_) => _toggle(index),
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
Future<void> alertdialogueds() {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // tap outside to close (optional)
    builder: (ctx) {
     // final maxH = MediaQuery.of(ctx).size.height * 0.9; // limit height
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: StatefulBuilder(
          builder: (ctx, setLocal) {
            return Container(
height: MediaQuery.of(context).size.height * 0.450,
            //  constraints: BoxConstraints(maxHeight: maxH),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Row(
                      children: [
                        const Text(
                          'Choose Group',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // The list — bounded height via SizedBox (NO Expanded needed)
                    SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.250,
                        child: ListView.builder(
                          itemCount: _groupingList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
                              child: GestureDetector(
                                onTap: () {
                                  // TODO: handle tap on a group
                                  // showsheet(context);
                                  Navigator.pop(ctx, _groupingList[index]); // return selection if needed
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: const [
                                      BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 4),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Left: name
                                      Text(
                                        _groupingList[index],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                        
                                      // Right: count + delete
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(12),
                                              boxShadow: const [
                                                BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 2),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.person, color: Colors.black54, size: 18),
                                                const SizedBox(width: 6),
                                                Text(
                                                  _selectedContacts.length.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Footer actions (optional)
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Close'),
                        ),
                        const Spacer(),
                        FilledButton(
                          onPressed: () {
                            // confirm action
                            Navigator.pop(ctx);
                          },
                          child: const Text('Done'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

}
