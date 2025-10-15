import 'package:flutter/material.dart';

class AppBottomNav extends StatefulWidget {
  final bool isOverlayPage;
  final ValueChanged<String>? onChanged;
  
  const AppBottomNav({
    super.key,
    this.isOverlayPage = false,
    this.onChanged
  });

  @override
  State<AppBottomNav> createState() => _AppBottomNavState();
}

class _AppBottomNavState extends State<AppBottomNav> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  void _onTap(int i) {
    if (_currentIndex == i) return;
    setState(() => _currentIndex = i);
    widget.onChanged?.call(['Inicio', 'Mapa', 'Reservas', 'Horarios'][i]);
  }
  
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _currentIndex,
      onDestinationSelected: _onTap,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide, // Muestra solo iconos
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Inicio'
        ),
        NavigationDestination(
          icon: Icon(Icons.map_outlined),
          selectedIcon: Icon(Icons.map),
          label: 'Mapa'
        ),
        NavigationDestination(
          icon: Icon(Icons.add_circle_outline_outlined),
          selectedIcon: Icon(Icons.add_circle),
          label: 'Reservas'
        ),
        NavigationDestination(
          icon: Icon(Icons.access_time),
          selectedIcon: Icon(Icons.access_time_filled),
          label: 'Horarios'
        ),
      ],
    );
  }
}
