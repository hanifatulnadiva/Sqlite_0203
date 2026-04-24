import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:sqlite/bloc/user_bloc.dart';
import 'package:sqlite/bloc/user_event.dart';
import 'package:sqlite/domain/entities/user_entity.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key, this.user});
  final UserEntity? user;

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nohpController = TextEditingController();
  final _alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nameController.text = widget.user!.name;
      _emailController.text = widget.user!.email;
      _nohpController.text = widget.user!.nohp;
      _alamatController.text = widget.user!.alamat;
    }
  }

  void _submit(bool isEditing) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final newUser = UserEntity(
      id: isEditing
          ? widget.user!.id
          : DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      email: _emailController.text,
      nohp: _nohpController.text,
      alamat: _alamatController.text,
    );

    if (isEditing) {
      context.read<UserBloc>().add(UpdateUserEvent(newUser));
    } else {
      context.read<UserBloc>().add(AddUserEvent(newUser));
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.user != null;

    return Scaffold(
      backgroundColor: const Color(0xFFB8AFAF),
      appBar: AppBar(
        title: Text(
          isEditing ? "Edit User" : "Tambah User",
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB8AFAF),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nama Lengkap",
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 38, 19, 19),
                  ),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Color(0xFF453232),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xFF453232),
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Nama wajib diisi" : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 38, 19, 19),
                  ),
                  prefixIcon: const Icon(Icons.email, color: Color(0xFF453232)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xFF453232),
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email wajib diisi";
                  }
                  if (!value.contains("@")) {
                    return "Format email tidak valid";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              IntlPhoneField(
                controller: _nohpController,
                initialCountryCode: 'ID',
                decoration: InputDecoration(
                  labelText: "Nomor HP",
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 38, 19, 19),
                  ),
                  prefixIcon: const Icon(Icons.phone, color: Color(0xFF453232)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xFF453232),
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.number.isEmpty) {
                    return "No HP wajib diisi";
                  }
                  if (value.completeNumber.length > 15) {
                    return "Maksimal 15 karakter";
                  }
                  if (value.countryISOCode != 'ID') {
                    return "Hanya nomor Indonesia (+62) yang diperbolehkan";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(
                  labelText: "Alamat",
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 38, 19, 19),
                  ),
                  prefixIcon: const Icon(
                    Icons.location_on,
                    color: Color(0xFF453232),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xFF453232),
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Alamat wajib diisi"
                    : null,
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () => _submit(isEditing),
                  child: Text(
                    isEditing ? "Simpan Perubahan" : "Simpan User Baru",
                    style: TextStyle(color: Color(0xFF453232)),
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
