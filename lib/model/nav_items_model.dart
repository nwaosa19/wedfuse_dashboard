import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedme_dashboard/views/log_view.dart';
import 'package:wedme_dashboard/views/suspension_view.dart';
import 'package:wedme_dashboard/views/users_view.dart';
import 'package:wedme_dashboard/views/verification_view.dart';
import 'package:wedme_dashboard/views/view_provider.dart';

class NavItemModel {
  String label;
  IconData iconData;
  Function(BuildContext context, WidgetRef ref, double screenWidth)? onTap;
  NavItemModel({
    required this.label,
    required this.iconData,
    required this.onTap,
  });
}

List<NavItemModel> NavDefaultItems = [
  NavItemModel(
    label: "User",
    iconData: Icons.person,
    onTap: (BuildContext context, WidgetRef ref, double screenWidth) {
      final view = ref.read(viewProvider.notifier);
      view.state = const UsersView();

      final label = ref.read(viewLabelProvider.notifier);
      label.state = "User";

      if (screenWidth <= 700) Navigator.pop(context);
    },
  ),
  NavItemModel(
    label: "Verifications",
    iconData: Icons.verified_outlined,
    onTap: (BuildContext context, WidgetRef ref, double screenWidth) {
      final view = ref.read(viewProvider.notifier);
      view.state =  const VerificationView();

      final label = ref.read(viewLabelProvider.notifier);
      label.state = "Verifications";

      if (screenWidth <= 700) Navigator.pop(context);
    },
  ),
  // NavItemModel(
  //   label: "Reports",
  //   iconData: Icons.report,
  //   onTap: (BuildContext context, WidgetRef ref, double screenWidth) {
  //     final view = ref.read(viewProvider.notifier);
  //     view.state = Text("Reports");

  //     final label = ref.read(viewLabelProvider.notifier);
  //     label.state = "Reports";

  //     if (screenWidth <= 700) Navigator.pop(context);
  //   },
  // ),
  NavItemModel(
    label: "Suspensions",
    iconData: Icons.hide_source,
    onTap: (BuildContext context, WidgetRef ref, double screenWidth) {
      final view = ref.read(viewProvider.notifier);
      view.state = const SuspensionView();

      final label = ref.read(viewLabelProvider.notifier);
      label.state = "Suspensions";

      if (screenWidth <= 700) Navigator.pop(context);
    },
  ),
  NavItemModel(
    label: "Activity Logs",
    iconData: Icons.local_activity_outlined,
    onTap: (BuildContext context, WidgetRef ref, double screenWidth) {
      final view = ref.read(viewProvider.notifier);
      view.state =  const LogView();

      final label = ref.read(viewLabelProvider.notifier);
      label.state = "Activity Logs";
      if (screenWidth <= 700) Navigator.pop(context);
    },
  ),
];

List<NavItemModel> NavRolesItems = [
  NavItemModel(
    label: "Roles",
    iconData: Icons.settings,
    onTap: (BuildContext context, WidgetRef ref, double screenWidth) {
      final view = ref.read(viewProvider.notifier);
      view.state = Text("Roles");

      final label = ref.read(viewLabelProvider.notifier);
      label.state = "Roles";
      if (screenWidth <= 700) Navigator.pop(context);
    },
  ),
];

List<NavItemModel> NavInquriesItems = [
  NavItemModel(
    label: "FAQ",
    iconData: Icons.lock,
    onTap: (BuildContext context, WidgetRef ref, double screenWidth) {
      final view = ref.read(viewProvider.notifier);
      view.state = Text("FAQ");
      final label = ref.read(viewLabelProvider.notifier);
      label.state = "FAQ";

      if (screenWidth <= 700) Navigator.pop(context);
    },
  ),
  NavItemModel(
    label: "T&C",
    iconData: Icons.lock,
    onTap: (BuildContext context, WidgetRef ref, double screenWidth) {
      final view = ref.read(viewProvider.notifier);
      view.state = Text("T&C");

      final label = ref.read(viewLabelProvider.notifier);
      label.state = "T&C";
      if (screenWidth <= 700) Navigator.pop(context);
    },
  ),
];

List<NavItemModel> NavAuthItems = [
  NavItemModel(
    label: "Log out",
    iconData: Icons.logout,
    onTap: (BuildContext context, WidgetRef ref, double screenWidth) {
      final view = ref.read(viewProvider.notifier);
      view.state = Text("Log out");

      final label = ref.read(viewLabelProvider.notifier);
      label.state = "Log out";
      if (screenWidth <= 700) Navigator.pop(context);

      
    },
  ),
];
