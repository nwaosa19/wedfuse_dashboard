import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedme_dashboard/services/logs_service.dart';
import 'package:wedme_dashboard/utils/loading_indicator.dart';

class SuspensionView extends StatefulWidget {
  const SuspensionView({super.key});

  @override
  State<SuspensionView> createState() => _SuspensionViewState();
}

class _SuspensionViewState extends State<SuspensionView> {
  Future<void> addSuspension({
    required String reason,
    required String name,
    required DateTime date,
    required String period,
    required String userId,
  }) async {
    try {
      // Show loading indicator
      showLoadingDialog(context);

      await FirebaseFirestore.instance.collection('suspensions').add({
        'reason': reason,
        'name': name,
        'date': date,
        'period': period,
        "userId": userId
      }).then((value) async {
        await addLog(
          context,
          action: "A user was suspended",
          detail: "$period Suspension ",
          enforcer: "John Doe",
          role: "Admin",
          date: date,
        );
      }).then((value) => Navigator.pop(context));
    } catch (error) {
      // Handle errors (e.g., show an error message)
      print('Error adding suspension: $error');
    }
  }

  Future<void> deleteSuspensionById(String id) async {
    try {
      // Show loading indicator
      showLoadingDialog(context);
      await FirebaseFirestore.instance
          .collection('suspensions')
          .doc(id)
          .delete()
          .then((value) async {
        await addLog(
          context,
          action: "A user was unsuspended",
          detail: "Suspension resolved ",
          enforcer: "John Doe",
          role: "Admin",
          date: DateTime.now(),
        ).then((value) => Navigator.pop(context));
      });
    } catch (error) {
      // Handle errors (e.g., show an error message)
      print('Error deleting suspension: $error');
    }
  }

  final GlobalKey<FormState> _findUserKey = GlobalKey();

  List<String> tableHeading = const [
    "REASON",
    "NAME",
    "DATE",
    "PERIOD",
    "ACTIONS"
  ];
  String email = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Account Suspension",
                  style: TextStyle(fontSize: 25, color: Colors.black54),
                ),
                const SizedBox(height: 40),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 300,
                    minHeight: 50,
                  ),
                  child: Form(
                    key: _findUserKey,
                    child: TextFormField(
                      onChanged: (value) => email = value,
                      validator: (value) {
                        if (value!.isEmpty) return "Field cannot be empty";
                        if (!value.contains("@")) return "Email is required";
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Search for user",
                        // enabledBorder: (
                        //   borderSide: const BorderSide(color:  Color.fromARGB(255, 222, 221, 221)),
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    if (_findUserKey.currentState!.validate()) {
                      // find user
                      setState(() {});
                    }
                  },
                  child: const Text("Find user"),
                ),
                const SizedBox(height: 40),
                const Text(
                  "USER FOUND",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .where("email", isEqualTo: email)
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
                      if (userDocs.isEmpty) return const Text("User not found");

                      final user = userDocs.first;

                      return Card(
                        color: Colors.yellow,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user['userId'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  user['fullName'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Subscription",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await addSuspension(
                                      reason: "Threat operation",
                                      name: user["fullName"],
                                      userId: user["userId"],
                                      date: DateTime.now(),
                                      period: "4 week",
                                    );
                                  },
                                  child: const Text(
                                    "Suspend",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                const SizedBox(height: 20),
                const Text(
                  "Suspended Accounts",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 25),
                
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("suspensions")
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

                    return DataTable(
                      columns: <DataColumn>[
                        for (var element in tableHeading)
                          DataColumn(
                            label: Text(
                              element,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                      ],
                      rows: snapshot.data!.docs.map((user) {
                        Timestamp stamp = user["date"];
                        DateTime date = stamp.toDate();
                        return DataRow(cells: <DataCell>[
                          DataCell(
                            Text(
                              user["reason"],
                            ),
                          ),
                          DataCell(
                            Text(user["name"]),
                          ),
                          DataCell(
                            Text(date.toString()),
                          ),
                          DataCell(Text(user["period"])),
                          DataCell(PopupMenuButton<String>(
                            onSelected: (value) async {
                              if (value == 'Unsuspend') {
                                await deleteSuspensionById(user.id);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'Unsuspend',
                                child: Text(
                                  'Unsuspend',
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
        ),
      ),
    );
  }
}
