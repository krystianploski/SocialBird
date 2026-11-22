import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';
import '../view_models/post_view_model.dart';
import '../view_models/quote_view_model.dart';
import '../view_models/theme_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(context.read<QuoteViewModel>().fetchRandomQuote());
      }
    });
  }

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
    final quoteViewModel = context.read<QuoteViewModel>();
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
    unawaited(quoteViewModel.fetchRandomQuote());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SocialBird'),
        actions: [
          Consumer<ThemeViewModel>(
            builder: (context, themeViewModel, child) => IconButton(
              tooltip: themeViewModel.isDarkMode
                  ? 'Włącz jasny motyw'
                  : 'Włącz ciemny motyw',
              onPressed: themeViewModel.toggleTheme,
              icon: Icon(
                themeViewModel.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _Inspiration(),
                  const SizedBox(height: 12),
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

class _Inspiration extends StatelessWidget {
  const _Inspiration();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Consumer<QuoteViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const SizedBox(
                height: 72,
                child: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              );
            }

            if (viewModel.hasError || viewModel.quote == null) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Nie udało się pobrać inspiracji.',
                    style: theme.textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () => unawaited(viewModel.fetchRandomQuote()),
                    child: const Text('Spróbuj ponownie'),
                  ),
                ],
              );
            }

            final quote = viewModel.quote!;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '✦ Inspiracja ✦',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '"${quote.content}"',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontFamily: 'serif',
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '— ${quote.author}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
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
