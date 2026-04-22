# config/initializers/devise.rb — Fichier de configuration principal de la gem Devise
# Ce fichier est généré automatiquement par : rails generate devise:install
# Il contient tous les paramètres de configuration de l'authentification

Devise.setup do |config|
  # ===== CONFIGURATION DES EMAILS =====

  # Adresse email expéditrice pour tous les emails envoyés par Devise
  # IMPORTANT : à modifier avec une vraie adresse email pour la production
  config.mailer_sender = 'noreply@eventfreeka.com'

  # ===== CONFIGURATION ORM =====

  # Indique à Devise d'utiliser ActiveRecord comme ORM (base de données)
  # require 'devise/orm/mongoid' pour MongoDB
  require 'devise/orm/active_record'

  # ===== CONFIGURATION DE L'AUTHENTIFICATION =====

  # Colonne utilisée pour l'authentification (par défaut : :email)
  # On peut changer pour :username si on veut s'authentifier avec un pseudo
  config.authentication_keys = [:email]

  # Insensible à la casse pour les emails (jean@email.com = JEAN@EMAIL.COM)
  config.case_insensitive_keys = [:email]

  # Retire les espaces en début et fin d'email (évite les erreurs de saisie)
  config.strip_whitespace_keys = [:email]

  # Maintient la session de l'utilisateur après la fermeture du navigateur
  # false => la session expire à la fermeture du navigateur (plus sécurisé)
  config.skip_session_storage = [:http_auth]

  # ===== CONFIGURATION DES MOTS DE PASSE =====

  # Algorithme de hashage des mots de passe (bcrypt est le standard recommandé)
  # Le "coût" de 12 rend le hashage plus lent et donc plus résistant aux attaques
  config.stretches = Rails.env.test? ? 1 : 12

  # Durée de validité des tokens de mémorisation ("remember me") — 2 semaines
  config.remember_for = 2.weeks

  # Durée de validité des tokens de réinitialisation de mot de passe — 6 heures
  config.reset_password_within = 6.hours

  # ===== CONFIGURATION DES SESSIONS =====

  # Durée maximale d'inactivité avant déconnexion automatique (module Timeoutable)
  config.timeout_in = 30.minutes

  # ===== CONFIGURATION DES TENTATIVES DE CONNEXION =====

  # Nombre maximum de tentatives de connexion échouées avant blocage du compte (module Lockable)
  config.maximum_attempts = 20

  # Durée de blocage du compte après trop de tentatives échouées (module Lockable)
  config.unlock_in = 1.hour

  # ===== CONFIGURATION DE SÉCURITÉ =====

  # En production, utilise les paramètres de sécurité maximaux pour les cookies
  # En développement, permet les requêtes HTTP sans HTTPS
  config.navigational_formats = ['*/*', :html, :turbo_stream]

  # Protection CSRF pour les requêtes de connexion
  config.clean_up_csrf_token_on_authentication = true

  # ===== CONFIGURATION DES REDIRECTIONS =====

  # Message d'alerte quand un utilisateur non connecté tente d'accéder à une page protégée
  # config.failure_app = ...

  # Par défaut, Devise redirige vers la page d'accueil après déconnexion
  # Pour changer la redirection : surcharger after_sign_out_path_for dans ApplicationController
end
