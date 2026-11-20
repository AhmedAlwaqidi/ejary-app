# Ejary Platform — Features and User Flows Specification

**Project:** Ejary (`ejary_app`)  
**Document Type:** Feature Breakdown, Screen Hierarchy, and Interaction Flows  
**Author:** Antigravity (Gemini 3.8 Flash High)  
**Status:** Approved for Autonomous Implementation  
**Specification Reference:** `IMPLEMENTATION_PLANS/IMPLEMENTATION_PLAN.md`  
**Last Updated:** 2026-11-20  

---

## 1. Executive Purpose & Scope

The **Ejary Platform** ("إيجاري" — meaning *My Rent/Lease*) is a modern, bilingual Flutter mobile application designed to streamline property rentals and lease contract workflows. 

The application serves as a rental marketplace and leasing portal where tenants can discover verified residential and commercial properties, review rental terms and specifications, submit digital rental requests, view active lease agreements, and manage rental payments, while landlords can list properties and track occupancy.

### 1.1 Inferred vs. Confirmed Requirements Matrix

In accordance with Section 4 of the Master Directive, because lecture materials were not stored as files in the repository, the requirements below are categorized transparently:

| Requirement Area | Classification | Source & Justification |
|---|:---:|---|
| Clean Architecture & Feature-First organization | **Confirmed** | Mandatory in `IMPLEMENTATION_PLAN.md` Section 4 & 5 |
| GetX State Management, Bindings, Services, Named Routes | **Confirmed** | Mandatory in `IMPLEMENTATION_PLAN.md` Section 6, 7 & 8 |
| Arabic (RTL) and English (LTR) Localization | **Confirmed** | Mandatory in `IMPLEMENTATION_PLAN.md` Section 9 |
| Light and Dark Theme System with Persistence | **Confirmed** | Mandatory in `IMPLEMENTATION_PLAN.md` Section 10 |
| GetStorage for User Preferences | **Confirmed** | Mandatory in `IMPLEMENTATION_PLAN.md` Section 11 |
| Dual User Roles (Tenant & Landlord) + Guest Mode | **Inferred** | Standard rental platform domain necessity (Ejary model) |
| Core Screen Flow (Explore -> Details -> Booking -> Contracts) | **Inferred** | Essential end-to-end leasing journey for functional MVP |
| Local In-Memory Mock Data Sources with Gulf/Saudi Context | **Inferred** | Realistic academic project data without unauthenticated external backend |

---

## 2. User Roles & Permissions

The application supports three operational actor states:

```
                  ┌───────────────────────────────┐
                  │          Guest User           │
                  │ (Browsing, Search, Settings)  │
                  └──────────────┬────────────────┘
                                 │
                   Log In / Select Active Role
                                 │
          ┌──────────────────────┴──────────────────────┐
          ▼                                             ▼
┌───────────────────────────────┐             ┌───────────────────────────────┐
│         Tenant Role           │             │         Landlord Role         │
│  (مستأجر - Rent properties,   │             │   (مؤجر - List properties,    │
│  apply for leases, contracts) │             │    review lease applications) │
└───────────────────────────────┘             └───────────────────────────────┘
```

1. **Guest User (زائر):**
   - Can freely browse, search, and filter property listings.
   - Can inspect property details, photos, and landlord contact info.
   - Can change language (Arabic/English) and theme (Light/Dark).
   - Triggering rental actions or listing management prompts authentication or role switch.

2. **Tenant (مستأجر):**
   - Can submit rental applications and select lease durations (6 months, 1 year, 2 years) and payment frequency (monthly, quarterly, semi-annual, annual).
   - Can view active and pending lease agreements (`/my-rentals`).
   - Can inspect payment milestones and simulate payment settlement.

3. **Landlord / Owner (مؤجر / مالك عقار):**
   - Can publish new property listings with pricing, specifications, and amenity tags.
   - Can manage owned properties (`/my-properties`) and toggle listing availability.
   - Can view and approve/reject pending tenant rental requests.

---

## 3. Core Application Features

### Feature 1: Authentication & Session
- Email & password login and registration with validation.
- Quick "Continue as Guest" option.
- Role toggle (Switch between Tenant view and Landlord view in Profile).
- Persistent session state.

### Feature 2: Property Discovery & Search
- Featured properties banner / carousel.
- Category filtering: Apartments (شقق), Villas (فلل), Studios (استوديوهات), Commercial (تجاري), Chalets (شاليهات).
- Search by keyword, city (Riyadh, Jeddah, Dammam, Mecca, Medina), and district.
- Filter by price range, number of bedrooms, bathrooms, and property type.

### Feature 3: Property Details & Amenities
- Comprehensive property overview with image gallery.
- Key specs badge grid: Size (m²), Bedrooms, Bathrooms, Floor level, Furnishing status.
- Amenity chips: Parking, Elevator, Air Conditioning, Balcony, Security, Central Gas, Built-in Wardrobes.
- Landlord information card with call/message action buttons.
- Direct CTA: "Request Lease / تقدم بطلب إيجار".

