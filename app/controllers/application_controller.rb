# app/controllers/application_controller.rb — Controller de base dont héritent tous les autres controllers
# C'est ici qu'on configure les comportements globaux qui s'appliquent à toute l'application

class ApplicationController < ActionController::Base
  # ===== CONFIGURATION DE DEVISE =====

  # before_action exécute configure_devise_parameters avant chaque action d'un controller Devise
  # if: :devise_controller? => ce filtre ne s'active que pour les controllers de Devise
  before_action :configure_devise_parameters, if: :devise_controller?

  # Méthode qui déclare les paramètres supplémentaires autorisés par Devise
  # Par défaut Devise n'accepte que :email, :password, :password_confirmation
  # Ici on autorise aussi :first_name, :last_name et :description
  def configure_devise_parameters
    # Paramètres autorisés lors de l'inscription (sign_up)
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    # Paramètres autorisés lors de la mise à jour du compte (account_update)
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:first_name, :last_name, :description, :email, :password,
               :password_confirmation, :current_password)
    end
  end

  # ===== GESTION DES ERREURS D'ACCÈS =====

  # Méthode utilitaire appelée depuis les controllers enfants pour bloquer les accès non autorisés
  # Elle redirige vers la page d'accueil avec un message d'erreur
  def redirect_unless_owner(resource)
    # Vérifie si l'utilisateur connecté est bien le propriétaire de la ressource
    unless current_user == resource
      # Affiche un message d'erreur dans le flash (notification temporaire)
      redirect_to root_path, alert: "Vous n'avez pas accès à cette page."
    end
  end
end
