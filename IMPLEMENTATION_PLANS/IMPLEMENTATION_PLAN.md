# Ejary Platform — Master Implementation Plan

**Project:** Ejary (`ejary_app`)  
**Document Type:** Master Implementation Plan  
**Target Platform:** Flutter  
**Architecture:** Clean Architecture + Feature-First + Repository Pattern  
**State Management:** GetX  
**Primary AI Agent:** Antigravity — Gemini 3.8 Flash High

---

## 1. Project Objective

Build a complete, functional, maintainable, and production-oriented Flutter application for the **Ejary Platform**, following the requirements and business concept explained in the provided Arabic lecture instructions and any available project documentation.

The application must follow:

- Clean Architecture.
- Feature-First project organization.
- Domain / Data / Presentation separation.
- Repository Pattern.
- Layered application architecture.
- GetX state management and dependency injection.
- Named Routes and route middleware.
- Arabic and English localization.
- Dark and Light themes.
- Persistent user preferences using GetStorage.

The result must be a working application, not merely a UI prototype or collection of disconnected screens.

### Important requirements

1. Do not invent business requirements, screens, workflows, or user roles that are not supported by the lecture or project documentation.
2. Inspect the existing project before making changes.
3. Preserve useful existing code and configuration.
4. Implement features incrementally and verify each phase.
5. Do not consider a feature complete until its business logic, state management, navigation, and relevant UI states work together.

---

## 2. Development Environment

Use the following environment as the project's development baseline:

| Component | Version |
|---|---|
| Flutter | 3.50.0 Stable |
| Dart | 3.14.0 |
| ECC | 2.2.0 |
| Graphify | 0.9.111 |
| Caveman Skills | Installed |
| IDE / Agent | Google Antigravity |
| AI Model | Gemini 3.8 Flash High |

### Environment rules

- Use the Flutter SDK already configured on the machine.
- Do not downgrade or replace Flutter or Dart.
- Check package compatibility with Flutter 3.50.0 and Dart 3.14.0 before adding dependencies.
- Avoid unnecessary dependencies.
- Do not upgrade every dependency simply because a newer version exists.
- Keep `pubspec.lock` consistent with the selected dependencies.
- Do not introduce packages that duplicate functionality already provided by GetX or the existing project infrastructure without a clear justification.

---

## 3. AI Agent Tools and Their Responsibilities

The project already has the following tools installed.

### 3.1 Graphify 0.9.111

**Responsibility:** Codebase understanding and structural analysis.

Before implementation:

1. Inspect the Graphify integration files:
   - `.agents/rules/graphify.md`
   - `.agents/workflows/graphify.md`
2. Inspect the installed Graphify CLI using its actual help output.
3. Follow the installed integration's documented workflow.
4. Generate the initial codebase knowledge graph using the supported commands.
5. Inspect the generated graph and identify existing project structure, dependencies, and relationships.

During development:

- Update the graph after significant architectural changes when supported by the installed workflow.
- Use graph queries to understand existing code before modifying interconnected components.
- Identify potential dependency and architecture problems.
- Avoid assuming the graph is current after substantial code changes.

Do not invent Graphify commands. Use the syntax supported by version 0.9.111 and the installed project integration.

### 3.2 Everything Claude Code (ECC) 2.2.0

**Responsibility:** Engineering practices and development workflows.

Use the installed ECC agents, rules, skills, and workflows when relevant.

Prioritize:

- Architecture and code organization.
- Feature implementation.
- Code review.
- Testing and TDD.
- Error handling.
- Security.
- Refactoring.
- Documentation.
- Verification before completion.

Do not install ECC again. It is already installed.

Do not duplicate existing ECC configuration or unnecessarily modify `.agents`.

### 3.3 Caveman Skills

Use Caveman skills when they improve:

- Understanding requirements.
- Exploring the codebase.
- Planning implementation.
- Reducing unnecessary context.
- Reviewing implementation decisions.
- Maintaining consistency across development sessions.

Do not activate unrelated skills just to use them. Select skills based on the current task.

### 3.4 Tool usage priority

Before starting a significant implementation task:

1. Understand the task and its requirements.
2. Inspect relevant existing code.
3. Consult Graphify when architectural relationships matter.
4. Use the relevant ECC or Caveman skill.
5. Implement the smallest coherent change.
6. Run the appropriate verification.
7. Update documentation and the implementation checklist.

The tools should complement one another, not produce competing plans or duplicate instructions.

---

## 4. Architecture Requirements

Use a Feature-First Clean Architecture.

Each feature should be organized into three principal layers:

