# Portfolio Projekt – SS 2025
Erhan Kesbic
erhan.kesbic@mnd.thm.de
Matrikenummer: 5228557y
Dies ist mein Flutter-Projekt im Rahmen des Praktikums für das Sommersemester 2025. In diesem Projekt wird eine einfache Flutter-App entwickelt, die als Startseite für mein Portfolio dient.

## 📦 Projektinformationen
- **Flutter-Version:** 3.29.3
- **Dart-Version:** 3.7.2
- **DevTools-Version:** 2.42.3
- **Matrikelnummer:** 1234567
- **GitHub-Repo:** [portfolio_1234567](https://github.com/dein-benutzername/portfolio_1234567)

## 🚀 Projekt starten

1. **Abhängigkeiten installieren:**
   ```bash
   flutter pub get
   flutter run

   ## 🌿 Git-Branching-Strategie

- **`main`-Branch**: Der `main`-Branch enthält die stabile Version des Projekts. Alle getesteten und funktionierenden Änderungen werden hier zusammengeführt.
- **Feature-Branches**: Neue Features oder Änderungen werden in separaten Branches entwickelt, zum Beispiel `feature/startseite` für die Entwicklung der Startseite.
- **Merge-Strategie**: Nach Fertigstellung eines Features wird der entsprechende Feature-Branch in den `main`-Branch gemerged. Dies kann entweder direkt oder über einen Pull Request erfolgen.
- **Branch-Naming-Konvention**: Feature-Branches werden mit dem Präfix `feature/` benannt, gefolgt von einer kurzen Beschreibung des Features (z. B. `feature/startseite`).

Diese Strategie sorgt für eine klare Trennung zwischen stabiler Version und neuen Funktionen und ermöglicht eine bessere Zusammenarbeit im Team.

## 📱 App-Übersicht

Die App besteht aus vier interaktiven Seiten, die über die Startseite (HomePage) erreichbar sind:

1. **Slider-Seite** (`slider_page.dart`)
   - Enthält einen Slider von 0 bis 100 (ganzzahlig).
   - Der aktuelle Wert wird groß angezeigt.
   - Ein Farbfeld ändert seine Farbe dynamisch je nach Wert.

2. **Profilseite** (`profile_form_page.dart`)
   - Formular mit Name, E-Mail (mit Validierung) und "Über mich" (mehrzeilig).
   - Nach dem Absenden erscheint ein Dialog mit den Eingaben.
   - Die Eingaben bleiben beim erneuten Öffnen erhalten.

3. **Einstellungsseite** (`settings_page.dart`)
   - Zwei Checkboxen (Newsletter, Benachrichtigungen) und zwei Switches (Dunkler Modus, Offline-Modus).
   - Am Seitenende wird die aktuelle Auswahl zusammengefasst angezeigt.
   - Die Einstellungen bleiben während der App-Laufzeit erhalten.

4. **Zusammenfassungsseite** (`summary_page.dart`)
   - Zeigt alle eingegebenen und gewählten Daten übersichtlich in Cards an (Profil, Slider-Wert, Einstellungen).
   - Navigation erfolgt über die HomePage per Button (`Navigator.push`).

## 🔄 Navigation
- Die Navigation zwischen den Seiten erfolgt von der HomePage aus über Buttons.
- Die Daten werden im State der HomePage gehalten und per Konstruktorparameter an die anderen Seiten übergeben.
- Es wird kein externes State-Management verwendet, sondern Flutter-typisch mit StatefulWidget und Navigator.

