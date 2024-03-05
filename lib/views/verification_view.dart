import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:wedme_dashboard/utils/loading_indicator.dart';

import '../services/logs_service.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  Future<void> verifyUser(String id) async {
    try {
      // Show loading indicator
      showLoadingDialog(context);

      await FirebaseFirestore.instance
          .collection('verifications')
          .doc(id)
          .update({'status': 'verified'}).then((value) async {
        await addLog(
          context,
          action: "A user's account was verified ",
          detail: "Account verification completed",
          enforcer: "John Doe",
          role: "Admin",
          date: DateTime.now(),
        ).then((value) => Navigator.pop(context));
      });
    } catch (e) {
      print(e);
    }
  }

  List<String> colHeading = const [
    'UserId',
    'Name',
    'Email',
    'Status',
    'Action',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Row(
              children: [
                Text(
                  "Users",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(width: 10),
                Text(
                  "Verification Request",
                  style: TextStyle(fontSize: 25, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 30),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("verifications")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text(
                      'No user data found',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }
                final userDocs = snapshot.data!.docs;

                return DataTable(
                  columns: <DataColumn>[
                    for (var element in colHeading)
                      DataColumn(
                        label: Text(
                          element,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                  rows: userDocs.map((doc) {
                    return DataRow(cells: <DataCell>[
                      DataCell(
                        Text(
                          doc["name"],
                        ),
                      ),
                      DataCell(
                        Text(doc["email"]),
                      ),
                      DataCell(
                        Text(doc["status"]),
                      ),
                      DataCell(PopupMenuButton<String>(
                        onSelected: (value) async {
                          if (value == 'Verify') {
                            await verifyUser(doc.id);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'Verify',
                            child: Text(
                              'Verify',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          // ... other options as needed
                        ],
                      )),
                    ]);
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> _getTitleWidget() {
  return [
    _getTitleItemWidget('UserId', 200),
    _getTitleItemWidget('Name', 100),
    _getTitleItemWidget('Email', 200),
    _getTitleItemWidget('Status', 100),
    _getTitleItemWidget('Action', 200),
  ];
}

Widget _getTitleItemWidget(String label, double width) {
  return Container(
    width: width,
    height: 56,
    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
    alignment: Alignment.centerLeft,
    child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}