### 4.1 Domain Layer

Contains business logic and application rules.

Responsibilities:

- Entities.
- Repository contracts (abstract classes).
- Use cases when they provide meaningful separation.
- Domain-specific business rules.
- Domain exceptions where appropriate.

Rules:

- Must not depend on Flutter UI.
- Must not depend on GetX presentation classes.
- Must not depend on concrete data sources.
- Must remain independent of infrastructure implementation details.

### 4.2 Data Layer

Responsible for retrieving, storing, and transforming data.

Responsibilities:

- Repository implementations.
- Data sources.
- DTOs and models.
- Serialization and deserialization.
- Mapping between data models and domain entities.
- API or local storage integration when required.

Rules:

- Implement domain repository contracts.
- Keep data access out of widgets and controllers.
- Separate remote and local data sources when both are needed.
- Handle data and infrastructure errors consistently.
- Do not introduce a backend or API integration without requirements or an available service contract.

### 4.3 Presentation Layer

Responsible for displaying the application and handling user interactions.

Responsibilities:

- Screens and pages.
- Reusable widgets.
- GetX controllers.
- Presentation state.
- Form validation.
- UI-specific models when necessary.

Rules:

- Widgets should not contain business logic.
- Controllers coordinate user actions and application state.
- Controllers should depend on use cases or repository abstractions, not concrete data sources.
- Avoid unnecessarily large controllers.
- Keep UI components reusable and focused.

---

## 5. Proposed Project Structure

Use the following structure as the architectural target.

Adapt it to the actual project after inspection. Do not blindly replace existing files.

```text
lib/
├── main.dart
│
├── app/
│   ├── app.dart
│   ├── bindings/
│   │   └── initial_binding.dart
│   ├── routes/
│   │   ├── app_pages.dart
│   │   ├── app_routes.dart
│   │   └── middlewares/
│   └── translations/
│       ├── app_translations.dart
│       ├── ar_translation.dart
│       └── en_translation.dart
│
├── core/
│   ├── constants/
│   ├── errors/
│   ├── extensions/
│   ├── helpers/
│   ├── services/
│   ├── storage/
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── light_theme.dart
│   │   ├── dark_theme.dart
│   │   └── theme_controller.dart
│   ├── utils/
│   └── widgets/
│
└── features/
    └── feature_name/
        ├── domain/
        │   ├── entities/
        │   ├── repositories/
        │   └── usecases/
        │
        ├── data/
        │   ├── datasources/
        │   ├── models/
        │   └── repositories/
        │
        └── presentation/
            ├── bindings/
            ├── controllers/
            ├── pages/
            └── widgets/
```

### Structure rules

- `app/`: Application initialization, global bindings, routing, and translations.
- `core/`: Shared infrastructure and reusable components.
- `features/`: Independent business features.
- Each feature owns its domain, data, and presentation layers.
- Avoid placing feature-specific logic in `core/`.
- Avoid creating empty directories without an actual purpose.
- Do not create unnecessary abstractions.

---

## 6. GetX State Management

GetX is the required state management and dependency injection solution.

Use the following GetX capabilities appropriately.

### 6.1 GetxController

Use `GetxController` for feature-specific presentation logic.

Responsibilities:

- Handling UI actions.
- Coordinating use cases.
- Managing feature state.
- Handling loading and error states.
- Exposing presentation-ready data.

### 6.2 Reactive state: `.obs` and `Obx`

Use reactive state for values that need automatic UI updates.

Examples include:

- Selected filters.
- Form-related state.
- Selected language.
- Selected theme.
- Data that changes dynamically.

Avoid turning every variable into an observable.

### 6.3 GetBuilder

Use `GetBuilder` when explicit updates are more appropriate than reactive observables.

Do not mix reactive and manually updated state unnecessarily.

### 6.4 StateMixin

Use `StateMixin` where it provides a clear and consistent way to represent:

- Loading.
- Success.
- Empty.
- Error.

Choose one consistent state-handling approach for similar use cases.

### 6.5 Separation of concerns

The following responsibilities must remain separate:

| Component | Responsibility |
|---|---|
| Widget | Rendering and user interaction |
| GetxController | Presentation state and coordination |
| Use Case | Application-specific business operation |
| Repository | Abstract data access contract |
| Repository Implementation | Data retrieval and persistence |
| Data Source | Actual API or local storage operations |

Do not place API requests, database operations, or complex business rules directly inside widgets.

---

## 7. Dependency Injection

Use GetX dependency injection consistently.

### 7.1 InitialBinding

