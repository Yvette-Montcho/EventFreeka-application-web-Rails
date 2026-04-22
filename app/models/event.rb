# app/models/event.rb — Modèle Event : représente un événement de l'application
# Hérite de ApplicationRecord pour accéder à toutes les fonctionnalités ActiveRecord

class Event < ApplicationRecord
  # ===== ASSOCIATIONS =====

  # Un événement appartient à un utilisateur (son créateur / administrateur)
  # foreign_key: :admin_id => la colonne en base de données qui référence l'utilisateur créateur
  belongs_to :admin, class_name: 'User'

  # Un événement peut avoir plusieurs inscriptions de participants
  # dependent: :destroy => si l'événement est supprimé, les inscriptions sont supprimées aussi
  has_many :event_registrations, dependent: :destroy

  # Un événement peut avoir plusieurs participants à travers la table event_registrations
  has_many :participants, through: :event_registrations, source: :user

  # ===== VALIDATIONS =====

  # Le titre de l'événement est obligatoire et limité à 100 caractères
  validates :title, presence: true, length: { maximum: 100 }

  # La description est obligatoire pour informer les participants du contenu
  validates :description, presence: true

  # La date de début est obligatoire
  validates :start_date, presence: true

  # La durée est obligatoire et doit être un nombre positif (en heures)
  validates :duration, presence: true, numericality: { greater_than: 0 }

  # Le lieu est obligatoire pour que les participants sachent où se rendre
  validates :location, presence: true

  # Le prix est obligatoire et doit être un nombre positif ou nul (0 = gratuit)
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # ===== MÉTHODES D'INSTANCE =====

  # Calcule et retourne la date de fin de l'événement
  # La date de fin = date de début + durée (en heures)
  def end_date
    start_date + duration.hours
  end

  # Retourne le nombre de participants inscrits à cet événement
  def participants_count
    participants.count
  end

  # Retourne true si l'événement est gratuit (prix = 0)
  def free?
    price.zero?
  end

  # Retourne true si l'événement est déjà passé (date de fin < maintenant)
  def past?
    end_date < Time.now
  end

  # Retourne true si l'événement est en cours ou à venir
  def upcoming?
    !past?
  end

  # ===== SCOPES =====

  # Scope pour récupérer uniquement les événements à venir, triés par date de début
  scope :upcoming, -> { where('start_date >= ?', Time.now).order(:start_date) }

  # Scope pour récupérer uniquement les événements passés, triés du plus récent au plus ancien
  scope :past, -> { where('start_date < ?', Time.now).order(start_date: :desc) }
end
