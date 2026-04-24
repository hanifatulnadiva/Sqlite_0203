import 'package:flutter/material.dart';
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
    return Scaffold();
  }
}