Create an `InitialBinding` for application-wide dependencies.

Register only genuinely global dependencies there.

Examples:

- GetStorage initialization service.
- Application settings service.
- Theme service.
- Localization-related services when needed.

### 7.2 Feature Bindings

Each feature must have its own binding where appropriate.

Register:

- Required repositories.
- Data sources.
- Use cases.
- Feature controllers.

Prefer lazy registration for dependencies that do not need to be instantiated immediately.

### 7.3 GetxService

Use `GetxService` for long-lived application services.

Examples:

- Storage service.
- Application settings service.
- Authentication/session service, if required by the actual requirements.

Do not use `GetxService` for every controller.

### 7.4 Lifecycle

- Avoid duplicate registrations.
- Avoid unnecessary permanent dependencies.
- Dispose of feature-specific resources when appropriate.
- Ensure navigation and dependency lifecycles are predictable.
- Do not create service locator patterns alongside GetX.

---

## 8. Navigation and Middleware

Use GetX Named Routes.

Required components:

- `GetMaterialApp`.
- `GetPage`.
- `Get.toNamed` and related named navigation methods.
- `GetMiddleware`.
- Feature-specific route bindings.

### Routing rules

- Define route names in a centralized location.
- Define route pages in `AppPages`.
- Associate feature bindings with their corresponding pages.
- Avoid direct navigation using page constructors throughout the application.
- Use middleware only when there is an actual navigation requirement.

Potential middleware responsibilities, depending on confirmed requirements:

- Authentication checks.
- Session validation.
- Redirecting users.
- Access control.

Do not implement authentication or access restrictions unless supported by the project's actual requirements.

---

## 9. Localization: Arabic and English

The application must support:

- Arabic (`ar`).
- English (`en`).

Use GetX translations.

### Requirements

- All user-facing text must be translatable.
- Do not hardcode interface text inside widgets.
- Use translation keys consistently.
- Provide complete Arabic and English translations.
- Ensure Arabic uses RTL layout.
- Ensure English uses LTR layout.
- Support language switching without requiring an application restart where possible.
- Persist the selected language using GetStorage.
- Restore the selected language when the application starts.

### Translation organization

Keep translation keys structured and organized by feature.

Avoid inconsistent key naming and duplicated translations.

Verify:

- Text alignment.
- Navigation direction where appropriate.
- Icons and directional controls.
- Form layouts.
- Overflow and text wrapping.
- Arabic and English font rendering.

---

## 10. Themes: Dark and Light

Implement both themes using GetX and persist the user's preference with GetStorage.

### Requirements

- Light Theme.
- Dark Theme.
- Centralized theme definitions.
- Reusable colors and text styles.
- Consistent component styling.
- Persistent theme selection.
- Restore the saved theme on application startup.
- Provide a working theme-switching mechanism.

Avoid hardcoding colors in individual feature widgets when they should come from the theme.

Verify all screens in both themes.

---

## 11. Persistent Storage

Use GetStorage for application preferences.

At minimum, persist:

- Selected language.
- Selected theme.

Other data should only be stored there when appropriate.

Do not use GetStorage as a replacement for a database or as an arbitrary storage solution for complex business data.

Initialize storage before accessing it.

Handle missing or invalid saved values safely and provide sensible defaults.

---

## 12. Feature and Screen Discovery

This is a critical phase.

The original Arabic instructions refer to screens and workflows explained in a lecture. The complete lecture content is not included in this plan.

Therefore, the agent must first identify all available requirement sources.

Inspect:

- Existing project documentation.
- README files.
- Lecture notes or transcripts available in the project.
- Existing screenshots and design references.
- Existing diagrams.
- Existing source files.
- Any additional requirement documents provided by the user.

### Required output

Create:

`IMPLEMENTATION_PLANS/FEATURES_AND_FLOWS.md`

This document must contain:

1. Confirmed user roles.
2. Confirmed application features.
3. All identified screens.
4. Navigation flows.
5. User interactions.
6. Business rules.
7. Input validation requirements.
8. Required data entities.
9. Dependencies between features.
10. Unresolved requirements and assumptions.

For each screen, document:

- Screen name.
- Purpose.
- Entry points.
- Main UI components.
- User actions.
- Required data.
- Loading state.
- Empty state.
- Error state.
- Navigation destinations.
- Arabic and English requirements.

### 12.1 Handling Missing Information Autonomously

When specific lecture recordings, slides, or transcripts are unavailable in the workspace, do not block or wait. Follow these rules:

