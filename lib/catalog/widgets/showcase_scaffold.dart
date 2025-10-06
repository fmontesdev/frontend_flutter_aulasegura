import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/app/theme/app_theme.dart';

class ShowcaseScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  final bool modoOscuro;
  final ValueChanged<bool> onCambioModoOscuro;

  const ShowcaseScaffold({
    super.key,
    required this.title,
    required this.body,
    required this.modoOscuro,
    required this.onCambioModoOscuro,
  });

  @override
  State<ShowcaseScaffold> createState() => _ShowcaseScaffoldState();
}

class _ShowcaseScaffoldState extends State<ShowcaseScaffold> {
  late bool _modoOscuroLocal;

  @override
  void initState() {
    super.initState();
    _modoOscuroLocal = widget.modoOscuro;
  }

  Future<void> _alternarModoOscuro(bool valor) async {
    setState(() => _modoOscuroLocal = valor);
    widget.onCambioModoOscuro(valor);
  }

  @override
  Widget build(BuildContext context) {
    final theme = _modoOscuroLocal ? AppTheme.dark : AppTheme.light;

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: false,
          actions: [
            IconButton(
              tooltip: _modoOscuroLocal ? 'Tema claro' : 'Tema oscuro',
              icon: Icon(_modoOscuroLocal ? Icons.dark_mode : Icons.light_mode),
              onPressed: () => _alternarModoOscuro(!_modoOscuroLocal),
            ),
          ],
        ),
        body: widget.body,
      ),
    );
  }
}
