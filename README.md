# Student Task Manager 🎓📱
> **In-Class Assignment: Flutter App Challenge - Part 2**

A modern, functional, and beautifully designed mobile application built with **Flutter** using strict **MVC (Model-View-Controller)** architecture. Designed for university students to track and manage daily academic tasks such as assignments, lectures, research, exams, and personal items.

---

## 🌟 Key Features & Requirements

1. **Dashboard & Summary Metrics (Screen 1)**: Real-time overview of **Total Tasks**, **Completed Tasks**, and **Pending Tasks**.
2. **Task Creation Form (Screen 2)**: Form for adding new tasks with category icons and color-coded priority pickers.
3. **Task Categorization**: Support for suggested academic categories (`Assignment 📝`, `Lecture 🎓`, `Research 🔬`, `Exam ✏️`, `Personal 👤`).
4. **Priority Indicators**: Color-coded badges for priority levels (`High 🔴`, `Medium 🟠`, `Low 🟢`).
5. **Form Validation**: Strict validation preventing empty task submission.
6. **Task Status Toggle**: Seamlessly mark tasks as `Completed` or `Pending`.
7. **Task Deletion**: Easily remove tasks from the manager.
8. **Detailed Task View (Screen 3)**: Modal sheet view displaying full task metadata with action controls.
9. **Category Filtering**: Instant visual filtering by status (`All`, `Pending`, `Completed`).

---

## 🏗️ MVC Project Architecture

The application adheres to the required MVC structure:

```
lib/
├── models/
│   └── task.dart               # Task Data Model
├── controllers/
│   └── task_controller.dart    # TaskController state management & metrics
├── views/
│   ├── home_page.dart          # Screen 1: Dashboard & Task List
│   ├── add_task_page.dart      # Screen 2: Add Task Form with validation
│   └── widgets/                # UI Components & Screens
│       ├── task_card.dart      # Individual task card item
│       ├── stat_card.dart      # Metric overview card
│       └── task_detail_sheet.dart # Screen 3: Task Information view
├── theme/
│   └── app_theme.dart          # Light/Dark Material 3 design system
└── main.dart                   # Application Entrypoint & routes
```

---

## 🖥️ Screen Previews & Design Structure

### Screen 1: Home / Dashboard
- **Header**: App title & greeting indicator.
- **Metrics**: 
  - **Total Tasks**: `5`
  - **Completed**: `2`
  - **Pending**: `3`
- **Actions**: `[ Add New Task ]` button.
- **Task List**: Scrollable list with status checkboxes and delete actions.

### Screen 2: Add Task Form
- **Inputs**: Task Name (`TextFormField` with non-empty validator).
- **Categories**: Selectable chips (`Assignment`, `Lecture`, `Research`, `Exam`, `Personal`).
- **Priorities**: Color-coded choice buttons (`High`, `Medium`, `Low`).
- **Submit**: `[ Add Task ]` button.

### Screen 3: Task Information / Details
- **Info**: Title, Category chip with icon, Priority badge, and Status text (`Pending` / `Completed`).
- **Controls**: `[ Complete / Mark Pending ]` and `[ Delete ]` buttons.

---

## ⚡ Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.0.0 or higher)
- Dart SDK (v3.0.0 or higher)
- Android Studio / VS Code / Flutter CLI

### Running the Application

1. **Clone the repository**:
   ```bash
   git clone <YOUR_GIT_REPOSITORY_URL>
   cd "In Class Assigment"
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

### Running Unit Tests

To run the controller logic and state management test suite:
```bash
flutter test
```

---

## 💡 Suggested Git Commit Message
```bash
git add .
git commit -m "Complete Flutter in-class Task Manager challenge"
```