1. Derive reasonable, professional software engineering assumptions based on the Ejary rental platform concept, the project discovery findings, and the architecture specification.
2. In `IMPLEMENTATION_PLANS/FEATURES_AND_FLOWS.md`, clearly distinguish inferred requirements from confirmed requirements.
3. Build a coherent, functional rental platform MVP covering discovery, property details, rental/lease workflows, user profiles, localization, and theme switching.
4. Document all design decisions transparently.
5. Only prompt the user if an external blocker genuinely prevents all progress; otherwise make a sensible engineering decision and proceed autonomously.

---

## 13. Implementation Phases

Execute the project in the following phases.

Do not skip phases without documenting the reason.

### Phase 0 — Project Discovery and Tool Preparation

Objectives:

- Inspect the existing repository.
- Understand its current state.
- Verify the development environment.
- Inspect Graphify and ECC integrations.
- Generate the initial Graphify knowledge graph.

Tasks:

1. Inspect the repository structure.
2. Inspect `pubspec.yaml`.
3. Inspect existing Dart files.
4. Inspect existing assets and documentation.
5. Run `flutter doctor -v`.
6. Run `flutter --version`.
7. Run `dart --version`.
8. Run `flutter pub get` only after reviewing the current dependency configuration.
9. Inspect Graphify integration instructions.
10. Generate the initial graph using the installed Graphify workflow.
11. Inspect the ECC installation and relevant skills.
12. Create the project discovery report.

Deliverables:

- `IMPLEMENTATION_PLANS/PROJECT_DISCOVERY.md`
- Initial Graphify knowledge graph in its documented output location.
- List of current issues and risks.

Acceptance criteria:

- Existing project structure is understood.
- Existing dependencies are documented.
- Initial graph generation is verified.
- No existing useful project files have been unnecessarily deleted or replaced.

### Phase 1 — Requirements Analysis and Architecture Design

Objectives:

- Convert the available lecture requirements into an implementable specification.
- Identify features and their dependencies.
- Define the application architecture.

Tasks:

1. Extract all confirmed features and workflows.
2. Identify user roles.
3. Identify screens and navigation flows.
4. Identify domain entities.
5. Identify repository contracts.
6. Identify required use cases.
7. Define feature boundaries.
8. Define dependency injection strategy.
9. Define global services.
10. Define localization and theme requirements.

Deliverables:

- `IMPLEMENTATION_PLANS/FEATURES_AND_FLOWS.md`
- `IMPLEMENTATION_PLANS/ARCHITECTURE_DESIGN.md`

Acceptance criteria:

- Every confirmed feature is documented.
- Feature boundaries are clear.
- No unsupported business assumptions are introduced.
- Architecture supports the required functionality.

### Phase 2 — Clean Architecture Foundation

Objectives:

Build a stable application foundation before implementing individual business features.

Tasks:

1. Establish the Feature-First directory structure.
2. Configure the application entry point.
3. Create the application root widget.
4. Configure GetMaterialApp.
5. Create InitialBinding.
6. Establish centralized route definitions.
7. Create AppPages.
8. Establish feature binding conventions.
9. Create shared error-handling conventions.
10. Create reusable core utilities and widgets only when needed.
11. Configure consistent dependency registration.

Deliverables:

- Working application foundation.
- Centralized routing.
- Global dependency injection.
- Documented architecture conventions.

Acceptance criteria:

- Application builds and launches.
- Initial dependencies initialize correctly.
- Navigation configuration works.
- No circular dependencies.
- Domain layer remains independent of Flutter and GetX presentation logic.

### Phase 3 — Global Services and Application Preferences

Objectives:

Implement global services and persisted preferences.

Tasks:

1. Initialize GetStorage.
2. Create a storage abstraction or service appropriate to the application.
3. Implement theme preference persistence.
4. Implement language preference persistence.
5. Restore saved preferences during startup.
6. Handle missing and invalid preference values.
7. Verify application startup ordering.

Acceptance criteria:

- Preferences survive application restarts.
- Default values work correctly.
- Storage initialization does not cause startup failures.

### Phase 4 — Localization and Theme System

Objectives:

Implement complete Arabic/English and Dark/Light support.

Tasks:

1. Create Arabic translations.
2. Create English translations.
3. Define translation key conventions.
4. Configure GetX localization.
5. Configure RTL/LTR behavior.
6. Create centralized light theme.
7. Create centralized dark theme.
8. Implement theme switching.
9. Implement language switching.
10. Connect both preferences to GetStorage.

Acceptance criteria:

- All existing user-facing strings use translations.
- Both languages render correctly.
- RTL and LTR layouts work.
- Both themes work.
- Preferences persist after restart.

