# app/models/user.rb — Modèle User : représente un utilisateur de l'application
# Ce fichier hérite de ApplicationRecord qui lui donne accès à ActiveRecord (ORM Rails)

class User < ApplicationRecord
  # Inclusion des modules Devise pour gérer l'authentification complète :
  # :database_authenticatable => stocke le mot de passe hashé en base de données
  # :registerable             => permet la création, modification et suppression de compte
  # :recoverable              => permet la réinitialisation du mot de passe par email
  # :rememberable             => gère le cookie "remember me" (session persistante)
  # :validatable              => ajoute des validations sur l'email et le mot de passe
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ===== ASSOCIATIONS =====

  # Un utilisateur peut créer plusieurs événements (relation 1-N)
  # dependent: :destroy => si l'utilisateur est supprimé, ses événements le sont aussi
  has_many :events, foreign_key: :admin_id, dependent: :destroy

  # Un utilisateur peut s'inscrire à plusieurs événements via la table de jointure EventRegistration
  has_many :event_registrations, dependent: :destroy

  # Un utilisateur peut participer à plusieurs événements à travers ses inscriptions
  has_many :registered_events, through: :event_registrations, source: :event

  # ===== VALIDATIONS =====

  # Le prénom est obligatoire et ne peut pas dépasser 50 caractères
  validates :first_name, presence: true, length: { maximum: 50 }

  # Le nom de famille est obligatoire et ne peut pas dépasser 50 caractères
  validates :last_name, presence: true, length: { maximum: 50 }

  # La description est facultative mais limitée à 500 caractères
  validates :description, length: { maximum: 500 }, allow_blank: true

  # ===== MÉTHODES D'INSTANCE =====

  # Retourne le nom complet de l'utilisateur (prénom + nom)
  # Exemple : "Jean Dupont"
  def full_name
    "#{first_name} #{last_name}"
  end
end
