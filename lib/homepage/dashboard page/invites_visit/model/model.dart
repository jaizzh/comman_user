// lib/.../model/model.dart
import 'package:image_picker/image_picker.dart';

class InviteModel {
  final String eventName;
  final String eventType; // e.g., "Manual"
  final String startDate; // "yyyy-MM-dd"
  final String endDate; // optional
  final String image; // primary image (asset/file path)
  final String inviteFrom;
  final String address;
  final List<XFile> multiImages; // all images (paths)

  const InviteModel({
    required this.eventName,
    required this.eventType,
    required this.startDate,
    required this.inviteFrom,
    required this.address,
    required this.endDate,
    required this.image,
    this.multiImages = const [],
  });

  InviteModel copyWith({
    String? eventName,
    String? eventType,
    String? startDate,
    String? endDate,
    String? image,
    String? inviteFrom,
    String? address,
    List<XFile>? multiImages,
  }) {
    return InviteModel(
      eventName: eventName ?? this.eventName,
      eventType: eventType ?? this.eventType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      image: image ?? this.image,
      inviteFrom: inviteFrom ?? this.inviteFrom,
      address: address ?? this.address,
      multiImages: multiImages ?? this.multiImages,
    );
  }
}