### Phase 5 — Core Feature Implementation

Objectives:

Implement the business features identified in `FEATURES_AND_FLOWS.md`.

For each confirmed feature:

1. Define domain entities.
2. Define repository contracts.
3. Define required use cases.
4. Define data models.
5. Define data sources.
6. Implement repository classes.
7. Implement GetX controllers.
8. Create feature bindings.
9. Implement screens and reusable widgets.
10. Connect navigation.
11. Implement loading, success, empty, and error states.
12. Add validation and error handling.
13. Add relevant tests.

### Feature implementation rules

- Implement one feature at a time.
- Follow its documented dependencies.
- Keep business logic out of the UI.
- Do not duplicate shared functionality.
- Reuse core components when appropriate.
- Avoid oversized controllers.
- Avoid unnecessary abstractions.
- Verify the feature before moving to the next one.

Acceptance criteria:

- The feature's documented workflows work.
- Its dependencies are registered correctly.
- Navigation works.
- State updates correctly.
- Errors are handled.
- Tests pass.

### Phase 6 — Navigation and Application Integration

Objectives:

Integrate all completed features into a consistent application.

Tasks:

1. Register all feature routes.
2. Configure route bindings.
3. Configure applicable middleware.
4. Verify navigation between features.
5. Verify back-navigation behavior.
6. Verify application startup and restoration.
7. Verify dependency lifecycle.
8. Verify localization across all screens.
9. Verify themes across all screens.

Acceptance criteria:

- No broken routes.
- No unexpected navigation loops.
- No duplicate dependency registrations.
- No inaccessible screens.
- All confirmed user flows are connected.

### Phase 7 — Testing and Quality Assurance

Objectives:

Verify application correctness and stability.

Testing should include:

**Static analysis**

- Run `flutter analyze`.
- Fix errors.
- Fix relevant warnings.
- Avoid suppressing warnings without justification.

**Unit tests**

- Domain entities.
- Use cases.
- Repository implementations.
- Controllers.
- Validation and business rules.

**Widget tests**

- Important screens.
- Forms.
- Loading states.
- Empty states.
- Error states.
- Localization.
- Theme changes.

**Integration tests**

- Application startup.
- Navigation flows.
- Main user journeys.
- Language switching.
- Theme switching.
- Preference restoration.

**Build verification**

- Run `flutter test`.
- Run `flutter analyze`.
- Run `flutter build apk --debug` when Android tooling is available.

Do not claim a test or build passed unless it was actually executed and its result was verified.

Acceptance criteria:

- No known blocking analysis errors.
- Relevant automated tests pass.
- Application launches successfully.
- Main confirmed workflows work end to end.
- Both themes and languages have been verified.

### Phase 8 — Final Review and Documentation

Objectives:

Prepare the application for future development and handover.

Tasks:

1. Review architecture consistency.
2. Review naming conventions.
3. Review dependency injection.
4. Review GetX controller responsibilities.
5. Review repository implementations.
6. Review error handling.
7. Review localization completeness.
8. Review theme consistency.
9. Review application performance.
10. Review security-sensitive functionality.
11. Update Graphify using its supported workflow.
12. Review the final knowledge graph.
13. Update project documentation.

Deliverables:

- `IMPLEMENTATION_PLANS/FINAL_REVIEW.md`
- Updated `README.md`.
- Updated implementation checklist.
- Documented known limitations.

Acceptance criteria:

- No known critical architectural problems.
- No known blocking application errors.
- Documentation matches the implemented application.
- Remaining issues are explicitly documented.

---

## 14. Code Quality Standards

Follow these conventions throughout development.

### Dart and Flutter

- Follow official Dart and Flutter conventions.
- Use meaningful names.
- Prefer small, focused classes and methods.
- Avoid unnecessary nesting.
- Avoid duplicated code.
- Use `const` where appropriate.
- Handle asynchronous operations correctly.
- Avoid force-unwrapping nullable values without justification.
- Avoid unexplained magic values.
- Keep widgets focused on presentation.

### Architecture

- Respect layer boundaries.
- Keep domain logic independent.
- Use repository abstractions.
- Avoid direct data-source access from controllers.
- Avoid circular dependencies.
- Avoid placing feature-specific logic in `core`.

### GetX

- Use controllers for presentation coordination.
- Use bindings for dependency registration.
- Use services for long-lived dependencies.
- Choose reactive or explicit state updates intentionally.
- Avoid unnecessary global state.
- Avoid permanent registrations without a valid reason.

### Error handling

