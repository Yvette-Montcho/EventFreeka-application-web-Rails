# Gemfile — Déclaration de toutes les dépendances (gems) du projet Rails

# Version minimale de Ruby requise pour ce projet
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Version de Ruby utilisée (adapter selon ton environnement local)
ruby '3.1.0'

# Framework principal : Ruby on Rails version 7
gem 'rails', '~> 7.0.0'

# Base de données SQLite pour le développement local
gem 'sqlite3', '~> 1.4'

# Serveur web Puma (inclus par défaut avec Rails)
gem 'puma', '~> 5.0'

# Compilation des assets CSS/JS pour le navigateur
gem 'sprockets-rails'

# Importmaps : gère les modules JS sans bundler (approche Rails 7 moderne)
gem 'importmap-rails'

# Turbo : navigation sans rechargement complet de page (SPA-like)
gem 'turbo-rails'

# Stimulus : petit framework JS léger pour enrichir les vues Rails
gem 'stimulus-rails'

# Jbuilder : génération de réponses JSON dans les vues
gem 'jbuilder'

# ===== GEMS PRINCIPALES DU PROJET =====

# Devise : gem d'authentification complète (login, logout, inscription, récupération de mot de passe)
gem 'devise'

# Bootstrap via bundle RubyGems (intègre Bootstrap 5 directement dans le pipeline d'assets)
gem 'bootstrap', '~> 5.2.0'

# Sassc-rails : permet d'utiliser des fichiers SCSS (nécessaire pour Bootstrap)
gem 'sassc-rails'

# Letter Opener : affiche les emails dans le navigateur en développement (au lieu de les envoyer)
gem 'letter_opener', group: :development

# Pagy : pagination légère et performante pour les listes d'événements
gem 'pagy', '~> 6.0'

# ===== GEMS DE DÉVELOPPEMENT ET TEST =====

group :development, :test do
  # Débogueur interactif : permet de mettre des points d'arrêt dans le code
  gem 'debug', platforms: %i[mri mingw x64_mingw]

  # Faker : génère des données fictives pour le seed (noms, emails, descriptions...)
  gem 'faker', '~> 3.0'
end

group :development do
  # Web Console : affiche une console Rails dans le navigateur en cas d'erreur
  gem 'web-console'
end

group :test do
  # Capybara : simule les interactions utilisateur dans les tests système
  gem 'capybara'

  # Selenium Webdriver : pilote de navigateur pour les tests d'intégration
  gem 'selenium-webdriver'
end

# Gems spécifiques à Windows (ignorées sur les autres plateformes)
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