### Feature 4: Rental Application & Lease Workflow
- Booking dates selection (Start date, duration).
- Payment schedule selection: Monthly (شهري), Quarterly (ربع سنوي), Semi-Annual (نصف سنوي), Annual (سنوي).
- Identification input (National ID / Iqama, full name, phone).
- Instant validation and submission into the application queue.

### Feature 5: Lease Agreements & Contracts
- Digital contract viewer with legal terms, parties, property details, and financial summary.
- Payment installment schedule with due dates, amounts, and settlement status (Paid / Pending).
- Simulated payment execution with instant status reflection.

### Feature 6: Landlord Property Listing Management
- Form to add new properties with photo URL/asset, title, description, city, district, price, category, bedrooms, bathrooms, and amenities.
- Real-time form validation.
- Instant inclusion into the catalog.

### Feature 7: Global Settings & Personalization
- One-tap switch between Arabic (العربية - RTL) and English (LTR).
- One-tap switch between Light and Dark themes.
- Preferences saved to GetStorage and reloaded on cold start.

---

## 4. Complete Screen Hierarchy & Specifications

```
/splash (Initial startup & preference loader)
  │
  ├──► /login (Authentication) ──► /register
  │         │ (or Guest)
  │         ▼
  └──► /main (Navigation Shell with Bottom Nav)
         │
         ├── Tab 1: /explore (Property Discovery & Feed)
         │           ├──► /search-filter (Filter BottomSheet/Dialog)
         │           └──► /property-details (Full Specifications)
         │                     │
         │                     └──► /rental-apply (Submit Lease Request)
         │                               │
         │                               └──► /contract-details (Digital Lease)
         │
         ├── Tab 2: /my-rentals (Active Leases & Payment Tracker)
         │           └──► /contract-details
         │
         ├── Tab 3: /my-properties (Landlord Listings & Applications)
         │           └──► /add-property (New Listing Form)
         │
         └── Tab 4: /profile (User Info, Language, Theme, Role Toggle)
```

---

### Screen S01: Splash Screen (`/splash`)
- **Route:** `AppRoutes.SPLASH`
- **Purpose:** Initialize application services, read saved language and theme from `GetStorage`, and transition smoothly into `/main`.
- **UI Components:** Ejary branding logo, localized tagline, animated progress indicator.
- **States:** Loading -> Auto-navigate to `/main` (or `/login` if required).

---

### Screen S02: Login Screen (`/login`)
- **Route:** `AppRoutes.LOGIN`
- **Purpose:** User authentication for existing accounts or fast-track guest login.
- **UI Components:** Email field, password field, "Forgot Password" link, "Login" button, "Continue as Guest" secondary button, "Create Account" link.
- **Validation:** Valid email format, password >= 6 characters.
- **States:** Idle, Loading (authenticating), Error (invalid credentials snackbar).

---

### Screen S03: Register Screen (`/register`)
- **Route:** `AppRoutes.REGISTER`
- **Purpose:** Create a new tenant or landlord account.
- **UI Components:** Full name, email, phone number (+966 format), password, confirm password, role selection (Tenant / Landlord), "Register" button.
- **Validation:** Non-empty name, phone format, email format, matching passwords.

---

### Screen S04: Main Shell (`/main`)
- **Route:** `AppRoutes.MAIN`
- **Purpose:** Root scaffold holding persistent `BottomNavigationBar` and coordinating 4 primary views via GetX `MainNavigationController`.
- **Navigation Tabs:**
  1. **Explore (استكشاف):** Property catalog, search bar, category chips, property cards.
  2. **My Rentals (إيجاراتي):** Tenant's active lease contracts and application status.
  3. **My Properties (عقاراتي):** Landlord's listings management and rental requests.
  4. **Profile (الملف الشخصي):** Account information, theme switcher, language switcher, role toggle.

---

### Screen S05: Property Details (`/property-details`)
- **Route:** `AppRoutes.PROPERTY_DETAILS`
- **Entry Points:** Tapping any property card from `/explore` or `/my-properties`.
- **UI Components:**
  - Hero image carousel with image indicator.
  - Price pill: e.g., `45,000 SAR / Year` (٤٥,٠٠٠ ر.س / سنوياً).
  - Title and verified badge.
  - Location row: City, District with map pin icon.
  - Spec strip: Area (`m²`), Bedrooms (`غرف`), Bathrooms (`دورات مياه`), Floor (`الدور`).
  - Description expandable card.
  - Amenity chip grid with localized icons and labels.
  - Landlord info card with avatar, name, and phone/chat buttons.
  - Fixed bottom bar: Price display and "Apply for Lease / تقدم بطلب استئجار" button.
- **States:**
  - **Loading:** Skeleton placeholder shimmer.
  - **Success:** Rich interactive screen.
  - **Error:** Error card with retry button.

---

