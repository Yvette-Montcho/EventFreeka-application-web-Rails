# db/migrate/20260422000002_create_events.rb — Migration de création de la table events
# Exécuter avec : rails db:migrate

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    # Crée la table "events" en base de données avec toutes les colonnes nécessaires
    create_table :events do |t|

      # Titre de l'événement (obligatoire, chaîne de caractères)
      t.string :title, null: false

      # Description complète de l'événement (texte long, obligatoire)
      t.text :description, null: false

      # Date et heure de début de l'événement (obligatoire)
      t.datetime :start_date, null: false

      # Durée de l'événement en heures (obligatoire, nombre décimal)
      # Décimal pour permettre des durées comme 1.5h, 2.5h, etc.
      t.decimal :duration, precision: 4, scale: 1, null: false

      # Lieu de l'événement (adresse ou nom du lieu, obligatoire)
      t.string :location, null: false

      # Prix de l'événement en euros (0 = gratuit, obligatoire)
      # precision: 8 => jusqu'à 99 999 999.99 €
      # scale: 2     => 2 décimales pour les centimes
      t.decimal :price, precision: 8, scale: 2, null: false, default: 0

      # Référence vers l'utilisateur créateur / administrateur de l'événement
      # null: false => chaque événement doit avoir un créateur
      # foreign_key: true => contrainte d'intégrité référentielle en base de données
      t.references :admin, null: false, foreign_key: { to_table: :users }

      # Horodatage automatique : created_at et updated_at
      t.timestamps
    end

    # Index sur la date de début pour des recherches et tris rapides par date
    add_index :events, :start_date

    # Index sur la clé étrangère admin_id pour des jointures rapides
    # (déjà créé par t.references mais explicitement ajouté pour clarté)
    # add_index :events, :admin_id  # déjà créé par t.references
  end
end
