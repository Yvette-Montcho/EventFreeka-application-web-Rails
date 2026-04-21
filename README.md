# 🎉 EventFreeka

**EventFreeka** est une application web Rails permettant de découvrir, créer et gérer des événements (concerts, conférences, ateliers, soirées) dans sa ville. Elle intègre un système d'authentification complet via la gem **Devise**.

> **Nom de repository GitHub recommandé :** `eventfreeka-rails-devise`

---

## 📋 Fonctionnalités

| Fonctionnalité | Description |
|---|---|
| 🔐 Authentification | Inscription, connexion, déconnexion via Devise |
| 📧 Récupération de mot de passe | Email de réinitialisation (letter_opener en dev) |
| 👤 Profil utilisateur | Page de profil avec la liste des événements créés |
| 🎫 Gestion d'événements | Créer, afficher, modifier, supprimer des événements |
| 🛡️ Autorisation | Seul le créateur d'un événement peut le modifier/supprimer |
| 📱 Design responsive | Interface Bootstrap 5 adaptée mobile/tablette/desktop |
| 🌱 Données de démonstration | Seed avec 3 utilisateurs et 6 événements |

---

## 🛠️ Technologies utilisées

- **Ruby** 4.0.1
- **Ruby on Rails** 8.1.3
- **SQLite3** (base de données de développement)
- **Devise** 4.9 (authentification complète)
- **Bootstrap** 5.3 (framework CSS, via CDN)
- **Bootstrap Icons** 1.11 (icônes SVG, via CDN)
- **letter_opener** (affichage des emails en développement)

---

## ⚙️ Prérequis

Avant de lancer le projet, assurez-vous d'avoir installé :

