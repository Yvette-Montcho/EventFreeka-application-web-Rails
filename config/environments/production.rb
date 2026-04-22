# config/environments/production.rb — Configuration de l'environnement de production (Heroku)
# Ce fichier configure Rails pour le déploiement en production
# Les paramètres ici optimisent la performance et la sécurité

Rails.application.configure do
  # ===== CONFIGURATION GÉNÉRALE =====

  # En production, le code est compilé une seule fois au démarrage (plus performant)
  config.cache_classes = true

  # Charge toutes les classes au démarrage pour éviter les délais à la première requête
  config.eager_load = true

  # N'affiche PAS les messages d'erreur détaillés aux visiteurs (sécurité)
  config.consider_all_requests_local = false

  # Active le cache des pages statiques par le serveur web
  config.action_controller.perform_caching = true

  # ===== CONFIGURATION ACTION MAILER =====

  # URL de base pour les liens dans les emails en production
  # IMPORTANT : remplacer YOURAPPNAME par le nom réel de votre application Heroku
  # Cette ligne est indispensable pour les emails de réinitialisation de mot de passe Devise
  config.action_mailer.default_url_options = { host: 'YOURAPPNAME.herokuapp.com' }

  # Utilise SMTP pour l'envoi réel des emails en production (ex: SendGrid sur Heroku)
  config.action_mailer.delivery_method = :smtp

  # Active l'envoi réel des emails en production
  config.action_mailer.perform_deliveries = true

  # Lève une exception si l'envoi d'email échoue (pour pouvoir le détecter dans les logs)
  config.action_mailer.raise_delivery_errors = false

  # ===== CONFIGURATION DES ASSETS =====

  # Compile les assets en production (CSS/JS minifiés et compressés)
  config.assets.compile = false

  # Active le fingerprinting des assets (ajoute un hash au nom de fichier pour le cache)
  # Cela force le navigateur à recharger les assets quand ils changent
  config.assets.digest = true

  # ===== CONFIGURATION DES LOGS =====

  # Niveau de log en production : seulement les infos importantes
  config.log_level = :info

  # Utilise un format de log standard pour les outils de monitoring
  config.log_tags = [:request_id]

  # ===== CONFIGURATION DE SÉCURITÉ =====

  # Force les connexions HTTPS en production (obligatoire pour la sécurité)
  config.force_ssl = true

  # ===== CONFIGURATION I18N =====

  # Ne lève pas d'exception pour les traductions manquantes en production
  config.i18n.fallbacks = true
end
