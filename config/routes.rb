# config/routes.rb — Définition de toutes les routes de l'application EventFreeka
# Chaque route fait le lien entre une URL HTTP et une action d'un controller

Rails.application.routes.draw do
  # ===== ROUTES DEVISE =====
  # devise_for génère automatiquement toutes les routes d'authentification :
  # /users/sign_in, /users/sign_up, /users/sign_out, /users/password/new, etc.
  devise_for :users

  # ===== ROUTES DES UTILISATEURS =====
  # resources :users génère les routes RESTful pour le modèle User
  # On n'expose que :show (page de profil) et :edit/:update (modification du profil)
  # pour ne pas laisser les routes :index, :new, :create, :destroy accessibles publiquement
  resources :users, only: [:show, :edit, :update]

  # ===== ROUTES DES ÉVÉNEMENTS =====
  # resources :events génère les 7 routes RESTful pour le modèle Event
  # index  => GET  /events          => events#index  (liste de tous les événements)
  # new    => GET  /events/new      => events#new    (formulaire de création)
  # create => POST /events          => events#create (soumission du formulaire)
  # show   => GET  /events/:id      => events#show   (détail d'un événement)
  # edit   => GET  /events/:id/edit => events#edit   (formulaire de modification)
  # update => PATCH/PUT /events/:id => events#update (soumission de la modification)
  # destroy=> DELETE /events/:id    => events#destroy(suppression)
  resources :events

  # ===== PAGE D'ACCUEIL =====
  # root définit la page d'accueil de l'application (URL : "/")
  # Elle affiche la liste des événements via events#index
  root 'events#index'
end
