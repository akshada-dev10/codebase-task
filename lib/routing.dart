import 'package:codebase_task/presentation/feature/user_detail_screen.dart';
import 'package:codebase_task/presentation/feature/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouting {
  static final GoRouter router = GoRouter(
    initialLocation: '/userList',
    routes: <RouteBase>[
      GoRoute(
        path: '/userList',
        builder: (BuildContext context, GoRouterState state) {
          return const UserListScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'userDetails/:firstName/:lastName/:imageUrl/:email',
            name: 'userDetails',
            builder: (BuildContext context, GoRouterState state) {
              final firstName = state.pathParameters['firstName'] ?? 'Unknown';
              final lastName = state.pathParameters['lastName'] ?? 'User';
              final imageUrl = Uri.decodeComponent(state.pathParameters['imageUrl'] ?? '');
              final email = state.pathParameters['email'] ?? 'test@g.com';

              return UserDetailScreen(
                firstName: firstName,
                lastName: lastName,
                imageUrl: imageUrl,
                email: email,
              );
            },
          ),
        ],
      ),
    ],
  );
}