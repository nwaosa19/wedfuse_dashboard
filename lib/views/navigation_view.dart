import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedme_dashboard/views/view_provider.dart';

import '../model/nav_items_model.dart';

class NavigationView extends ConsumerWidget {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.sizeOf(context);
    final label = ref.watch(viewLabelProvider);
    return Container(
      width: size.width * 0.25,
      height: size.height,
      decoration:   BoxDecoration(
        color: Colors.white, 

        border: Border(right: BorderSide(color: Colors.grey.shade200, width: 1))

      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Wedme",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 25),
              for (var item in NavDefaultItems)
                InkWell(
                  onTap: () {
                    item.onTap!(context, ref, size.width);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: item.label == label
                            ? const Color.fromARGB(255, 99, 133, 255)
                            : null,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        Icon(
                          item.iconData,
                          color: item.label == label
                              ? Colors.white
                              : Colors.grey.shade800,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 16,
                            color: item.label == label
                                ? Colors.white
                                : Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              const Text(
                "IAM Roles",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 15),
              for (var item in NavRolesItems)
                InkWell(
                  onTap: () => item.onTap!(context, ref, size.width),
                  child: Container(
                    decoration: BoxDecoration(
                      color: item.label == label
                          ? const Color.fromARGB(255, 99, 133, 255)
                          : null,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        Icon(
                          item.iconData,
                          color: item.label == label
                              ? Colors.white
                              : Colors.grey.shade800,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 16,
                            color: item.label == label
                                ? Colors.white
                                : Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              const Text(
                "INQUIRIES",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 15),
              for (var item in NavInquriesItems)
                Container(
                  decoration: BoxDecoration(
                      color: item.label == label
                          ? const Color.fromARGB(255, 99, 133, 255)
                          : null,
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  
                  child: Row(
                    children: [
                      Icon(
                        item.iconData,
                        color: item.label == label
                            ? Colors.white
                            : Colors.grey.shade800,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 16,
                          color: item.label == label
                              ? Colors.white
                              : Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              const Text(
                "LOG OUT",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 15),
              for (var item in NavAuthItems)
                InkWell(
                  onTap: () => item.onTap!(context, ref, size.width),
                  child: Container(
                    decoration: BoxDecoration(
                        color: item.label == label
                            ? const Color.fromARGB(255, 99, 133, 255)
                            : null,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                  
                    child: Row(
                      children: [
                        Icon(
                          item.iconData,
                          color: item.label == label
                              ? Colors.white
                              : Colors.grey.shade800,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 16,
                            color: item.label == label
                                ? Colors.white
                                : Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
