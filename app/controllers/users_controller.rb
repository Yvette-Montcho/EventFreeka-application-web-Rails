# app/controllers/users_controller.rb — Gère les actions liées aux profils utilisateurs
# Note : Devise gère déjà sessions, registrations et passwords → on ne gère ici que les profils

class UsersController < ApplicationController
  # ===== FILTRES AVANT ACTION =====

  # Charge l'utilisateur depuis la base de données avant les actions :show, :edit, :update
  before_action :set_user, only: [:show, :edit, :update]

  # Exige que l'utilisateur soit connecté pour accéder au profil
  # Les visiteurs non connectés sont redirigés vers la page de connexion
  before_action :authenticate_user!, only: [:show, :edit, :update]

  # Vérifie que l'utilisateur connecté accède uniquement à son propre profil
  # Un utilisateur ne peut pas voir ou modifier le profil d'un autre utilisateur
  before_action :check_profile_owner, only: [:show, :edit, :update]

  # ===== ACTIONS =====

  # GET /users/:id — Affiche la page de profil d'un utilisateur
  def show
    # Charge les événements créés par cet utilisateur, triés du plus récent au plus ancien
    @created_events = @user.events.order(start_date: :desc)

    # Charge les événements auxquels l'utilisateur est inscrit comme participant
    @registered_events = @user.registered_events.upcoming
  end

  # GET /users/:id/edit — Affiche le formulaire de modification du profil (nom, prénom, description)
  # Note : la modification de l'email et du mot de passe se fait via Devise (registrations#edit)
  def edit
    # @user est déjà chargé par le before_action :set_user
  end

  # PATCH/PUT /users/:id — Traite la soumission du formulaire de modification du profil
  def update
    # Tente de mettre à jour les informations du profil avec les paramètres filtrés
    if @user.update(user_params)
      # Succès : redirige vers la page de profil avec un message de confirmation
      redirect_to @user, notice: "Votre profil a été mis à jour avec succès !"
    else
      # Échec : réaffiche le formulaire d'édition avec les messages d'erreur
      render :edit, status: :unprocessable_entity
    end
  end

  # ===== MÉTHODES PRIVÉES =====
  private

  # Charge l'utilisateur correspondant à l'ID dans l'URL
  def set_user
    @user = User.find(params[:id])
  end

  # Filtre les paramètres autorisés pour la modification du profil utilisateur
  # Sécurité : seuls ces champs peuvent être modifiés via ce formulaire
  # L'email et le mot de passe sont gérés séparément par Devise
  def user_params
    params.require(:user).permit(
      :first_name,  # Prénom de l'utilisateur
      :last_name,   # Nom de famille de l'utilisateur
      :description  # Courte biographie ou présentation
    )
  end

  # Vérifie que l'utilisateur connecté est bien le propriétaire du profil demandé
  # Sécurité : empêche un utilisateur d'accéder au profil d'un autre
  def check_profile_owner
    unless current_user == @user
      # Redirige vers la page d'accueil avec un message d'erreur d'autorisation
      redirect_to root_path, alert: "Vous n'avez pas accès à cette page."
    end
  end
end
