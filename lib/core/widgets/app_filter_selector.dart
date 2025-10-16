import 'package:flutter/material.dart';

class AppFilterSelector extends StatelessWidget {
  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final double height;

  const AppFilterSelector({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
    this.height = 38,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: Material(
        color: scheme.secondary.withValues(alpha: 0.15), // fondo “píldora”
        borderRadius: BorderRadius.circular(25),
          child: Row(
            children: List.generate(options.length, (i) {
              final selected = i == selectedIndex;

              return Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () => onChanged(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      height: height,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected ? scheme.secondary : Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        options[i],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: selected ? scheme.onSecondary : scheme.onSurface,
                            ),
                      ),
                    ),
                  ),
              );
            }),
          ),
      ),
    );
  }
}