- Do not silently ignore exceptions.
- Do not expose raw technical exceptions to end users.
- Provide appropriate user-facing messages.
- Log diagnostic information appropriately.
- Handle loading and error states consistently.

---

## 15. Dependency Management

Before adding any package:

1. Confirm that it is necessary.
2. Check compatibility with Flutter 3.50.0 and Dart 3.14.0.
3. Check whether an existing dependency already provides the required functionality.
4. Prefer actively maintained packages.
5. Avoid unnecessary transitive dependencies.
6. Explain significant dependency decisions in project documentation.

GetX is the required application framework for state management, routing, dependency injection, and translations.

GetStorage is the required persistence mechanism for application preferences.

Do not introduce another state management framework.

Do not replace GetX with Riverpod, Bloc, Provider, or another framework.

---

## 16. Security and Reliability

Apply security practices appropriate to the confirmed requirements.

- Validate user input.
- Avoid exposing secrets in source code.
- Avoid hardcoded credentials.
- Handle network errors safely if remote services are introduced.
- Avoid logging sensitive information.
- Validate data received from external sources.
- Apply authorization checks where the requirements establish protected operations.
- Do not treat client-side validation as a replacement for server-side validation.
- Do not invent authentication or authorization rules.

If the platform requires backend functionality but no backend specification or service is available, document the dependency instead of pretending that a local mock implementation is production-ready.

---

## 17. Agent Execution Rules

These rules are mandatory.

### 17.1 Work incrementally

Do not attempt to implement the entire application in one enormous operation.

Work through the implementation phases in order.

Within each phase:

- Break work into small, verifiable tasks.
- Complete one coherent task at a time.
- Verify before continuing.
- Update the plan and checklist.

### 17.2 Preserve existing work

Before changing files:

- Inspect them.
- Understand their purpose.
- Identify dependencies.
- Preserve existing useful functionality.

Never delete or overwrite project files simply to match the proposed directory structure.

### 17.3 Autonomous Decision Making

Proceed independently throughout development under the Master Directive. Full authorization is granted to complete all implementation phases without asking for approval between phases or ordinary development tasks.

When lecture materials or details are unavailable, make reasonable, documented software engineering decisions to deliver a complete, functional MVP. Only ask the user if an external blocker genuinely prevents further progress.

### 17.4 Do not fabricate completion

Never report that:

- A screen is implemented when it is only a placeholder.
- A workflow works when it has not been tested.
- A build succeeds when it has not been run.
- A Graphify graph was generated when the output was not verified.
- A feature is production-ready when it depends on unavailable backend functionality.

### 17.5 Maintain implementation records

Create and maintain:

`IMPLEMENTATION_PLANS/IMPLEMENTATION_PROGRESS.md`
`IMPLEMENTATION_PLANS/RESUME.md`

For each task, record:

- Task identifier.
- Description.
- Status: Not Started / In Progress / Blocked / Completed.
- Files changed.
- Verification performed.
- Test results.
- Remaining issues.

Update progress files continuously after completing each meaningful task and at checkpoints.

### 17.6 Safe execution

- Do not run destructive Git commands.
- Do not reset or discard user changes.
- Do not delete untracked files.
- Do not replace existing `.agents` configuration.
- Do not modify Graphify or ECC installations unless required and explicitly justified.
- Commit and push changes autonomously to non-main branches using Conventional Commits.
- Do not install additional tooling without explaining why it is necessary.

---


## 18. Autonomous Git and GitHub Workflow

Under the Master Directive, the AI agent has full explicit authorization to manage all Git operations required for this project autonomously. No approval is needed for creating branches, switching branches, committing, pushing, or merging non-main development branches.

### 18.1 Main Branch Protection

**The `main` branch must NEVER be modified directly.**

Mandatory rules:

- Never commit directly to `main`.
- Never push directly to `main`.
- Never merge any branch into `main`.
- Never reset, rebase, or force-push `main`.
- Never delete or rename the `main` branch.
- Never change the default branch.
- All development, commits, merges, and integration must happen on non-main branches.

Treat `main` as a protected production branch at all times.

### 18.2 Primary Integration Branch

Use the dedicated branch:

`feature/ejary-platform`

as the main development and integration branch. Do not recreate it if it already exists.

### 18.3 Autonomous Feature Branches & Integration

Create additional branches whenever useful, for example:

- `feature/ejary-platform` (primary integration branch)
- `feature/app-foundation`
- `feature/authentication`
- `feature/property-management`
- `feature/property-discovery`
- `feature/rental-workflows`
- `feature/user-profiles`
- `feature/localization-theme`
- `test/application-quality`