### Screen S06: Rental Application (`/rental-apply`)
- **Route:** `AppRoutes.RENTAL_APPLY`
- **Entry Points:** Tapping "Apply for Lease" on `/property-details`.
- **Purpose:** Step-by-step submission of lease parameters.
- **UI Components:**
  - Compact summary of selected property.
  - Start Date picker.
  - Duration selector (6 Months, 1 Year, 2 Years).
  - Payment Frequency selector (Monthly, Quarterly, Semi-Annual, Annual).
  - Calculated payment per installment badge.
  - Tenant Information form: Full Name, National ID / Iqama, Mobile Number.
  - Terms and conditions checkbox.
  - "Submit Application / إرسال الطلب" button.
- **Validation:** Future start date, valid 10-digit ID/Iqama, valid 9-10 digit mobile number, terms checked.
- **States:** Idle, Validating, Submitting, Success dialog navigating to `/my-rentals`.

---

### Screen S07: Lease Contract Details (`/contract-details`)
- **Route:** `AppRoutes.CONTRACT_DETAILS`
- **Purpose:** View digital lease agreement, legal clauses, and payment installment schedule.
- **UI Components:**
  - Contract number and status badge (Active / مفعل, Pending / قيد المراجعة).
  - Parties card: Landlord name, Tenant name, Property address.
  - Financial breakdown: Total annual rent, deposit, frequency.
  - Installment timeline / payment list:
    - Installment number, due date, amount, status pill (`Paid / مسدد`, `Pending / مستحق`).
    - "Pay Now / سداد" button for pending installments.
- **Actions:** Simulating payment updates the installment state to "Paid" in real-time.

---

### Screen S08: Add Property Listing (`/add-property`)
- **Route:** `AppRoutes.ADD_PROPERTY`
- **Entry Points:** Landlord tab FloatingActionButton / "Add Property" button.
- **Purpose:** Publish a new property listing.
- **UI Components:**
  - Image URL or preset picker.
  - Property Title (AR & EN).
  - Category dropdown (Apartment, Villa, Studio, Commercial, Chalet).
  - City dropdown (Riyadh, Jeddah, Dammam, Mecca, Medina, Khobar).
  - District text field.
  - Annual Rental Price (SAR).
  - Specifications: Area (m²), Bedrooms, Bathrooms.
  - Amenity multi-select chips.
  - Description text field.
  - "Publish Listing / نشر العقار" button.
- **Validation:** All mandatory fields filled with positive numerical specs.

---

### Screen S09: Profile & Settings (`/profile`)
- **Route:** Embedded in Tab 4 of `AppRoutes.MAIN`.
- **Purpose:** User account settings and system preferences.
- **UI Components:**
  - User avatar and name header.
  - Role switcher chip: "Switch to Landlord View / التبديل إلى المؤجر" or "Switch to Tenant View".
  - **Language Preference Tile:** Shows current language ("العربية" / "English"), opens dialog to toggle language; persists immediately to GetStorage and updates `Get.updateLocale`.
  - **Theme Preference Tile:** Toggle switch between Light Mode and Dark Mode; persists immediately to GetStorage and updates `Get.changeTheme`.
  - App Version badge (`v1.0.0+1`).
  - About Ejary dialog.
  - Logout action button.

---

## 5. Domain Entities & Data Flow

```
┌──────────────────┐            1..* ┌──────────────────────────┐
│       User       │────────────────►│         Property         │
│  (Tenant/Owner)  │                 │  (Listing, Specs, Price) │
└────────┬─────────┘                 └────────────┬─────────────┘
         │                                        │
         │ 1..*                                   │ 1..*
         ▼                                        ▼
┌──────────────────┐       1..1      ┌──────────────────────────┐
│  RentalRequest   │◄────────────────┤      LeaseContract       │
│(Application Form)│                 │ (Agreement, Installments)│
└──────────────────┘                 └──────────────────────────┘
```

### Key Domain Entities:
1. `User`: `id`, `name`, `email`, `phone`, `role` (`tenant`, `landlord`), `avatarUrl`.
2. `Property`: `id`, `titleAr`, `titleEn`, `descriptionAr`, `descriptionEn`, `category`, `city`, `district`, `pricePerYear`, `areaM2`, `bedrooms`, `bathrooms`, `amenities`, `images`, `landlordId`, `landlordName`, `isAvailable`, `createdAt`.
3. `RentalApplication`: `id`, `propertyId`, `tenantId`, `tenantName`, `tenantNationalId`, `tenantPhone`, `startDate`, `durationMonths`, `paymentFrequency`, `totalAmount`, `status` (`pending`, `approved`, `rejected`), `createdAt`.
4. `LeaseContract`: `id`, `contractNumber`, `propertyId`, `tenantId`, `landlordId`, `startDate`, `endDate`, `annualRent`, `paymentFrequency`, `installments`, `status` (`active`, `expired`, `pendingApproval`).
5. `PaymentInstallment`: `id`, `contractId`, `installmentNumber`, `amount`, `dueDate`, `isPaid`, `paidAt`.
