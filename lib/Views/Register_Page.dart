
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Gloabals/gloabal.dart';
class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final GlobalKey<FormState> userDetails = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: userDetails,
            child: Column(
              children: [
                Image.asset("assets/images/sign_up.png"),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    Global.name = val;
                  },
                  controller: name,
                  decoration:
                  textFieldDecoration(Icons.person, "Enter Name", "Name"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Number";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    Global.number = val;
                  },
                  keyboardType: TextInputType.phone,
                  controller: number,
                  decoration:
                  textFieldDecoration(Icons.call, "Enter Number", "Number"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Email";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    Global.email = val;
                  },
                  controller: email,
                  decoration:
                  textFieldDecoration(Icons.email, "Enter Email", "Email"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Password";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    Global.password = val;
                  },
                  controller: password,
                  obscureText: true,
                  decoration: textFieldDecoration(
                      Icons.lock, "Enter Password", "Password"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (userDetails.currentState!.validate()) {
                      userDetails.currentState!.save();
                      Navigator.of(context).pushReplacementNamed("login_page");
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      prefs.setBool("isUserDetails", true);
                      prefs.setString("email", Global.email.toString());
                      prefs.setString("password", Global.password.toString());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(140, 45),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(onPressed: (){
                  Navigator.of(context).pushNamed("login_page");
                }, child: Text("Go To Sign In"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  textFieldDecoration(icon, hint, label) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      hintText: hint,
      label: Text(label),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