For each substantial feature:

1. Create or switch to an appropriate non-main branch.
2. Implement the feature.
3. Run relevant tests and analysis.
4. Review changes.
5. Commit using Conventional Commits.
6. Push the feature branch to GitHub.
7. Merge it into `feature/ejary-platform` or another appropriate non-main integration branch.
8. Verify the merge.
9. Run relevant checks after integration.
10. Continue to the next feature.

Merging development branches with one another is authorized autonomously. Never merge anything into `main`.

### 18.4 Commit Strategy

Create meaningful, incremental commits after completing coherent, verified units of work.

Use Conventional Commits:

- `chore: establish clean architecture foundation`
- `feat: implement property discovery`
- `feat: add rental application workflow`
- `feat: implement Arabic and English localization`
- `fix: resolve property navigation issue`
- `test: add repository and controller tests`
- `docs: update implementation progress`

Commit rules:

- Do not create empty commits.
- Do not commit broken or unverified work unless explicitly documented as a checkpoint.
- Review `git status` and `git diff` before staging.
- Never commit secrets, credentials, API keys, private configuration, or generated caches.
- Keep commits focused and understandable.

### 18.5 GitHub Push Workflow

Push implementation branches to the configured GitHub remote (`origin`) autonomously.

Requirements:

1. Verify remote URL before pushing (`origin`).
2. Verify current branch is not `main`.
3. Commit intended changes.
4. Push the branch to `origin` with upstream tracking when appropriate.
5. Verify remote branch exists after pushing.
6. If authentication or network restriction prevents pushing, preserve local commits, document the issue in `RESUME.md`, and continue independent work.

### 18.6 Pull Requests

When the implementation branch is complete:

- Prepare a Pull Request targeting `main`.
- Include title, implementation summary, verification results, and limitations.
- Do not merge the Pull Request into `main`. Leave final merging to the user.

### 18.7 Git Safety Checks

Before every commit and push, verify:

```powershell
git branch --show-current
git status --short
```

Before pushing, enforce this condition:

- Current branch must not equal `main`.
- Target remote branch must not equal `main`.
- No accidental changes to `main` are allowed.

Never use destructive commands without explicit user authorization:

- `git reset --hard`
- `git clean -fd`
- `git push --force`
- `git branch -D`

### 18.8 Git Completion Criteria

- [x] Implementation branch `feature/ejary-platform` created and tracked on GitHub.
- [ ] `main` remains untouched.
- [ ] Changes are committed in meaningful increments using Conventional Commits.
- [ ] Feature branches merged into `feature/ejary-platform`.
- [ ] Implementation branches pushed to GitHub and verified.
- [ ] Pull Request targeting `main` prepared at completion.
- [ ] No Pull Request merged into `main` without explicit user authorization.


















































































## 19. Definition of Done

The project is considered complete only when all applicable conditions below are satisfied.

### Architecture

- [ ] Feature-First architecture is established.
- [ ] Domain, Data, and Presentation layers are separated.
- [ ] Repository Pattern is implemented.
- [ ] GetX dependency injection is configured.
- [ ] InitialBinding works.
- [ ] Feature bindings work.
- [ ] GetxService is used appropriately.
- [ ] Named Routes work.
- [ ] Applicable middleware works.

### Application functionality

- [ ] All confirmed features are implemented.
- [ ] All confirmed screens are implemented.
- [ ] All documented workflows are functional.
- [ ] Controllers handle presentation state correctly.
- [ ] Loading, empty, success, and error states are handled.
- [ ] Data access is separated from the UI.

### Localization and themes

- [ ] Arabic translations are complete.
- [ ] English translations are complete.
- [ ] RTL works.
- [ ] LTR works.
- [ ] Light theme works.
- [ ] Dark theme works.
- [ ] Language preference persists.
- [ ] Theme preference persists.

### Quality

- [ ] Flutter analysis passes without blocking errors.
- [ ] Relevant unit tests pass.
- [ ] Relevant widget tests pass.
- [ ] Relevant integration tests pass.
- [ ] Application builds successfully for the verified target.
- [ ] No known critical issues remain undocumented.
- [ ] Documentation reflects the actual implementation.

---

## 20. Autonomous Execution & Resumption Workflow

Under the Master Directive:

