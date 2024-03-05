import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  List<String> tableHeading = [
    "NAME",
    "EMAIL",
    "PHONE",
    "VERIFIED",
    "SUBSCRIPTION",
    "STATUS",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Registered users",
                  style: TextStyle(fontSize: 25, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 30),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
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
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }

                // print(snapshot.data!.docs[0]["fullName"]);
                final users = snapshot.data!.docs;
                return DataTable(
                  columns: <DataColumn>[
                    for (var element in tableHeading)
                      DataColumn(
                        label: Text(
                          element,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                  rows: users.map((user) {
                    return DataRow(cells: <DataCell>[
                      DataCell(
                        Text(
                          user["fullName"],
                        ),
                      ),
                      DataCell(
                        Text(user["email"]),
                      ),
                      DataCell(
                        Text(user["phoneNumber"]),
                      ),
                      DataCell(
                        user["isVerified"]
                              ? const Icon(Icons.verified, color: Colors.blue)
                              : const Icon(Icons.no_accounts),
                      ),
                      DataCell(
                        Text( user["subscriptionType"]),
                      ),
                     const  DataCell(
                        Text("Active"),
                      )
                    ]);
                  }).toList(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
