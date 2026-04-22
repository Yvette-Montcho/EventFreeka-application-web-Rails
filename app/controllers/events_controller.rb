# app/controllers/events_controller.rb — Gère toutes les actions liées aux événements
# Hérite de ApplicationController pour bénéficier des comportements globaux

class EventsController < ApplicationController
  # ===== FILTRES AVANT ACTION =====

  # Charge l'événement depuis la base de données avant les actions qui en ont besoin
  # Évite la répétition du code @event = Event.find(params[:id]) dans chaque action
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # Exige que l'utilisateur soit connecté pour créer, modifier ou supprimer un événement
  # new, create, edit, update, destroy => actions réservées aux utilisateurs authentifiés
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # Vérifie que seul le créateur (admin) de l'événement peut le modifier ou le supprimer
  before_action :check_event_owner, only: [:edit, :update, :destroy]

  # ===== ACTIONS =====

  # GET /events — Affiche la liste de tous les événements à venir
  def index
    # Récupère tous les événements à venir, triés par date de début croissante
    # includes(:admin) => optimisation : charge les admins en même temps (évite N+1 queries)
    @events = Event.includes(:admin).upcoming
  end

  # GET /events/:id — Affiche le détail d'un événement spécifique
  def show
    # @event est déjà chargé par le before_action :set_event
    # includes permet de charger les participants en même temps pour éviter les requêtes multiples
  end

  # GET /events/new — Affiche le formulaire de création d'un événement
  def new
    # Initialise un objet Event vide pour le formulaire de création
    @event = Event.new
  end

  # POST /events — Traite la soumission du formulaire de création
  def create
    # Crée un nouvel événement avec les paramètres filtrés par event_params
    @event = Event.new(event_params)

    # Associe automatiquement l'événement à l'utilisateur connecté comme administrateur
    @event.admin = current_user

    # Tente de sauvegarder l'événement en base de données
    if @event.save
      # Succès : redirige vers la page de détail avec un message de confirmation
      redirect_to @event, notice: "L'événement a été créé avec succès !"
    else
      # Échec : réaffiche le formulaire avec les erreurs de validation
      render :new, status: :unprocessable_entity
    end
  end

  # GET /events/:id/edit — Affiche le formulaire de modification d'un événement
  def edit
    # @event est déjà chargé par le before_action :set_event
  end

  # PATCH/PUT /events/:id — Traite la soumission du formulaire de modification
  def update
    # Tente de mettre à jour l'événement avec les nouveaux paramètres
    if @event.update(event_params)
      # Succès : redirige vers la page de détail avec un message de confirmation
      redirect_to @event, notice: "L'événement a été mis à jour avec succès !"
    else
      # Échec : réaffiche le formulaire d'édition avec les erreurs
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /events/:id — Supprime un événement
  def destroy
    # Supprime l'événement de la base de données (et ses inscriptions via dependent: :destroy)
    @event.destroy

    # Redirige vers la liste des événements avec un message de confirmation
    redirect_to events_path, notice: "L'événement a été supprimé."
  end

  # ===== MÉTHODES PRIVÉES =====
  private

  # Charge l'événement correspondant à l'ID dans l'URL
  # Utilisée par before_action :set_event
  def set_event
    @event = Event.find(params[:id])
  end

  # Filtre les paramètres autorisés pour la création/modification d'un événement
  # Sécurité : empêche les utilisateurs d'envoyer des paramètres non désirés (mass assignment)
  def event_params
    params.require(:event).permit(
      :title,       # Titre de l'événement
      :description, # Description complète
      :start_date,  # Date et heure de début
      :duration,    # Durée en heures
      :location,    # Lieu de l'événement
      :price        # Prix en euros (0 = gratuit)
    )
  end

  # Vérifie que l'utilisateur connecté est bien le créateur de l'événement
  # Redirige avec une erreur si ce n'est pas le cas
  def check_event_owner
    unless @event.admin == current_user
      redirect_to @event, alert: "Vous n'êtes pas autorisé à effectuer cette action."
    end
  end
end
