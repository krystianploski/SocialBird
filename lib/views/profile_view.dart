import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../router/app_router.dart';
import '../services/user_service.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserService>().currentUser;
    final initial = user?.username.isNotEmpty == true
        ? user!.username.characters.first.toUpperCase()
        : '?';

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 44,
                  child: Text(
                    initial,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user?.username ?? 'Gość',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  user == null ? 'Nie jesteś zalogowany' : user.email,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (user != null) ...[
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: () => appRouter.push('/profile/edit'),
                    icon: const Icon(Icons.edit),
                    label: const Text('Edytuj profil'),
                  ),
                  if (user.displayName.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      user.displayName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                  if (user.bio.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(user.bio, textAlign: TextAlign.center),
                  ],
                  if (user.location.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on_outlined, size: 18),
                        const SizedBox(width: 6),
                        Text(user.location),
                      ],
                    ),
                  ],
                  if (user.birthDate.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.cake_outlined, size: 18),
                        const SizedBox(width: 6),
                        Text(user.birthDate),
                      ],
                    ),
                  ],
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    onPressed: () {
                      context.read<UserService>().logout();
                      appRouter.go('/login');
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Wyloguj'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