- [Ruby](https://www.ruby-lang.org/) >= 3.2
- [Ruby on Rails](https://rubyonrails.org/) >= 7.0
- [Git](https://git-scm.com/)
- [VS Code](https://code.visualstudio.com/) (recommandé)

---

## 🚀 Installation et lancement avec VS Code

### 1. Cloner le repository

```bash
git clone https://github.com/VOTRE_USERNAME/eventfreeka-rails-devise.git
cd eventfreeka-rails-devise
```

### 2. Ouvrir dans VS Code

```bash
code .
```

### 3. Ouvrir le terminal intégré VS Code

> **Menu** → `Terminal` → `Nouveau terminal`
> Raccourci clavier : **Ctrl + \`** (backtick)

### 4. Installer les dépendances Ruby

```bash
bundle install
```

### 5. Configurer la base de données

```bash
rails db:create
rails db:migrate
rails db:seed
```

> Le seed crée automatiquement 3 utilisateurs et 6 événements de démonstration.

### 6. Lancer le serveur de développement

```bash
rails server
```

### 7. Ouvrir dans le navigateur

Rendez-vous sur [http://localhost:3000](http://localhost:3000)

---

## 🔑 Comptes de démonstration

Après le seed, vous pouvez vous connecter avec ces comptes :

| Email | Mot de passe | Utilisateur |
|---|---|---|
| mamadou@eventfreeka.com | password123 | Mamadou Diallo |
| fatou@eventfreeka.com | password123 | Fatou Ndiaye |
| kofi@eventfreeka.com | password123 | Kofi Mensah |

---

## 📂 Structure du projet

```
eventfreeka/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb   # Controller de base + config Devise params
│   │   ├── events_controller.rb        # CRUD événements + autorisation propriétaire
│   │   ├── pages_controller.rb         # Page d'accueil avec événements à venir
│   │   └── users_controller.rb         # Page profil (accès restreint au propriétaire)
│   ├── models/
│   │   ├── user.rb                     # Modèle User + modules Devise + full_name
│   │   └── event.rb                    # Modèle Event + validations + end_date + scopes
│   └── views/
│       ├── devise/                     # Vues Devise stylisées avec Bootstrap
│       │   ├── sessions/new            # Page de connexion
│       │   ├── registrations/new       # Page d'inscription
│       │   ├── registrations/edit      # Modification du compte (email/mdp/bio)
│       │   ├── passwords/new           # Demande de réinitialisation de mot de passe
│       │   └── passwords/edit          # Formulaire de nouveau mot de passe
│       ├── events/                     # Vues CRUD pour les événements
│       │   ├── index                   # Liste de tous les événements
│       │   ├── show                    # Détail complet d'un événement
│       │   ├── new                     # Formulaire de création
│       │   ├── edit                    # Formulaire de modification
│       │   └── _form                   # Partial formulaire partagé (new + edit)
│       ├── pages/home                  # Page d'accueil : hero + événements + stats
│       ├── shared/_navbar              # Barre de navigation partagée (toutes pages)
│       └── layouts/application         # Layout principal + Bootstrap CDN + flash
├── config/
│   ├── routes.rb                       # Routes REST + Devise + root
│   ├── initializers/devise.rb          # Configuration Devise
│   └── environments/development.rb     # Mailer letter_opener + URL options
├── db/
│   ├── migrate/                        # Migrations : DeviseCreateUsers + CreateEvents
│   └── seeds.rb                        # Données de démonstration (3 users, 6 events)
└── Gemfile                             # Gems : Devise, letter_opener
```

---

## 🗺️ Routes principales

| Méthode | URL | Controller#Action | Description |
|---|---|---|---|
| GET | `/` | `pages#home` | Page d'accueil |
| GET | `/events` | `events#index` | Liste des événements |
| GET | `/events/new` | `events#new` | Formulaire de création |
| POST | `/events` | `events#create` | Créer un événement |
| GET | `/events/:id` | `events#show` | Détail d'un événement |
| GET | `/events/:id/edit` | `events#edit` | Formulaire de modification |
| PATCH | `/events/:id` | `events#update` | Modifier un événement |
| DELETE | `/events/:id` | `events#destroy` | Supprimer un événement |
| GET | `/users/:id` | `users#show` | Page profil utilisateur |
| GET | `/users/sign_up` | `devise/registrations#new` | Inscription |
| GET | `/users/sign_in` | `devise/sessions#new` | Connexion |
| DELETE | `/users/sign_out` | `devise/sessions#destroy` | Déconnexion |
| GET | `/users/password/new` | `devise/passwords#new` | Mot de passe oublié |
| GET | `/users/edit` | `devise/registrations#edit` | Modifier email/mdp |

---

## 🧩 Extensions VS Code recommandées

Installez ces extensions avant de travailler sur le projet. Allez dans l'onglet **Extensions** de VS Code (**Ctrl+Shift+X**) et recherchez chaque extension par son identifiant.

| Extension | Identifiant VS Code | Utilité |
|---|---|---|
| **Ruby LSP** | `Shopify.ruby-lsp` | Autocomplétion, linting, go-to-definition Ruby |
| **Rails** | `bung87.rails` | Navigation rapide Modèle/Vue/Controller, snippets Rails |
| **ERB Linter** | `manuelpuyol.erblint` | Analyse et linting des fichiers `.html.erb` |
| **Prettier** | `esbenp.prettier-vscode` | Formatage automatique du code à la sauvegarde |
| **GitLens** | `eamodio.gitlens` | Historique Git, blame, comparaison de branches |
| **Thunder Client** | `rangav.vscode-thunder-client` | Tester les routes HTTP GET/POST/PATCH/DELETE |
| **SQLite Viewer** | `qwtel.sqlite-viewer` | Visualiser la base de données SQLite directement dans VS Code |
| **GitHub Copilot** | `GitHub.copilot` | Suggestions de code par IA (nécessite un compte GitHub) |

### Configuration VS Code recommandée

Créez ou modifiez le fichier `.vscode/settings.json` à la racine du projet :

```json
{
  "editor.formatOnSave": true,
  "editor.tabSize": 2,
  "files.insertFinalNewline": true,
  "ruby.lsp.enabled": true,
  "[ruby]": {
    "editor.defaultFormatter": "Shopify.ruby-lsp"
  },
  "[erb]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
```

---

## 📧 Emails en développement

Les emails (réinitialisation de mot de passe) sont interceptés par **letter_opener** et s'ouvrent automatiquement dans votre navigateur par défaut. Aucune configuration SMTP n'est nécessaire en développement.

---

## 🔄 Commandes utiles

```bash
# Réinitialiser et re-seeder la base de données
rails db:reset

# Voir toutes les routes de l'application
rails routes

# Lancer la console Rails interactive
rails console

# Vérifier l'état des migrations
rails db:migrate:status

# Lancer les tests
rails test
```

---

## 📝 Notes pédagogiques — Devise

Devise est une gem Rails d'authentification qui génère automatiquement les migrations, le modèle, les routes, les controllers et les vues nécessaires à un système d'authentification complet.

### Helpers Devise disponibles dans les vues et controllers

```ruby
user_signed_in?      # → true/false selon si un utilisateur est connecté
current_user         # → l'objet User connecté (nil si non connecté)
authenticate_user!   # → redirige vers /users/sign_in si non connecté
```

### Modules Devise activés dans ce projet

| Module | Rôle |
|---|---|
| `database_authenticatable` | Stockage et vérification du mot de passe hashé (bcrypt) |
| `registerable` | Inscription, modification et suppression de compte |
| `recoverable` | Réinitialisation du mot de passe par email |
| `rememberable` | Cookie "remember me" (session persistante) |
| `validatable` | Validation format email et longueur minimale du mot de passe |

---

## 🌐 Déploiement sur Heroku

```bash
# Ajouter l'URL de production dans config/environments/production.rb
config.action_mailer.default_url_options = { host: 'VOTRE_APP.herokuapp.com' }

# Déployer
heroku create eventfreeka
git push heroku main
heroku run rails db:migrate
heroku run rails db:seed
```

---

*Projet réalisé dans le cadre de la formation **The Hacking Project** — Module Rails avancé (Devise), Semaine 7 - Jour 2.*
