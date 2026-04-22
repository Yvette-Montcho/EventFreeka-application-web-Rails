# db/seeds.rb — Script de génération de données fictives pour le développement
# Exécuté avec la commande : rails db:seed
# Utilise la gem Faker pour générer des données réalistes automatiquement

# Nettoie les données existantes avant de reseed pour éviter les doublons
# L'ordre de suppression respecte les contraintes de clés étrangères
puts "🧹 Nettoyage des données existantes..."
Event.destroy_all   # Supprime tous les événements (et inscriptions via dependent: :destroy)
User.destroy_all    # Supprime tous les utilisateurs

puts "👤 Création des utilisateurs..."

# Création de 5 utilisateurs fictifs avec Faker
users = 5.times.map do |i|
  User.create!(
    # Génère un prénom aléatoire en français
    first_name: Faker::Name.first_name,

    # Génère un nom de famille aléatoire
    last_name: Faker::Name.last_name,

    # Génère un email unique en ajoutant l'index pour éviter les doublons
    email: Faker::Internet.unique.email,

    # Mot de passe fixe pour faciliter les tests en développement
    password: "password123",

    # Confirmation du mot de passe (requis par Devise)
    password_confirmation: "password123",

    # Génère une description courte et aléatoire
    description: Faker::Lorem.sentence(word_count: 15)
  )
end

puts "✅ #{users.count} utilisateurs créés"

puts "🎉 Création des événements..."

# Liste des villes africaines pour les événements
cities = ["Dakar", "Abidjan", "Casablanca", "Nairobi", "Accra", "Lagos", "Tunis", "Bamako"]

# Catégories d'événements variées
event_titles = [
  "Concert de Jazz en plein air",
  "Atelier Cuisine Africaine",
  "Hackathon Tech for Africa",
  "Festival de Mode Africaine",
  "Conférence sur l'Entrepreneuriat",
  "Tournoi de Football Quartier",
  "Expo d'Art Contemporain",
  "Soirée Networking Startups",
  "Workshop Design Graphique",
  "Marché Artisanal du Dimanche",
  "Atelier Photographie Urbaine",
  "Forum des Femmes Leaders"
]

# Crée 12 événements répartis entre les utilisateurs
event_titles.each_with_index do |title, index|
  # Associe chaque événement à un utilisateur de manière cyclique
  admin = users[index % users.count]

  # Génère des événements dans le futur (entre 1 et 90 jours)
  # rand(1..90) génère un nombre aléatoire entre 1 et 90
  start_date = rand(1..90).days.from_now + rand(8..20).hours

  Event.create!(
    # Titre de l'événement (issu de la liste définie ci-dessus)
    title: title,

    # Description fictive de 3 à 5 phrases
    description: Faker::Lorem.paragraphs(number: 2).join("\n\n"),

    # Date de début : entre 1 et 90 jours dans le futur
    start_date: start_date,

    # Durée aléatoire entre 1 et 8 heures (par pas de 0.5)
    duration: [1, 1.5, 2, 2.5, 3, 4, 5, 6, 8].sample,

    # Lieu aléatoire parmi les villes africaines
    location: "#{Faker::Address.street_name}, #{cities.sample}",

    # Prix aléatoire : 0 (gratuit), 5, 10, 15, 20, 25, 50 euros
    price: [0, 0, 0, 5, 10, 15, 20, 25, 50].sample,

    # Administrateur / créateur de l'événement
    admin: admin
  )
end

puts "✅ #{Event.count} événements créés"
puts ""
puts "🎊 Données de test générées avec succès !"
puts "📧 Email de connexion : #{users.first.email}"
puts "🔑 Mot de passe : password123"
