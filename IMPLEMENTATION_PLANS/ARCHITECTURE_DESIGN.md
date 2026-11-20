# Ejary Platform — Architecture Design Blueprint

**Project:** Ejary (`ejary_app`)  
**Architecture:** Clean Architecture + Feature-First + Repository Pattern  
**Framework:** Flutter (3.50.0) / Dart (3.14.0)  
**State Management & DI:** GetX  
**Document Type:** Technical & Structural Architecture Blueprint  
**Reference:** `IMPLEMENTATION_PLANS/IMPLEMENTATION_PLAN.md`  
**Status:** Approved for Implementation  
**Last Updated:** 2026-11-20  

---

## 1. Architectural Philosophy & Layer Separation

The application strictly implements **Clean Architecture** organized with a **Feature-First** approach. This guarantees separation of concerns, testability, maintainability, and clean boundaries between business rules, data access, and UI rendering.

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                       │
│    (Widgets, Screens, GetxControllers, Bindings, Obx)       │
└──────────────────────────────┬──────────────────────────────┘
                               │ depends on
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                      Domain Layer                           │
│     (Pure Dart: Entities, Repository Contracts, Use Cases)   │
└──────────────────────────────▲──────────────────────────────┘
                               │ implements contract
┌──────────────────────────────┴──────────────────────────────┐
│                       Data Layer                            │
│  (Data Sources, DTO Models, Repository Implementations, Mappers)
└─────────────────────────────────────────────────────────────┘
```

### Layer Rules:

1. **Domain Layer (`domain/`):**
   - **Zero external framework dependencies:** Must not import `package:flutter/...` or `package:get/...` (presentation classes).
   - Contains immutable **Entities**, abstract **Repository contracts** (`abstract class PropertyRepository`), and focused **Use Cases** (`GetPropertiesUseCase`, `SubmitRentalApplicationUseCase`).
   - Represents the core business logic and rules of the Ejary leasing model.

2. **Data Layer (`data/`):**
   - Implements Domain repository contracts (`class PropertyRepositoryImpl implements PropertyRepository`).
   - Handles data serialization/deserialization with `Model` classes extending or mapping to Domain entities.
   - Manages **Data Sources** (e.g., `MockPropertyDataSource` with rich Arabic & English seed listings, and `LocalRentalDataSource` with storage persistence).

3. **Presentation Layer (`presentation/`):**
   - Widgets are strictly declarative and handle user rendering and interactions.
   - **GetxControllers** manage view state, coordinate use cases, handle errors, and expose reactive properties (`.obs`) or state mixins (`StateMixin`).
   - **Bindings** wire controllers, use cases, and repositories lazily via `Get.lazyPut`.

---

## 2. Directory Structure Map

```text
lib/
├── main.dart                          # Application entry point
│
├── app/                               # Global application configuration
│   ├── app.dart                       # Root GetMaterialApp widget
│   ├── bindings/
│   │   └── initial_binding.dart       # Global dependency registrations
│   ├── routes/
│   │   ├── app_pages.dart             # GetPage route definitions with bindings
│   │   └── app_routes.dart            # Centralized route name constants
│   └── translations/
│       ├── app_translations.dart      # GetX Translations dictionary root
│       ├── ar_translation.dart        # Comprehensive Arabic translations
│       └── en_translation.dart        # Comprehensive English translations
│
├── core/                              # Shared cross-cutting components
│   ├── constants/
│   │   ├── app_colors.dart            # Brand and semantic color palette
│   │   ├── app_constants.dart         # Storage keys, assets, defaults
│   │   └── app_typography.dart        # Cairo/Tajawal font style definitions
│   ├── errors/
│   │   ├── exceptions.dart            # Data source exceptions
│   │   └── failures.dart              # Domain failure abstractions
│   ├── services/
│   │   └── storage_service.dart       # GetxService wrapping GetStorage
│   ├── theme/
│   │   ├── app_theme.dart             # ThemeData builder
│   │   ├── light_theme.dart           # Light Material 3 theme palette
│   │   ├── dark_theme.dart            # Dark Material 3 theme palette
│   │   └── theme_controller.dart      # Theme switcher & persistence controller
│   ├── utils/
│   │   ├── currency_formatter.dart    # SAR currency formatting (RTL/LTR)
│   │   └── date_formatter.dart        # Gregorian & Hijri date display
│   └── widgets/
│       ├── app_button.dart            # Primary and secondary branded buttons
│       ├── app_text_field.dart        # Validated input fields with prefix icons
│       ├── empty_state_view.dart      # Illustrated empty state widget
│       ├── error_state_view.dart      # Error state with retry callback
│       ├── loading_indicator.dart     # Consistent progress/shimmer indicator
│       └── property_card.dart         # Reusable property card with tags
│
└── features/                          # Feature-First modules
    ├── auth/                          # Authentication & user session
    │   ├── domain/
    │   │   ├── entities/user_entity.dart
    │   │   └── repositories/auth_repository.dart
    │   ├── data/
    │   │   ├── datasources/auth_datasource.dart
    │   │   ├── models/user_model.dart
    │   │   └── repositories/auth_repository_impl.dart
    │   └── presentation/
    │       ├── bindings/auth_binding.dart
    │       ├── controllers/auth_controller.dart
    │       └── pages/
    │           ├── login_page.dart
    │           └── register_page.dart
    │
    ├── properties/                    # Property discovery & listings
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   ├── property_entity.dart
    │   │   │   └── property_filter.dart
    │   │   ├── repositories/property_repository.dart
    │   │   └── usecases/
    │   │       ├── get_properties_usecase.dart
    │   │       ├── get_property_by_id_usecase.dart
    │   │       └── add_property_usecase.dart
    │   ├── data/
    │   │   ├── datasources/property_mock_datasource.dart
    │   │   ├── models/property_model.dart
    │   │   └── repositories/property_repository_impl.dart
    │   └── presentation/
    │       ├── bindings/property_binding.dart
    │       ├── controllers/
    │       │   ├── explore_controller.dart
    │       │   ├── property_details_controller.dart
    │       │   └── add_property_controller.dart
    │       ├── pages/
    │       │   ├── explore_page.dart
    │       │   ├── property_details_page.dart
    │       │   └── add_property_page.dart
    │       └── widgets/
    │           ├── category_filter_bar.dart
    │           ├── property_spec_badge.dart
    │           └── amenity_chip.dart
    │
    ├── rentals/                       # Rental requests & lease contracts
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   ├── rental_application_entity.dart
    │   │   │   └── lease_contract_entity.dart
    │   │   ├── repositories/rental_repository.dart
    │   │   └── usecases/
    │   │       ├── submit_rental_application_usecase.dart
    │   │       ├── get_my_rentals_usecase.dart
    │   │       └── pay_installment_usecase.dart
    │   ├── data/
    │   │   ├── datasources/rental_datasource.dart
    │   │   ├── models/
    │   │   │   ├── rental_application_model.dart
    │   │   │   └── lease_contract_model.dart
    │   │   └── repositories/rental_repository_impl.dart
    │   └── presentation/
    │       ├── bindings/rental_binding.dart
    │       ├── controllers/
    │       │   ├── rental_apply_controller.dart
    │       │   ├── my_rentals_controller.dart
    │       │   └── contract_details_controller.dart
    │       └── pages/
    │           ├── rental_apply_page.dart
    │           ├── my_rentals_page.dart
    │           └── contract_details_page.dart
    │
    ├── shell/                         # Main navigation scaffold
    │   └── presentation/
    │       ├── bindings/main_binding.dart
    │       ├── controllers/main_controller.dart
    │       └── pages/main_page.dart
    │
    └── profile/                       # User profile & preferences
        └── presentation/
            ├── controllers/profile_controller.dart
            └── pages/profile_page.dart
