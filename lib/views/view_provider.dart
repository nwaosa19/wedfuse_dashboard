
 import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedme_dashboard/views/suspension_view.dart';

import 'users_view.dart';

final viewProvider = StateProvider<Widget>((ref) => const SuspensionView());
final viewLabelProvider = StateProvider((ref) =>  "User" );
