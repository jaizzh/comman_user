import 'package:common_user/homepage/dashboard%20page/invites_visit/data/invitecompleted.dart';
import 'package:common_user/homepage/dashboard%20page/invites_visit/data/invitecontact.dart';
import 'package:common_user/homepage/dashboard%20page/invites_visit/model/model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final inviteecontact = StateProvider<List<InviteModel>>(
    (ref) => List<InviteModel>.from(invitescontact, growable: true));
final invitemanual = StateProvider<List<InviteModel>>((ref) => []);
final invitecompletes = StateProvider<List<InviteModel>>(
    (ref) => List<InviteModel>.from(inviteComplete, growable: true));

final yourimageriverpod = StateProvider<List<XFile>>((ref) => []);
