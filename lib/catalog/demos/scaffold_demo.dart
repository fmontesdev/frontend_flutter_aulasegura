import 'package:flutter/material.dart';
import 'package:frontend_flutter_aulasegura/core/widgets/app_scaffold.dart';

class ScaffoldDemo extends StatelessWidget {
  final bool modoOscuro;
  final ValueChanged<bool> onCambioModoOscuro;

  const ScaffoldDemo({
    super.key,
    required this.modoOscuro,
    required this.onCambioModoOscuro,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Container(),
    );
  }
}
