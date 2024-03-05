import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LogView extends StatefulWidget {
  const LogView({super.key});

  @override
  State<LogView> createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Row(
            children: [
              Text(
                "Action",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Logs of recent activity",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("logs").snapshots(),
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

              final logs = snapshot.data!.docs;

              return DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      '#',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ACTION',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'DETAIL',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ENFORCER',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ROLE',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'DATE',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
                rows: logs.map((log) {
                  Timestamp time = log["date"];
                  int index = logs.indexOf(log);
                  return DataRow(cells: <DataCell>[
                    DataCell(
                      Text(
                        index.toString(),
                      ),
                    ),
                    DataCell(
                      Text(log["action"]),
                    ),
                    DataCell(
                      Text(log["detail"]),
                    ),
                    DataCell(
                      Text(log["enforcer"]),
                    ),
                    DataCell(
                      Text(log["role"]),
                    ),
                    DataCell(
                      Text(time.toDate().toString()),
                    )
                  ]);
                }).toList(),
                // rows: <DataRow>[
                //   DataRow(cells: <DataCell>[
                //     const DataCell(
                //       Text('1'),
                //     ),
                //     const DataCell(
                //       Text('A use was suspended'),
                //     ),
                //     const DataCell(
                //       Text('2 weeks suspension'),
                //     ),
                //     const DataCell(
                //       Text('John Doe'),
                //     ),
                //     const DataCell(
                //       Text('Admin'),
                //     ),
                //     DataCell(
                //       Text(DateTime.now().toString()),
                //     ),
                //   ]),
                //   // More rows...r
                // ],
              );
            },
          ),
        ],
      ),
    );
  }
}
