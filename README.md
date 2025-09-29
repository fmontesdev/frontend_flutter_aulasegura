# Frontend Flutter AulaSegura

## Estructura del proyecto (Clean Architecture)

`lib/app/` → contiene la configuración global de la aplicación (MaterialApp, rutas y temas).
- `lib/app/theme/` → contiene Temas de la aplicación.
---
`lib/core/` → contiene recursos Comunes y reutilizables.
- `lib/core/errors/` → contiene Excepciones y Failures comunes.
- `lib/core/utils/` → contiene funciones Helper y Formatos.
- `lib/core/widgets/` → contiene Widgets reutilizables en todo el proyecto.
- `lib/core/l10n/` → contiene archivos de Localización/Internacionalización (.arb).
---
`lib/features/` → contiene los Módulos/Funcionalidades de toda la aplicación.
- `lib/features/example/data/` → capa de Datos. Contiene fuentes de datos, modelos y implementaciones de repositorios.
    -  `lib/features/example/data/datasources/` → contiene Fuentes de Datos.
    - `lib/features/example/data/models/` → contiene Modelos.
    - `lib/features/example/data/repositories/` → contiene Implementaciones de Repositorios.
---
- `lib/features/example/domain/` → capa de Dominio. Contiene entidades, abstracciones de repositorios y casos de uso.
    - `lib/features/example/domain/entities/` → contiene Entidades.
    - `lib/features/example/domain/repositories/` → contiene Abstracciones de Repositorios.
    - `lib/features/example/domain/usecases/` → contiene Casos de Uso.
---
- `lib/features/example/presentation/` → capa de Presentación. Contiene páginas, widgets y controladores.
    - `lib/features/example/presentation/pages/` → contiene Páginas.
    - `lib/features/example/presentation/widgets/` → contiene Widgets.
    - `lib/features/example/presentation/providers/` → contiene Controladores.
---
`lib/catalog/` → contiene Catálogo de componentes reutilizables de toda la aplicación.
- `lib/catalog/widgets/` → contiene Catálogo de Widgets que se reutiliza en todas las demos.
- `lib/catalog/demos/` → contiene una pantalla por tipo de componente (ejemplos con diferentes variantes y estados).
---
`assets/` → imágenes, íconos y recursos estáticos.

## Dependencias utilizadas

[Riverpod 3.0.0](https://pub.dev/packages/flutter_riverpod) → gestor de estado reactivo.  
[GoRouter 16.2.4](https://pub.dev/packages/go_router) → navegación/enrutado declarativo y avanzado.  
[Equatable 2.0.7](https://pub.dev/packages/equatable) → comparación de objetos por valor (útil en estados).  
[Intl 0.20.2](https://pub.dev/packages/intl) → internacionalización y formatos (fechas, números, traducciones).  
[Flutter Lints 6.0.0](https://pub.dev/packages/flutter_lints) → reglas de estilo y buenas prácticas.  