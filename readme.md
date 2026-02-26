# PlayByPlay – Live Tournament Scoreboard (Flutter + Firebase)

PlayByPlay is a mobile-first scoreboard app for community sports tournaments. It helps organizers, players, and spectators follow matches in real time, with live scores and simple player stats, instead of relying on scattered WhatsApp messages or handwritten score sheets.

The app is built using Flutter for the frontend and Firebase for the backend, focusing on a clean UI, real-time updates, and a realistic end-to-end mobile experience.

---

## Problem Statement

Community sports tournaments often struggle to provide live score updates or player stats, which limits engagement for both spectators and participants. People on the ground keep asking for the latest score, and people who are not at the venue have no easy way to follow the game.

PlayByPlay attempts to solve this by offering a simple tournament companion app where:

- Organizers can set up tournaments, teams, and fixtures.
- Scorers or volunteers can update scores live from the ground.
- Spectators and players can see live scores and basic stats from anywhere.

---

## Project Context (Sprint #2)

This project is part of the “Simulated Work – Mobile Application Development with Flutter & Firebase” Sprint #2.

The goal for this sprint is to ship a Minimum Viable Product (MVP) that:

- Has a working Flutter UI with core screens.
- Uses Firebase Authentication and Cloud Firestore.
- Supports live score updates for matches.
- Is stable enough to demo end-to-end with real data.

The idea is not to build every possible feature, but to build a focused, reliable mobile experience that shows good engineering decisions and proper integration between Flutter and Firebase.

---

## Target Users

- Organizers of local or community tournaments.
- Scorers or volunteers who handle match scoring on the field.
- Spectators and players who want to follow live scores and schedules.

---

## Scope for Sprint #2

In scope (MVP):

- Flutter app with core screens:
  - Authentication (for organizers/scorers).
  - Home screen with a list of tournaments or matches.
  - Match detail screen with live score and basic stats.
- Firebase:
  - Firebase Auth (email/password or Google).
  - Firestore for storing tournaments, teams, matches, and stats.
- Real-time updates using Firestore streams.
- Basic state management using Provider or Riverpod.
- A demo-ready APK (and optionally a web build).

Out of scope (for this sprint):

- Push notifications.
- Advanced analytics or dashboards.
- Complex multi-season stats and leaderboards.
- Support for wearables, TV, or other platforms.

---

## Core Features (MVP)

1. Tournament and Match Management

- Create a tournament with details like name, sport, location, and dates.
- Add teams to a tournament.
- Create matches with information such as Team A vs Team B, time, and ground.

2. Live Scoring

- Set match status: Not Started, Live, or Finished.
- Update scores for each team as the match progresses.
- Reflect score changes in real time for all connected clients using Firestore streams.

3. Spectator View

- View ongoing, upcoming, and completed matches.
- Open a match to see:
  - Current score.
  - Match status.
  - Basic metadata (teams, time, ground).

4. Basic Player Stats

- Track simple per-match stats for players (for example, goals or runs).
- Display key stats for each team on the match details screen.
- Keep the stat model minimal so it stays manageable within the sprint.

---

## Tech Stack

- Flutter (Dart) for the mobile application.
- Firebase as Backend-as-a-Service:
  - Firebase Authentication.
  - Cloud Firestore.
  - (Optionally) Firebase Storage for logos or images.
- State management with Provider or Riverpod.
- GitHub for version control.
- GitHub Actions and Firebase Hosting for CI/CD and deployment (for the web version, if used).

---

## Data Model (Draft)

This is a simple, sprint-friendly version of the data model:

- `users`
  - `id`
  - `name`
  - `email`
  - `role` (ORGANIZER, SCORER, VIEWER)

- `tournaments`
  - `id`
  - `name`
  - `sport`
  - `location`
  - `startDate`
  - `endDate`
  - `createdBy` (userId)

- `teams`
  - `id`
  - `tournamentId`
  - `name`
  - `logoUrl` (optional)

