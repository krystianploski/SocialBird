import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';
import '../view_models/post_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _submitPost() async {
    if (_contentController.text.trim().isEmpty) {
      _contentController.clear();
      _formKey.currentState!.validate();
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    final postViewModel = context.read<PostViewModel>();
    try {
      await postViewModel.createPost(_contentController.text);
    } on StateError {
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('Zaloguj się, aby opublikować post')),
      );
      return;
    } catch (error, stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'SocialBird',
          context: ErrorDescription('while saving a post'),
        ),
      );
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('Nie udało się zapisać posta')),
      );
      return;
    }

    if (!mounted) return;
    _contentController.clear();
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SocialBird')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _contentController,
                          minLines: 2,
                          maxLines: 4,
                          maxLength: PostModel.maxContentLength,
                          decoration: const InputDecoration(
                            labelText: 'O czym myślisz?',
                            hintText: 'Napisz nowy post',
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                          ),
                          validator: (value) {
                            final content = value?.trim() ?? '';
                            if (content.isEmpty) {
                              return 'Treść posta nie może być pusta';
                            }
                            if (content.length > PostModel.maxContentLength) {
                              return 'Post może mieć maksymalnie '
                                  '${PostModel.maxContentLength} znaków';
                            }
                            return null;
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FilledButton.icon(
                            onPressed: _submitPost,
                            icon: const Icon(Icons.send),
                            label: const Text('Opublikuj'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 32),
                  Text(
                    'Najnowsze posty',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Consumer<PostViewModel>(
                      builder: (context, viewModel, child) {
                        return StreamBuilder<List<PostModel>>(
                          stream: viewModel.posts,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text('Nie udało się wczytać postów'),
                              );
                            }
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final posts = snapshot.data!;
                            if (posts.isEmpty) {
                              return const Center(
                                child: Text(
                                  'Nie ma jeszcze postów. Dodaj pierwszy!',
                                ),
                              );
                            }

                            return ListView.separated(
                              itemCount: posts.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (context, index) =>
                                  _PostCard(post: posts[index]),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = MaterialLocalizations.of(context);
    final time = localizations.formatTimeOfDay(
      TimeOfDay.fromDateTime(post.createdAt),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(post.authorName.characters.first.toUpperCase()),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.authorName, style: theme.textTheme.titleSmall),
                      Text(
                        '${post.authorHandle} · $time',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SelectableText(post.content),
          ],
        ),
      ),
    );
  }
}
