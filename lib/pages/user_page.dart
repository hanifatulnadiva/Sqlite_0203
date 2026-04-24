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
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nohpController = TextEditingController();
  final _alamatController = TextEditingController();

  @override
  void initState(){
    super.initState();
    if(widget.user != null){
      _nameController.text = widget.user!.name;
      _emailController.text = widget.user!.email;
      _nohpController.text = widget.user!.nohp;
      _alamatController.text=widget.user!.alamat;
    }
  }
  @override
  Widget build(BuildContext context) {
    final isEditing = widget.user != null;
    return Scaffold(
      appBar: AppBar(title:Text(isEditing ? "Edit User":"Tambah User")),
      body: Padding(
        padding:EdgeInsets.all(16.0),
        child:Column(children: [
          TextField(controller:_nameController,
          decoration:InputDecoration(labelText:"Nama Lengkap", border:OutlineInputBorder()),
          ),
          SizedBox(height:16.0),
          TextField(controller:_emailController,
          keyboardType: TextInputType.emailAddress,
          decoration:InputDecoration(labelText:"Email", border:OutlineInputBorder()),
          ),
          SizedBox(height:16.0),
          IntlPhoneField(controller:_nohpController,
            keyboardType: TextInputType.phone,
            decoration:InputDecoration(labelText:"Nomor Hp", border:OutlineInputBorder()),
            initialCountryCode: 'ID',
            onChanged: (value){
              print(value.completeNumber);
            },
            validator:(value){
              if(value == null||value.number.isEmpty){
                return "nohp wajib diisi";
              }
              if(value.completeNumber.length > 15){
                return "Maksimal 15 karakter";
              }
              return null;
            },
          ),
          SizedBox(height:16.0),
          TextField(controller:_alamatController,
          decoration:InputDecoration(labelText:"Alamat", border:OutlineInputBorder()),
          ),
          const SizedBox(height:16.0),
          SizedBox(
            width: double.infinity,
            height: 58,
            child:ElevatedButton(onPressed: (){
              final newUser = UserEntity(
                id: isEditing ? widget.user!.id :DateTime.now().millisecondsSinceEpoch.toString(),
                name: _nameController.text,
                email: _emailController.text,
                nohp: _nohpController.text,
                alamat: _alamatController.text
              );
              if(isEditing){
                context.read<UserBloc>().add(UpdateUserEvent(newUser));
              }else
              {
                context.read<UserBloc>().add(AddUserEvent(newUser));
              }
              Navigator.pop(context);
            }, child: Text(isEditing ? "SimpanPerubahan" : "Simpan User Baru"))
          )
        ],
      ),)
    );
  }
}