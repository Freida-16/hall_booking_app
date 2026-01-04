// =======================
// FAKE USERS DATABASE
// =======================
List<Map<String, dynamic>> usersDB = [
  {
    "name": "Admin",
    "email": "admin@gmail.com",
    "password": "admin123",
    "role": "Admin",
  },
  {
    "name": "Test User",
    "email": "test@gmail.com",
    "password": "123456",
    "role": "User",
  },
];


// =======================
// ADD NEW USER (REGISTER)
// =======================
void addUser(String name, String email, String password) {
  usersDB.add({
    "name": name,
    "email": email,
    "password": password,
    "role": "User", // default
  });
}


// =======================
// CHECK LOGIN
// =======================
bool authenticateUser(String email, String password) {
  try {
    final user = usersDB.firstWhere(
      (u) => u["email"] == email,
    );
    return user["password"] == password;
  } catch (e) {
    return false;
  }
}


// =======================
// CHECK DUPLICATE EMAIL
// =======================
bool emailExists(String email) {
  return usersDB.any((u) => u["email"] == email);
}


// =======================
// GET USER ROLE
// =======================
String getUserRole(String email) {
  try {
    final user = usersDB.firstWhere((u) => u["email"] == email);
    return user["role"];
  } catch (e) {
    return "User";
  }
}


// =======================
// RESET PASSWORD (ADMIN)
// =======================
void resetPassword(int index) {
  usersDB[index]["password"] = "123456";
}


// =======================
// DELETE USER (ADMIN)
// =======================
void deleteUser(int index) {
  if (usersDB[index]["role"] != "Admin") {
    usersDB.removeAt(index);
  }
}
