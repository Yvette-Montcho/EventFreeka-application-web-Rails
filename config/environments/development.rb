# config/environments/development.rb — Configuration de l'environnement de développement
# Ce fichier configure Rails pour le développement local uniquement
# Ne jamais utiliser ces paramètres en production !

Rails.application.configure do
  # ===== CONFIGURATION GÉNÉRALE =====

  # Recharge le code à chaque requête (indispensable pour voir ses modifications sans redémarrer)
  config.cache_classes = false

  # Lève une exception si une action est suspendue pendant plus de X secondes
  config.eager_load = false

  # Affiche des messages d'erreur détaillés dans le navigateur en cas de problème
  config.consider_all_requests_local = true

  # Active le serveur de développement du cache
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # ===== CONFIGURATION ACTION MAILER =====

  # URL de base pour les liens dans les emails envoyés par Devise en développement
  # Cette ligne est INDISPENSABLE pour que les emails de réinitialisation de mot de passe fonctionnent
  # Elle permet à Devise de construire des URLs absolues (avec http://localhost:3000) dans les emails
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # Letter Opener : intercepte les emails et les ouvre dans le navigateur au lieu de les envoyer
  # Nécessite la gem 'letter_opener' dans le Gemfile
  config.action_mailer.delivery_method = :letter_opener

  # Affiche les emails dans le navigateur web lors de leur envoi (via letter_opener)
  config.action_mailer.perform_deliveries = true

  # Affiche les erreurs d'envoi d'email dans la console du serveur
  config.action_mailer.raise_delivery_errors = true

  # ===== CONFIGURATION DES ASSETS =====

  # Active le débogage des assets (charge les fichiers CSS/JS séparément pour faciliter le debug)
  config.assets.debug = true

  # Désactive la compression des assets en développement (compilation plus rapide)
  config.assets.quiet = true

  # ===== CONFIGURATION DES LOGS =====

  # Affiche les requêtes SQL dans la console du serveur (utile pour le débogage)
  config.log_level = :debug

  # Affiche les tags de log (request UUID) pour tracer les requêtes
  config.log_tags = [:request_id]

  # ===== CONFIGURATION I18N =====

  # Lève une exception si une traduction est manquante (évite les textes manquants silencieux)
  config.i18n.raise_on_missing_translations = true

  # ===== CONFIGURATION ACTIVE RECORD =====

  # Affiche des avertissements si des requêtes N+1 sont détectées (performance)
  # config.active_record.verbose_query_logs = true
end
