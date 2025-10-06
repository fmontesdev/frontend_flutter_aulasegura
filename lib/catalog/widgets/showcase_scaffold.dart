import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

class ShowcaseScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  const ShowcaseScaffold({super.key, required this.title, required this.body});

  @override
  State<ShowcaseScaffold> createState() => _ShowcaseScaffoldState();
}

class _ShowcaseScaffoldState extends State<ShowcaseScaffold> {
  bool dark = false;

  @override
  Widget build(BuildContext context) {
    final theme = dark ? AppTheme.dark : AppTheme.light;

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: false,
          actions: [
            IconButton(
              tooltip: dark ? 'Tema claro' : 'Tema oscuro',
              icon: Icon(dark ? Icons.dark_mode : Icons.light_mode),
              onPressed: () => setState(() => dark = !dark),
            ),
          ],
        ),
        body: widget.body,
      ),
    );
  }
}
