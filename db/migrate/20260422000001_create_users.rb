# db/migrate/20260422000001_create_users.rb — Migration de création de la table users
# Ce fichier est généré automatiquement par Devise via : rails g devise User
# Il crée la table users avec toutes les colonnes nécessaires à l'authentification

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    # Crée la table "users" en base de données avec les colonnes suivantes
    create_table :users do |t|

      # ===== MODULE Database Authenticatable =====
      # Stocke l'email de l'utilisateur (obligatoire, unique, jamais vide)
      t.string :email, null: false, default: ""

      # Stocke le mot de passe hashé avec bcrypt (jamais le mot de passe en clair !)
      t.string :encrypted_password, null: false, default: ""

      # ===== MODULE Recoverable =====
      # Token unique généré lors d'une demande de réinitialisation de mot de passe
      t.string :reset_password_token

      # Date et heure à laquelle la demande de réinitialisation a été envoyée
      # Utilisé pour vérifier que le token n'a pas expiré (valide 6h par défaut)
      t.datetime :reset_password_sent_at

      # ===== MODULE Rememberable =====
      # Date de création du cookie "remember me" (session persistante)
      t.datetime :remember_created_at

      # ===== COLONNES PERSONNALISÉES (non générées par Devise) =====
      # Prénom de l'utilisateur
      t.string :first_name, null: false, default: ""

      # Nom de famille de l'utilisateur
      t.string :last_name, null: false, default: ""

      # Description / biographie de l'utilisateur (facultative)
      t.text :description

      # ===== HORODATAGE AUTOMATIQUE =====
      # created_at => date de création du compte
      # updated_at => date de dernière modification
      # null: false => ces colonnes ne peuvent pas être vides
      t.timestamps null: false
    end

    # ===== INDEX =====
    # Index sur l'email pour des recherches rapides lors de la connexion
    # unique: true => garantit qu'un même email ne peut pas s'inscrire deux fois
    add_index :users, :email, unique: true

    # Index sur le token de réinitialisation pour des recherches rapides
    # unique: true => garantit qu'un même token ne peut pas être utilisé deux fois
    add_index :users, :reset_password_token, unique: true
  end
end
