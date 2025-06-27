import 'package:cura_kefi/Provider/Profile_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    nameController.text = provider.name;
    mobileController.text = provider.mobile;
    emailController.text = provider.email;
    dobController.text = provider.dob;
    selectedGender = provider.gender;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
        title: Text("Profile", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 10),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, size: 60, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 16,
                        child: Icon(Icons.edit, size: 16, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              _buildTextField("-- Full Name --", nameController, (val) => provider.updateName(val),
                  validator: (val) => val == null || val.isEmpty ? 'Enter full name' : null),
              _buildTextField("-- Mobile number --", mobileController, (val) => provider.updateMobile(val),
                  keyboardType: TextInputType.phone,
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Enter mobile number';
                    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(val)) return 'Enter valid 10-digit mobile number';
                    return null;
                  }),
              _buildTextField("-- Email id --", emailController, (val) => provider.updateEmail(val),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Enter email';
                    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(val)) return 'Enter valid email';
                    return null;
                  }),
              _buildDateField(context, dobController, provider),
              _buildGenderDropdown(provider),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && selectedGender != null && dobController.text.isNotEmpty) {
                    provider.saveProfile();
                    _showSuccessDialog(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill all fields correctly")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text("Save", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              // SizedBox(height: 20),
              // _buildTextField("Enter OTP", otpController, (val) {},
              //     keyboardType: TextInputType.number,
              //     validator: (val) => val == null || val.length != 6 ? 'Enter 6-digit OTP' : null),
              // SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: () {
              //     if (otpController.text == "123456") {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text("OTP Verified Successfully!")),
              //       );
              //     } else {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text("Invalid OTP!")),
              //       );
              //     }
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.blueGrey,
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              //     minimumSize: Size(double.infinity, 45),
              //   ),
              //   child: Text("Verify OTP", style: TextStyle(color: Colors.white)),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, Function(String) onChanged,
      {TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context, TextEditingController controller, ProfileProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        validator: (val) => val == null || val.isEmpty ? 'Select date of birth' : null,
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            String formatted = "${picked.day}/${picked.month}/${picked.year}";
            controller.text = formatted;
            provider.updateDob(formatted);
          }
        },
        decoration: InputDecoration(
          hintText: "Date of Birth",
          prefixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown(ProfileProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<String>(
        value: ['Male', 'Female', 'Other'].contains(selectedGender) ? selectedGender : null,
        items: ['Male', 'Female', 'Other'].map((gender) {
          return DropdownMenuItem(
            child: Text(gender),
            value: gender,
          );
        }).toList(),
        onChanged: (val) {
          if (val != null) {
            setState(() {
              selectedGender = val;
            });
            provider.updateGender(val);
          }
        },
        validator: (val) => val == null || val.isEmpty ? 'Select gender' : null,
        decoration: InputDecoration(
          hintText: "-- Gender --",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }


  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 20),
              Text(
                "Congratulations!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Your profile has been saved successfully.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text("OK", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }
}