- `matches`
  - `id`
  - `tournamentId`
  - `teamAId`
  - `teamBId`
  - `startTime`
  - `status` (NOT_STARTED, LIVE, FINISHED)
  - `scoreTeamA`
  - `scoreTeamB`
  - `groundName`

- `playerStats`
  - `id`
  - `matchId`
  - `teamId`
  - `playerName`
  - `stat1` (e.g., goals or runs)
  - `stat2` (e.g., assists or wickets)

This structure is intentionally generic so that it can support different sports without rewriting the entire backend.

---

## High-Level Architecture

- Flutter UI:
  - Implements the screens for authentication, home, match list, match details, and basic settings/profile if needed.
  - Uses widgets and reactive updates.

- State Layer (Provider or Riverpod):
  - Manages the current user and their role.
  - Subscribes to Firestore streams for live data.
  - Handles loading and error states.

- Firebase:
  - Authentication manages sign-in/sign-up and access control for organizers and scorers.
  - Firestore stores all tournament, match, and stats data and provides real-time updates.

The general flow is:

User → Flutter UI → State Management → Firebase (Auth + Firestore) → UI updates in real time.

---

## Sprint Timeline (Planned)

Week 1 – Setup and Design

- Finalize the problem statement and solution approach.
- Decide on user roles, flows, and data model.
- Create simple wireframes for the main screens.
- Set up the Flutter project and Firebase project and agree on folder structure.

Week 2 – Core Development

- Implement authentication flow (if required for MVP).
- Set up Firestore collections and basic read/write operations.
- Build the Home screen, match list, and match details screens.

Week 3 – Integration and Testing

- Connect the UI to Firestore using real-time streams.
- Add role-based access for organizers/scorers.
- Test the main flows: create tournament, create match, update score, view live match.
- Handle validation and error states where needed.

Week 4 – MVP Completion and Deployment

- Polish the UI and fix critical bugs.
- Prepare an APK (and optionally a web build).
- Finalize documentation, including this README.
- Get the app ready for demo.

---

## Functional Requirements

- Users can view tournaments and matches without friction.
- Authorized users (organizers or scorers) can create and manage tournaments and matches.
- Scorers can update match scores and status in real time.
- Spectators can see live scores and statuses without manual refresh.

---

## Non-Functional Requirements

- The app should feel responsive and usable on common Android devices.
- Live updates should reflect within a short delay, leveraging Firestore’s real-time capabilities.
- Firestore rules and Firebase Auth should be used to protect write operations.
- The UI should be reasonably clean and consistent, even if not fully “production design”.

---

## Getting Started (Local Setup)

1. Clone the repository  
   `git clone <repo-url>`

2. Install dependencies  
   `flutter pub get`

3. Set up Firebase
   - Create a Firebase project from the console.
   - Add an Android app (and web app if needed).
   - Download and place `google-services.json` in the `android/app` directory.
   - Configure Firebase in the Flutter app (for example, using `flutterfire` CLI to generate `firebase_options.dart`).

4. Run the app  
   `flutter run`

These steps might be updated and refined as the project structure becomes more concrete.

---

## Success Criteria for Sprint #2

- All MVP flows (create tournament, create match, update scores, view live scores) work end-to-end.
- Firebase Auth and Firestore integration are stable and correctly wired to the UI.
- At least one APK build is available and can be installed and tested.
- The project plan and the implemented app stay consistent with each other.

---

## Future Directions

After the MVP, there are several natural extensions:

- Push notifications for match start, half-time, and full-time.
- Detailed player profiles and season-wise statistics.
- Leaderboards for top players and teams.
- More polished design and animations.
- Admin tools for managing multiple tournaments or seasons.

For now, the focus of PlayByPlay is to prove a simple idea well: community tournaments should be easy to follow, and live scores should be accessible to everyone, not just the people standing next to the scorer’s table.
