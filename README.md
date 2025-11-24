# AulaSegura - Frontend Flutter

<div align="center">

[![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart)](https://dart.dev)
[![Riverpod](https://img.shields.io/badge/Riverpod-3.0.0-00A9FF)](https://riverpod.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

</div>

## 📋 Descripción

**AulaSegura** es una aplicación móvil multiplataforma que permite a profesores y personal educativo gestionar el acceso a aulas y espacios mediante tecnologías **QR**, **NFC** y **RFID**. El sistema incluye gestión de reservas, horarios, permisos de acceso y seguimiento en tiempo real.

### Funcionalidades principales

🔐 **Autenticación segura** - Login con JWT (access y refresh tokens)  
📱 **Acceso por QR** - Escaneo de códigos QR en puertas de aulas  
🏷️ **Acceso por RFID/NFC** - Control de acceso mediante tags RFID y NFC
📅 **Reservas de aulas** - Sistema completo de reserva de espacios  
🕒 **Gestión de horarios** - Visualización de horarios semanales y eventos  
👤 **Perfil de usuario** - Edición de datos y foto de perfil  
🌍 **Multiidioma** - Soporte completo para Español, Catalán e Inglés  
🎨 **Temas personalizables** - Sistema de diseño consistente y moderno  
🔔 **Notificaciones** - Gestión de notificaciones en tiempo real  
🗺️ **Mapa interactivo** - Visualización de ubicación de aulas (próximamente)

---

## 🛠️ Tecnologías

### Core

- **[Flutter](https://flutter.dev) 3.9.2** - Framework UI multiplataforma de Google
- **[Dart](https://dart.dev) 3.9.2** - Lenguaje de programación optimizado para UI
- **[Riverpod](https://riverpod.dev) 3.0.0** - Gestión de estado reactiva y robusta
- **[GoRouter](https://pub.dev/packages/go_router) 16.2.4** - Navegación declarativa y routing avanzado

### Networking & Storage

- **[Dio](https://pub.dev/packages/dio) 5.9.0** - Cliente HTTP potente con interceptores
- **[Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage) 9.2.4** - Almacenamiento seguro de tokens y credenciales
- **[Shared Preferences](https://pub.dev/packages/shared_preferences) 2.5.3** - Persistencia local de preferencias
- **[Cached Network Image](https://pub.dev/packages/cached_network_image) 3.4.1** - Carga y caché de imágenes

### Features específicas

- **[Mobile Scanner](https://pub.dev/packages/mobile_scanner) 7.1.3** - Escaneo de códigos QR y barcodes
- **[Image Picker](https://pub.dev/packages/image_picker) 1.2.1** - Selección de imágenes desde cámara/galería
- **[Flutter Image Compress](https://pub.dev/packages/flutter_image_compress) 2.4.0** - Compresión de imágenes
- **[Path Provider](https://pub.dev/packages/path_provider) 2.1.5** - Acceso a directorios del sistema
- **[Table Calendar](https://pub.dev/packages/table_calendar) 3.2.0** - Widget de calendario personalizable
- **[Lottie](https://pub.dev/packages/lottie) 3.3.2** - Animaciones JSON de alta calidad

### Internacionalización

- **[Flutter Localizations](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization)** - Framework de localización
- **[Intl](https://pub.dev/packages/intl) 0.20.2** - Formateo de fechas, números y traducciones

### Desarrollo

- **[Flutter Lints](https://pub.dev/packages/flutter_lints) 6.0.0** - Reglas de estilo recomendadas por Flutter
- **[Riverpod Lint](https://pub.dev/packages/riverpod_lint) 3.0.3** - Linting específico para Riverpod
- **[Flutter Dotenv](https://pub.dev/packages/flutter_dotenv) 6.0.0** - Gestión de variables de entorno

---

## 🏗️ Arquitectura

El proyecto sigue **Clean Architecture** (Arquitectura Limpia) con separación clara de responsabilidades:

```
lib/
├── main.dart                    # Entry point de la aplicación
├── app/                         # Configuración global
│   ├── router/                  # Configuración de GoRouter
│   └── theme/                   # Temas (light/dark)
│
├── core/                        # Recursos compartidos
│   ├── constants/               # Constantes globales
│   ├── errors/                  # Excepciones y failures
│   ├── l10n/                    # Archivos ARB (es, ca, en)
│   ├── services/                # Servicios globales (avatar, image, etc.)
│   ├── utils/                   # Utilidades y helpers
│   └── widgets/                 # Widgets reutilizables
│
├── features/                    # Módulos funcionales
│   ├── {feature}/
│   │   ├── data/                # 📦 Capa de Datos
│   │   │   ├── datasources/     # API calls, local storage
│   │   │   ├── models/          # Modelos y DTOs
│   │   │   └── repositories/    # Implementación de repositorios
│   │   │
│   │   ├── domain/              # 💼 Capa de Dominio
│   │   │   ├── entities/        # Entidades de negocio
│   │   │   ├── repositories/    # Contratos (interfaces)
│   │   │   └── usecases/        # Casos de uso
│   │   │
│   │   └── presentation/        # 🎨 Capa de Presentación
│   │       ├── pages/           # Pantallas completas
│   │       ├── providers/       # Riverpod providers
│   │       └── widgets/         # Widgets específicos del módulo
│
└── catalog/                     # Design System
    ├── widgets/                 # Catálogo de componentes base
    └── demos/                   # Ejemplos y documentación visual
```

### Módulos principales (Features)

| Módulo | Descripción |
|--------|-------------|
| **auth** | Autenticación y autorización (login, logout, refresh token) |
| **home** | Dashboard principal con accesos rápidos |
| **profile** | Gestión de perfil y cambio de avatar |
| **access** | Sistema de acceso por QR y NFC (escaneo y validación) |
| **reservations** | Creación y gestión de reservas de aulas |
| **schedules** | Visualización de horarios semanales y eventos |
| **notifications** | Sistema de notificaciones |
| **map** | Mapa interactivo de aulas (en desarrollo) |

### Flujo de datos (Clean Architecture)

```
Presentation → Domain → Data → API/Storage
    ↓           ↓        ↓         ↓
  Pages    UseCases  Repository  DataSource
    ↓           ↓        ↓         ↓
 Providers  Entities  Models    Dio/SecureStorage
```

**Ventajas:**
- ✅ Testabilidad máxima (cada capa independiente)
- ✅ Escalabilidad (fácil agregar features sin afectar otros módulos)
- ✅ Mantenibilidad (cambios en API no afectan la lógica de negocio)
- ✅ Reusabilidad (domain entities y use cases compartibles)

---

## 🚀 Instalación y Arranque

### Prerrequisitos

- **Flutter SDK** 3.9.2 o superior ([Instalación](https://docs.flutter.dev/get-started/install))
- **Dart SDK** 3.9.2 o superior (incluido con Flutter)
- **Android Studio** / **Xcode** (para emuladores)
- **VS Code** o **Android Studio** (recomendado)
- **Backend AulaSegura** corriendo en `http://localhost:8000` ([Repositorio](https://github.com/fmontesdev/backend_nestjs_aulasegura))

### 1. Clonar el repositorio

```bash
git clone https://github.com/fmontesdev/frontend_flutter_aulasegura.git
cd frontend_flutter_aulasegura
```

### 2. Instalar dependencias

```bash
flutter pub get
```

### 3. Configurar variables de entorno

Crea un archivo `.env` en la raíz del proyecto:

```env
# Backend API URL
API_BASE_URL=http://localhost:8000

# Image Server URL (Nginx)
IMAGE_SERVER_URL=http://localhost:8090

# Environment
ENVIRONMENT=development
```

### 4. Generar archivos de localización

```bash
flutter gen-l10n
```

### 5. Ejecutar la aplicación

```bash
# En modo debug
flutter run

# En un dispositivo específico
flutter run -d <device-id>

# Ver dispositivos disponibles
flutter devices
```

### 6. Build para producción

```bash
# Android APK
flutter build apk --release

# Android App Bundle (para Play Store)
flutter build appbundle --release

# iOS (requiere macOS y Xcode)
flutter build ios --release
```

---

## 👥 Usuarios de prueba

Los siguientes usuarios están disponibles en el backend seeders:

| Email | Contraseña | Rol | Descripción |
|-------|------------|-----|-------------|
| `admin@gva.es` | `AulaSegura@1234` | Administrador | Acceso completo al sistema |
| `teacher@gva.es` | `AulaSegura@1234` | Profesor | Luis Torregrosa Pérez |
| `pagado@gva.es` | `AulaSegura@1234` | Profesor | Paco García Donat |
| `janitor@gva.es` | `AulaSegura@1234` | Conserje | Marta Fernández Ruiz |
| `staff@gva.es` | `AulaSegura@1234` | Personal | Eva Mendes López |

---

## 📱 Características destacadas

### 🔐 Sistema de Control de Acceso

AulaSegura implementa un sistema de control de acceso multi-tecnología:

#### 📱 Acceso por QR (✅ Implementado)

Sistema simplificado de acceso mediante escaneo de códigos QR:

1. **Escaneo**: Usuario presiona "Acceso QR" y abre la cámara
2. **Detección**: La app detecta el código QR de la puerta del aula
3. **Validación**: Envía petición al backend `/access/check`
4. **Resultado**: Muestra acceso permitido/denegado con animación

**Características técnicas:**
- Cámara fullscreen con overlay de guías visuales
- Detección sin duplicados (DetectionSpeed.noDuplicates)
- Botón de linterna para entornos oscuros
- BottomSheet con resultados animados (Lottie)
- Estados: processing → success/denied/error

📄 [Documentación completa](docs/QR_ACCESS_SYSTEM.md)

#### 🏷️ Acceso por RFID/NFC (🚧 En desarrollo)

Sistema avanzado de control de acceso mediante tags RFID y tarjetas NFC:

**Características planificadas:**
- **Lectura NFC**: Detección automática de tags y tarjetas NFC
- **RFID Reader**: Integración con lectores RFID externos
- **Multi-método**: Compatibilidad con QR, NFC y RFID simultáneamente
- **Validación en tiempo real**: Verificación instantánea de permisos
- **Gestión de tags**: Asociación de múltiples tags por usuario
- **Logs de acceso**: Registro detallado con timestamp y ubicación

**Tecnologías objetivo:**
- HCE (Host Card Emulation) para Android
- Core NFC para iOS (requiere iPhone 7 o superior)
- Integración con backend `/access/check` usando `accessMethod: "NFC"` o `"RFID"`

**Tags de prueba disponibles en backend:**

| Usuario | Tag RFID | Tag NFC |
|---------|----------|---------|
| Ana Morales (admin) | `00AABBCCDDEE11` | `2d45b6416a5929c7085754f2a7635eb4` |
| Marta Fernández (janitor) | `00AABBCCDDEE22` | `f70c19bcf21ccfb08ad758b07e6f9a7c` |
| Paco García (teacher) | `00AABBCCDDEE33` | `a35dda264047067599ad9773f8345fd6` |
| Luis Torregrosa (teacher) | `00AABBCCDDEE44` | `aa6a9afe8029f1a5a19b95f927d68db4` |
| Eva Mendes (staff) | `00AABBCCDDEE55` | `0ff84eccc8347c78a5c8a4991e242115` |

📄 [Documentación NFC/RFID](docs/NFC_HCE_SETUP.md)

### 📅 Sistema de Reservas

Gestión completa de reservas de aulas con calendario interactivo:

- **Calendario visual**: Selección de fecha con `table_calendar`
- **Selector de horario**: Slider para elegir franja horaria
- **Filtrado por estado**: Aprobadas, Pendientes, Revocadas
- **Validaciones**: Disponibilidad en tiempo real
- **Eliminación**: Borrado de reservas con confirmación

### 👤 Gestión de Perfil

Edición de información personal y foto de avatar:

- **Cambio de avatar**: Cámara o galería con compresión automática
- **Validaciones**: Máx 5MB, formatos jpg/jpeg/png/webp
- **Compresión**: Optimización automática si excede 1MB
- **Subida segura**: Upload con `multipart/form-data`
- **Actualización en tiempo real**: Refleja cambios inmediatamente

### 🌍 Internacionalización (i18n)

Soporte completo para 3 idiomas:

- 🇪🇸 **Español** (es)
- 🇪🇸 **Catalán** (ca)
- 🇬🇧 **Inglés** (en)

**Archivos**: `lib/core/l10n/app_{es,ca,en}.arb`

Características:
- Cambio de idioma en tiempo real
- Formateo de fechas y números localizado
- Plurales y géneros gestionados con `intl`
- Select patterns para mensajes dinámicos

---

## 🎨 Design System

El proyecto incluye un **catálogo visual** de componentes en `lib/catalog/` con más de 25 widgets reutilizables.

### Componentes base (core/widgets)

#### Navegación y Layout
- **AppMainScaffold** - Scaffold principal con navegación inferior integrada
- **AppOverlayScaffold** - Scaffold con overlay para pantallas modales
- **AppBottomNav** - Barra de navegación inferior con íconos y estados activos
- **AppFab** - Floating Action Buttons con variantes (primary, secondary)
- **AppFabHideOnScroll** - FAB que se oculta automáticamente al hacer scroll

#### Botones y Controles
- **AppButton** - Botones con variantes (primary, secondary, tertiary) y tamaños (sm, md, lg, xl)
- **AppSnackbarButton** - Botones específicos para SnackBars
- **AppLink** - Enlaces con estilo consistente y navegación
- **AppIconOptionTile** - Tiles con ícono para menús de opciones

#### Tarjetas y Contenedores
- **AppCard** - Tarjetas con elevación y bordes personalizables
- **AppEmptyCard** - Tarjeta para estados vacíos con ilustración y mensaje
- **AppScheduleCard** - Tarjeta especializada para mostrar horarios

#### Selectores y Filtros
- **AppFilterSelector** - Selector de filtros con chips deslizables
- **AppSliderSelector** - Slider para selección de rangos numéricos
- **AppPill** - Pills decorativos para etiquetas y estados
- **AppSelectablePill** - Pills seleccionables con estado activo/inactivo
- **AppSelectableTile** - Items seleccionables para listas y modales
- **AppCheckItem** - Items con checkbox integrado

#### Formularios
- **AppTextFormField** - Campos de texto con validación, prefijos y sufijos
- **AppModalOptions** - Contenedor modal reutilizable con lista de opciones

#### Listas y Calendarios
- **AppList** - Listas inteligentes con estados (carga, error, vacío, datos)
- **AppTableCalendar** - Calendario de tabla personalizable con selección de fechas
- **AppTimeslotPill** - Pills para mostrar franjas horarias

#### Tipografía
- **AppSectionTitle** - Títulos de sección con estilo consistente

### Acceso al catálogo

Desde la aplicación, navega a **Perfil → Catálogo** para ver todos los componentes con sus variantes, estados y ejemplos de uso interactivos.

**Ruta de desarrollo**: `/catalog`

---

## 📂 Estructura de Assets

```
assets/
├── animations/              # Animaciones Lottie (JSON)
│   ├── error.json
│   ├── success.json
│   └── ...
├── fonts/                   # Fuentes personalizadas
│   ├── Montserrat/
│   │   ├── Montserrat-VariableFont_wght.ttf
│   │   └── Montserrat-Italic-VariableFont_wght.ttf
│   └── Archivo_Black/
│       └── ArchivoBlack-Regular.ttf
└── images/
    └── logo.png
```

---

## 🔧 Desarrollo

### Comandos útiles

```bash
# Limpiar build
flutter clean

# Analizar código
flutter analyze

# Formatear código
dart format .

# Ver dependencias obsoletas
flutter pub outdated

# Actualizar dependencias
flutter pub upgrade

# Generar archivos (l10n, assets)
flutter pub run build_runner build
```

## 🐛 Debugging

### Modo debug

```bash
# Con hot reload
flutter run

# Con DevTools
flutter run --observatory-port=9200
```

### Inspección de estado

La aplicación usa **Riverpod DevTools** para inspección de estado en tiempo real:

```bash
# Habilitar Riverpod Inspector
flutter pub add dev:riverpod_generator
flutter pub add dev:build_runner
```

---

## 📝 Convenciones de Código

### Nomenclatura

- **Archivos**: `snake_case.dart`
- **Clases**: `PascalCase`
- **Variables/funciones**: `camelCase`
- **Constantes**: `camelCase` o `SCREAMING_SNAKE_CASE`
- **Providers**: `camelCaseProvider`

## 🔗 Enlaces

- **Backend**: [backend_nestjs_aulasegura](https://github.com/fmontesdev/backend_nestjs_aulasegura)
- **Documentación Flutter**: [flutter.dev/docs](https://flutter.dev/docs)
- **Riverpod**: [riverpod.dev](https://riverpod.dev)
- **GoRouter**: [gorouter.dev](https://gorouter.dev)

---

<div align="center">

**Desarrollado usando Flutter**

</div>  