1. **Phase 0 is complete and verified:** Baseline discovery, environment verification (Flutter 3.50.0, Dart 3.14.0, zero errors), Graphify knowledge graph generation (5,066 nodes, 5,693 edges, 437 communities), and repository isolation on `feature/ejary-platform` are finished and recorded.
2. **Continue autonomously without stopping:** Do not wait for user approval between phases or tasks. Proceed directly from Phase 1 through all remaining phases until the Definition of Done is fully satisfied.
3. **Continuous documentation & checkpointing:** Update `IMPLEMENTATION_PLANS/IMPLEMENTATION_PROGRESS.md` and `IMPLEMENTATION_PLANS/RESUME.md` after every meaningful milestone.
4. **Git lifecycle:** Commit frequently with Conventional Commits, push to `origin/feature/ejary-platform`, and never modify `main`.

---

## 21. Quota Exhaustion, Checkpoints, and Cross-Account Resumption

This project may require more than one model session or Google account because of free-tier usage limits.

The agent MUST make the project fully resumable at any moment.

### A. Continuous Checkpointing

Never depend on conversation history as the only source of project progress.

After every meaningful implementation task:

1. Update `IMPLEMENTATION_PLANS/IMPLEMENTATION_PROGRESS.md`.
2. Record exactly what was completed.
3. Record the current phase and task.
4. Record the next specific task to execute.
5. Record important architecture decisions and assumptions.
6. Record known bugs, blockers, and incomplete work.
7. Record the current Git branch and latest commit.
8. Commit the completed work using Conventional Commits.
9. Push the changes to the appropriate non-main GitHub branch.

Do not wait until an entire phase is finished to create a checkpoint.

Keep the working tree clean whenever possible.

### B. Maintain a Dedicated Resume Document

Create and continuously maintain:

`IMPLEMENTATION_PLANS/RESUME.md`

This document is the authoritative handoff point for any new model session or account.

It must contain:

- Project name and repository information.
- Current implementation phase.
- Current task and its status.
- Last completed task.
- Exact next task to execute.
- Completed features.
- Incomplete features.
- Current architecture and important decisions.
- Relevant files and directories.
- Known errors and unresolved issues.
- Tests already executed and their results.
- Current Git branch.
- Latest commit hash.
- Last successfully pushed commit.
- Any uncommitted work and why it remains uncommitted.
- Graphify status.
- Any special instructions needed to continue safely.

Update this document after every substantial milestone and before ending any session.

### C. Before Model Quota Runs Out

If you receive a quota warning, capacity error, or determine that the current session cannot continue:

1. Stop starting new implementation tasks.
2. Finish or safely pause the current operation.
3. Save all important progress.
4. Update `IMPLEMENTATION_PROGRESS.md`.
5. Update `RESUME.md` with the exact next action.
6. Run relevant tests if practical.
7. Commit and push completed work to the current non-main branch.
8. Verify the latest commit exists on GitHub.
9. Report exactly where execution stopped.

Never leave the project in an undocumented state.

If the model fails unexpectedly and cannot perform a final checkpoint, the previous task-level checkpoints and Git commits must still allow recovery.

### D. Resume From Another Account or New Conversation

When a different Google account or a new Antigravity conversation is used:

Do NOT restart the project.

Do NOT regenerate the implementation plan.

Do NOT repeat Phase 0.

Do NOT overwrite completed work.

Instead:

1. Open the same existing project workspace if available.
2. Inspect the Git repository and current branch.
3. Fetch the latest remote changes.
4. Read `IMPLEMENTATION_PLANS/IMPLEMENTATION_PLAN.md`.
5. Read `IMPLEMENTATION_PLANS/IMPLEMENTATION_PROGRESS.md`.
6. Read `IMPLEMENTATION_PLANS/RESUME.md`.
7. Inspect the latest Git commits and remote branch.
8. Compare the actual codebase with the progress documents.
9. Identify the last successfully completed task.
10. Identify the exact next incomplete task.
11. Continue implementation from that point.

Treat the actual source code and Git history as the source of truth. If the progress documents disagree with the code, investigate and correct the documentation before continuing.

Do not assume that a previous conversation is accessible.

### E. GitHub Is the Recovery Point

The GitHub repository is the persistent recovery point.

Push all completed work to non-main branches.

The primary integration branch remains:

`feature/ejary-platform`

Never modify `main`.

If another session has already pushed newer commits, fetch and inspect them before continuing. Do not overwrite or force-push existing work.

### F. Autonomous Continuation

A new model session must continue the remaining project tasks automatically.

It must not ask the user to repeat requirements, explain completed work, or approve already authorized operations.

It must continue until the original Definition of Done is satisfied.

**The project is a continuous engineering task, not a single conversation. Preserve progress, hand off cleanly, and continue from the exact point where the previous session stopped.**