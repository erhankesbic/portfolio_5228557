# Portfolio App – SS 2025

**Autor:** Erhan Kesbic  
**E-Mail:** erhan.kesbic@mnd.thm.de  
**Matrikelnummer:** 5228557

Dies ist mein Flutter-Projekt für das Sommersemester 2025. Die App dient als persönliche Portfolio-Startseite und demonstriert verschiedene Flutter-Features, State-Handling und UI-Design.

---

## 🚀 Schnellstart

1. **Repository klonen:**
   ```bash
   git clone https://github.com/erhankesbic/portfolio_5228557.git
   cd portfolio_5228557
   ```
2. **Abhängigkeiten installieren:**
   ```bash
   flutter pub get
   ```
3. **App starten:**
   ```bash
   flutter run
   ```

---

## 📦 Projektinfos

- **Flutter-Version:** 3.29.3
- **Dart-Version:** 3.7.2
- **DevTools-Version:** 2.42.3
- **GitHub-Repo:** [portfolio_5228557](https://github.com/erhankesbic/portfolio_5228557)

---

## 🌿 Git-Branching-Strategie

- **main:** Stabile Version
- **feature/**: Neue Features werden in separaten Branches entwickelt (z. B. `feature/startseite`)
- **Merge:** Nach Fertigstellung werden Features in `main` gemerged (direkt oder per Pull Request)

---

## 📱 App-Übersicht

Die App besteht aus mehreren Seiten, die über das Hauptmenü erreichbar sind:

- **Home:** Übersicht & Navigation
- **About:** Persönliche Infos und Bild
- **Work:** Projektübersicht mit Bildern (siehe `assets/images/`)
- **Profile:** Formular für Name, E-Mail (mit Validierung), Über mich
- **Settings:** Checkboxen (Newsletter, Benachrichtigungen), Switches (Dark Mode, Offline)
- **Summary:** Übersicht aller eingegebenen Daten
- **Contact:** Kontaktformular

**Navigation:**
- Über das App-Drawer-Menü oder Buttons auf der Startseite
- State wird lokal in ViewModels gehalten (kein externes State-Management)

**Assets:**
- Bilder liegen in `assets/images/` und werden in der Work-Übersicht angezeigt

---

## 🛠️ Ordnerstruktur (Auszug)

- `lib/`
  - `pages/` – Alle Seiten der App
  - `models/` – Datenmodelle (z. B. User, WorkItem)
  - `repositories/` – Datenhaltung (z. B. UserRepository)
  - `services/` – Hilfsdienste (z. B. Navigation, Validierung)
  - `theme/` – App-Design und Farben
  - `widgets/` – Wiederverwendbare UI-Komponenten

---

## 📸 Screenshots & Demo

Bilder und Beispielprojekte findest du im Ordner `assets/images/`.

---

## 📄 Lizenz

Dieses Projekt ist ausschließlich für Studienzwecke im Rahmen des Praktikums an der THM gedacht.

