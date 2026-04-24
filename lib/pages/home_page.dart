import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite/bloc/user_bloc.dart';
import 'package:sqlite/bloc/user_event.dart';
import 'package:sqlite/bloc/user_state.dart';
import 'package:sqlite/pages/user_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB8AFAF),
      appBar: AppBar(
        title:const Text('Daftar User',
          style: TextStyle(fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFFB8AFAF),
      ),
      body:BlocBuilder<UserBloc, UserState>(
        builder: (context,state){
          if(state is UserLoading) return const Center(child: CircularProgressIndicator());
          if(state is UserLoaded && state.users.isNotEmpty){
            return ListView.builder(
              itemCount:state.users.length,
              itemBuilder: (context, index){
                final user =state.users[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 3,
                  color: const Color(0xFFF2EAE0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person, size: 18),
                            const SizedBox(width: 6),
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.email, size: 16),
                            const SizedBox(width: 6),
                            Text(user.email),
                          ],
                        ),

                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.phone, size: 16),
                            const SizedBox(width: 6),
                            Text(user.nohp ?? "-"),
                          ],
                        ),

                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.location_on, size: 16),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(user.alamat ?? "-"),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UserFormPage(user: user),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => context
                                  .read<UserBloc>()
                                  .add(DeleteUserEvent(user.id)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Belum ada User, Klik + untuk menambah.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const UserFormPage()),
        ),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      
    );
  }
}
