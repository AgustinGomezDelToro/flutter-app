# 🌍 Coupe du Monde App (Flutter)

Application Flutter multi-plateforme (Android & Web) pour explorer l’historique de la Coupe du Monde de football :
**Champions, années, meilleurs joueurs, statistiques, palmarès, recherche avancée, etc.**

---

## 🚀 Fonctionnalités principales

- Authentification (inscription/connexion)
- Dashboard interactif avec navigation moderne
- Recherche avancée par pays ou année
- Palmarès (classement des pays par nombre de titres)
- Liste des vainqueurs avec meilleur joueur par édition
- Statistiques globales
- Responsive : fonctionne sur Android et Web

---

## ⚙️ Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.x recommandé)
- [Node.js + Backend API](https://github.com/ton-backend) (API REST compatible, voir section .env)
- Android Studio (pour l’émulateur) ou Chrome (pour le web)

---

## 🛠️ Installation & Lancement

1. **Clone le projet**
   ```bash
   git clone <repo>
   cd flutter-app
   ```

2. **Installe les dépendances**
   ```bash
   flutter pub get
   ```

3. **Configure le fichier `.env` à la racine**
   ```env
   # Pour Android (émulateur)
   API_BASE_URL=http://10.0.2.2:4000
   # Pour le web (navigateur)
   API_BASE_URL_WEB=http://localhost:4000
   ```

4. **Lance le backend Node.js**  
   (Assure-toi qu’il tourne sur le port 4000)

5. **Lance l’application**
   - **Android** :  
     ```bash
     flutter run -d emulator-5554
     ```
   - **Web** :  
     ```bash
     flutter run -d chrome
     ```

---

## 📝 Notes importantes

- **Variables d’environnement** :  
  L’URL de l’API s’adapte automatiquement selon la plateforme (Android ou Web).
- **Déconnexion** :  
  Bouton disponible dans le dashboard (en haut à droite).
- **Données** :  
  Les meilleurs joueurs sont fusionnés côté Flutter à partir de deux endpoints (`/api/champions` et `/api/bestPlayers`).

---

## 📁 Structure du projet

- `lib/` : Code source Flutter (UI, services, modèles)
- `lib/views/` : Pages principales (dashboard, recherche, palmarès, etc.)
- `lib/services/` : Accès API, auth, stockage local
- `.env` : Variables d’environnement (à créer à la racine)

---

## 💡 Astuces

- Pour tester sur un vrai appareil Android, adapte l’URL dans `.env` (`API_BASE_URL` avec l’IP de ton PC).
- Pour enrichir les données, modifie le backend ou adapte la fusion côté Flutter.

---

## 📣 Auteur & Contact

Projet réalisé par [Hberg75 et Agustin]  







