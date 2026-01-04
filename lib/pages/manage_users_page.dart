import 'package:flutter/material.dart';
import '../data/fake_users.dart';

class ManageUsersPage extends StatefulWidget {
  const ManageUsersPage({super.key});

  @override
  State<ManageUsersPage> createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7EDE9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Manage Users",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: usersDB.isEmpty
          ? const Center(
              child: Text(
                "No users found.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: usersDB.length,
              itemBuilder: (context, index) {
                final u = usersDB[index];
                final bool isAdmin = u["role"] == "Admin";

                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        u["name"],
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("Email: ${u["email"]}"),
                      Text("Role: ${u["role"]}"),

                      const SizedBox(height: 15),

                      Row(
                        children: [
                          // RESET PASSWORD
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[300],
                            ),
                            onPressed: () {
                              _confirmAction(
                                context,
                                "Reset Password",
                                "Reset password for this user?",
                                () {
                                  setState(() {
                                    u["password"] = "123456";
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Password reset to default."),
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Text(
                              "Reset Password",
                              style:
                                  TextStyle(color: Colors.black),
                            ),
                          ),

                          const SizedBox(width: 10),

                          // DELETE USER
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isAdmin
                                  ? Colors.grey
                                  : Colors.red[300],
                            ),
                            onPressed: isAdmin
                                ? null
                                : () {
                                    _confirmAction(
                                      context,
                                      "Delete User",
                                      "This action cannot be undone. Continue?",
                                      () {
                                        setState(() {
                                          usersDB.removeAt(index);
                                        });
                                      },
                                    );
                                  },
                            child: const Text(
                              "Delete",
                              style:
                                  TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),

                      if (isAdmin)
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            "Admin account cannot be deleted.",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  // =====================
  // CONFIRMATION DIALOG
  // =====================
  void _confirmAction(BuildContext context, String title,
      String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
