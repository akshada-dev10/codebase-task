import 'package:codebase_task/di/module/repository_network_module.dart';
import 'package:codebase_task/utils/app_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codebase_task/domain/entity/user_entities.dart';
import 'package:go_router/go_router.dart';


class UserListScreen extends ConsumerStatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User List")),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.watch(userStreamProvider.stream);
        },
        child: AppStreamBuilder<List<User>>(
          stream: ref.watch(userStreamProvider.stream),
          initialData: [],
          busyBuilder: (context) => Center(child: CircularProgressIndicator()),
          errorBuilder: (context, error) => Center(child: Text("Error: $error")),
          dataBuilder: (context, users) {
            final filteredUsers = users?.where((user) =>
            user.firstName!.toLowerCase().contains(searchQuery.toLowerCase()) ||
                user.lastName!.toLowerCase().contains(searchQuery.toLowerCase())).toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[300],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredUsers?.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsers?[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          onTap: (){
                            context.pushNamed(
                              'userDetails',
                              extra: users?[index],
                            );
                          },
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              user?.profilePicture ??
                                  "https://i.pravatar.cc/150?img=${index + 1}",
                            ),
                          ),
                          title: Text(
                            '${user?.firstName} ${user?.lastName}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
