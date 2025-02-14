import 'package:codebase_task/domain/entity/user_entities.dart';
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
          return  UserListScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'userDetails',
            name: 'userDetails',
            builder: (BuildContext context, GoRouterState state) {

              final user = state.extra as User?;
              return UserDetailScreen(userData: user);
            },
          ),
        ],
      ),
    ],
  );
}