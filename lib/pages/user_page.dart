import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState(){
    super.initState();
    if(widget.user != null){
      _nameController.text = widget.user!.name;
      _emailController.text = widget.user!.email;
    }
  }
  @override
  Widget build(BuildContext context) {
    final isEditing = widget.user != null;
    return Scaffold(
      appBar: AppBar(title:Text(isEditing ? "Edit User":"Tambah User")),
      body: Padding(
        padding:EdgeInsetsGeometry.all(16.0),
        child:Column(children: [
          TextField(controller:_nameController,
          decoration:InputDecoration(labelText:"Nama Lengkap", border:OutlineInputBorder()),
          ),
          SizedBox(height:16.0),
          TextField(controller:_emailController,
          decoration:InputDecoration(labelText:"Email", border:OutlineInputBorder()),
          ),
          const SizedBox(height:16.0),
          SizedBox(
            width: double.infinity,
            height: 58,
            child:ElevatedButton(onPressed: (){
              final newUser=UserEntity(
                id: isEditing ?widget.user!.id :DateTime.now().millisecondsSinceEpoch.toString(),
                name: _nameController.text,
                email: _emailController.text,
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