```

---

## 3. Dependency Injection Strategy

GetX is the dependency injection container. Registration follows a strict lifecycle:

### 3.1 InitialBinding (Global Long-Lived Services)
Registered at `main()` startup via `GetMaterialApp.initialBinding`:
```dart
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Core Services (GetxService - permanent)
    Get.put<StorageService>(StorageService(), permanent: true);
    
    // 2. Global Controllers
    Get.put<ThemeController>(ThemeController(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}
```

### 3.2 Feature Bindings (Lazy Lifecycle)
Registered per route in `AppPages`. Dependencies are instantiated only when the route is pushed and disposed when popped:
```dart
class PropertyBinding extends Bindings {
  @override
  void dependencies() {
    // Data Source & Repository
    Get.lazyPut<PropertyRepository>(() => PropertyRepositoryImpl(dataSource: Get.find()));
    
    // Use Cases
    Get.lazyPut(() => GetPropertiesUseCase(Get.find()));
    Get.lazyPut(() => GetPropertyByIdUseCase(Get.find()));
    
    // Controller
    Get.lazyPut(() => ExploreController(getPropertiesUseCase: Get.find()));
  }
}
```

---

## 4. State Management Conventions

1. **Reactive State (`.obs` & `Obx`):**
   - Used for lightweight dynamic state (active category index, search query, theme mode, language locale, calculated installment amount).
   - Keeps UI rebuilt only where the exact observable changes.

2. **Async State (`StateMixin<T>`):**
   - Used for asynchronous resource loading (e.g. `ExploreController` loading property listings, `MyRentalsController` fetching contracts).
   - Out-of-the-box support for:
     - `controller.obx( (state) => SuccessView(), onLoading: LoadingView(), onEmpty: EmptyView(), onError: (err) => ErrorView(err) )`

3. **Separation of Business Logic:**
   - Widgets never execute business logic, validation algorithms, or direct data access.
   - All actions delegate directly to controller methods (e.g. `controller.onCategorySelected(category)`).

---

## 5. Routing & Middleware Architecture

Route names are centralized in `AppRoutes`:

```dart
abstract class AppRoutes {
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const MAIN = '/main';
  static const PROPERTY_DETAILS = '/property-details';
  static const RENTAL_APPLY = '/rental-apply';
  static const CONTRACT_DETAILS = '/contract-details';
  static const ADD_PROPERTY = '/add-property';
}
```

`AppPages` links routes with their views and bindings:
- Named navigation is used everywhere via `Get.toNamed(AppRoutes.PROPERTY_DETAILS, arguments: property)`.
- Route parameters and arguments are typed and validated inside controllers.

---

## 6. Localization & RTL Architecture

1. **GetX Translations:**
   `AppTranslations` implements `Translations` with key-value maps for `ar` and `en`.
2. **Text Directionality:**
   - Arabic (`ar_SA`) automatically enforces right-to-left layout (`TextDirection.rtl`).
   - English (`en_US`) enforces left-to-right layout (`TextDirection.ltr`).
   - Icons with directional meaning (back arrows, disclosure chevrons) dynamically adapt using `Icons.arrow_back` or mirrored widgets.
3. **Typography:**
   - Uses legible modern Arabic typography with clean fallback fonts.
4. **Persistence:**
   - Selected language stored in `GetStorage` under key `AppConstants.KEY_LANGUAGE`.
   - On cold start, `StorageService` reads the saved locale or defaults to `ar_SA`.

---

## 7. Themes & Visual Design Architecture

Material 3 `ThemeData` provides uniform styling:
- **Light Theme:** Clean pearl background (`#F8F9FA`), deep navy primary (`#1A365D`), emerald green accent for Ejary identity (`#00A86B`), crisp white cards with soft elevation.
- **Dark Theme:** Deep slate background (`#121820`), dark surface cards (`#1E2632`), soft teal/emerald accents (`#00D084`), high-contrast accessible text (`#E2E8F0`).
- **Persistence:** Stored in `GetStorage` under key `AppConstants.KEY_THEME_MODE` (`light` / `dark`).
- **Dynamic Switching:** `ThemeController.toggleTheme()` updates both active runtime theme and persistent storage.

---

## 8. Build Order & Implementation Roadmap

```
Phase 2: Foundation
  ├── 1. pubspec.yaml dependencies (get, get_storage)
  ├── 2. Core constants, errors, and failure models
  ├── 3. StorageService & Preferences abstraction
  └── 4. AppRoutes, AppPages, InitialBinding, main.dart

Phase 3: Global Services & Persistence
  ├── 1. GetStorage initialization
  └── 2. Theme & Locale persistence controllers

Phase 4: Localization & Themes
  ├── 1. Arabic & English dictionaries (200+ keys)
  └── 2. Light & Dark ThemeData configurations

Phase 5: Feature Implementation
  ├── Feature 1: Auth & User Session (Entities, Repo, Controllers, Login/Register)
  ├── Feature 2: Properties (Entities, Mock Data Source, ExploreController, ExplorePage, DetailsPage)
  ├── Feature 3: Rentals & Contracts (ApplyPage, MyRentalsPage, ContractDetailsPage)
  ├── Feature 4: Landlord Management (AddPropertyPage, MyPropertiesView)
  └── Feature 5: Shell & Profile (MainNavigation, ProfilePage)

Phase 6: Integration & Middleware
  └── Route verification, back-stack hygiene, role switcher

Phase 7: Testing & Verification
  ├── Unit tests for UseCases & Repositories
  ├── Widget tests for core screens
  └── flutter analyze & flutter test verification

Phase 8: Final Review & Git Checkpointing
  └── Update Graphify, documentation, commit & push to GitHub
```
