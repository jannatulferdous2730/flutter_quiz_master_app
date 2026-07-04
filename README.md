# Quiz Master 🎯

A Flutter trivia quiz app built for the mobile application development assignment. Quiz Master lets users test their knowledge across multiple categories with a clean, polished UI, persistent stats, and a full quiz history.

---

## Features

### 1. Home Dashboard
- Welcome header with gradient branding
- **Stats grid** — Total Attempts, Highest Score, Last Score (persisted across app restarts via SharedPreferences)
- **Category grid** — 6 categories, each card shows the question count available
- **Recent Activity** — last 10 quiz results, color-coded by score percentage (green ≥ 80%, amber ≥ 50%, red < 50%)
- Light / Dark theme toggle that persists across sessions

### 2. Quiz Flow
- Up to **10 randomly-sampled questions** per session (configurable via `AppConstants.questionsPerQuiz`)
                                                                            - Progress bar and question counter update on every answer
- Option tiles with animated selection highlight (A / B / C / D letter badges)
- "Next Question" button disabled until an answer is selected; becomes "Finish Quiz" on the last question
- Options are shuffled once at load time — never re-shuffled on rebuild

### 3. Result Screen
- Dynamic greeting based on score (Outstanding / Great Job / Good Effort / Keep Practising)
- Large score display (`X / Y`) with color-coded percentage badge
- Metric cards: Total, Correct, Wrong
- **Play Again** — reshuffles the same category
- **Back to Home** — returns to dashboard which immediately shows updated stats and history

### 4. Persistence
- All quiz results survive a full app kill + relaunch (SharedPreferences)
- History capped at the 10 most recent results (most-recent-first)
- Highest score, total attempts, and last score updated atomically after each quiz

---

## Tech Stack

| Concern | Library |
|---|---|
| State management | `provider` (ChangeNotifier) |
| Routing | `go_router` (declarative) |
| Persistence | `shared_preferences` |
| HTML entity decoding | `html_unescape` |
| UI framework | Flutter + Material 3 |

> **No network calls** are made at runtime. All question and category data is loaded from local JSON asset files. 
---

## Folder Structure

```
flutter_quiz_master_app/
├── assets/data/
│   ├── categories.json        # 6 categories
│   └── questions.json         # 100+ questions across all categories
├── lib/
│   ├── main.dart              # MultiProvider + MaterialApp.router
│   ├── models/                # CategoryModel, QuestionModel, QuizResultModel
│   ├── services/              # QuizDataService (asset loading), StorageService (SharedPreferences)
│   ├── providers/             # ThemeProvider, HomeProvider, QuizProvider
│   ├── routes/                # AppRouter (GoRouter config)
│   ├── theme/                 # AppColors, AppTheme (light + dark)
│   ├── screens/               # HomeScreen, QuizScreen, ResultScreen
│   ├── widgets/
│   │   ├── common/            # LoadingView
│   │   ├── home/              # WelcomeSection, StatsSection, CategorySection, HistorySection + sub-widgets
│   │   ├── quiz/              # QuestionCounter, QuizProgressBar, QuestionCard, OptionTile, QuizNavButtons
│   │   └── result/            # ResultSummaryCard, ResultMetricRow, ResultActionButtons
│   └── utils/                 # AppConstants, CategoryIconHelper
```

---

## Setup & Run

**Prerequisites:** Flutter SDK ≥ 3.12.0

```bash
git clone https://github.com/jannatulferdous2730/flutter_quiz_master_app.git
cd flutter_quiz_master_app
flutter pub get
flutter run
```

To change the number of questions per quiz, edit `lib/utils/constants.dart`:

```dart
static const int questionsPerQuiz = 10; // change this value
```

---

## Architecture Rules

- **Screens** are thin — layout composition only, no business logic
- **Business logic** lives exclusively in Providers
- **Data access** (JSON loading, SharedPreferences) lives exclusively in Services
- **No setState** for app data — only Provider's `notifyListeners()`
- **No API calls** — all data is local JSON

---

## Screenshots

> _Add screenshots here after running the app_

| Home (Light) | Home (Dark) | Quiz | Result |
|---|---|---|---|
| _(screenshot)_ | _(screenshot)_ | _(screenshot)_ | _(screenshot)_ |

---

## Demo Video

> _Add your 3–5 min demo video link here (Google Drive / YouTube)_

---

