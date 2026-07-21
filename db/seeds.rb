# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Reset
Deck.destroy_all
User.destroy_all

# Users
tom = User.create!(username: "tom", email: "tom@example.com", password: "secret123")
jerry = User.create!(username: "jerry", email: "jerry@example.com", password: "secret123")

# Decks
world_cup_deck = Deck.create!(title: "World Cup 2026", user: tom)
nba_deck = Deck.create!(title: "NBA Legends", user: jerry)

# World Cup 2026 — Question 1
q1 = Question.create(question: "Who scored for France in the 2006 World Cup Semi Final against Brazil?")
q1.update(deck: world_cup_deck)
q1.options.create!(response: "Thierry Henry", is_solution: true)
q1.options.create!(response: "Zinedine Zidane", is_solution: false)
q1.options.create!(response: "Franck Ribéry", is_solution: false)
q1.options.create!(response: "Patrick Vieira", is_solution: false)

# World Cup 2026 — Question 2
q2 = Question.create(question: "Which country won the first World Cup in 1930?")
q2.update(deck: world_cup_deck)
q2.options.create!(response: "Uruguay", is_solution: true)
q2.options.create!(response: "Argentina", is_solution: false)
q2.options.create!(response: "Brazil", is_solution: false)
q2.options.create!(response: "USA", is_solution: false)

# World Cup 2026 — Question 3
q3 = Question.create(question: "Which countries are jointly hosting the 2026 World Cup?")
q3.update(deck: world_cup_deck)
q3.options.create!(response: "USA, Canada & Mexico", is_solution: true)
q3.options.create!(response: "USA only", is_solution: false)
q3.options.create!(response: "Mexico & Brazil", is_solution: false)
q3.options.create!(response: "Canada only", is_solution: false)

# World Cup 2026 — Question 4
q4 = Question.create(question: "How many teams will compete in the 2026 World Cup, up from 32?")
q4.update(deck: world_cup_deck)
q4.options.create!(response: "48", is_solution: true)
q4.options.create!(response: "40", is_solution: false)
q4.options.create!(response: "36", is_solution: false)
q4.options.create!(response: "64", is_solution: false)

# NBA Legends — Question 1
n1 = Question.create(question: "Who is the NBA's all-time leading scorer as of 2023?")
n1.update(deck: nba_deck)
n1.options.create!(response: "LeBron James", is_solution: true)
n1.options.create!(response: "Kareem Abdul-Jabbar", is_solution: false)
n1.options.create!(response: "Karl Malone", is_solution: false)
n1.options.create!(response: "Kobe Bryant", is_solution: false)

# NBA Legends — Question 2
n2 = Question.create(question: "Which player is known as 'The Greek Freak'?")
n2.update(deck: nba_deck)
n2.options.create!(response: "Giannis Antetokounmpo", is_solution: true)
n2.options.create!(response: "Joel Embiid", is_solution: false)
n2.options.create!(response: "Nikola Jokić", is_solution: false)
n2.options.create!(response: "Luka Dončić", is_solution: false)

# NBA Legends — Question 3
n3 = Question.create(question: "Which team drafted Michael Jordan in 1984?")
n3.update(deck: nba_deck)
n3.options.create!(response: "Chicago Bulls", is_solution: true)
n3.options.create!(response: "Portland Trail Blazers", is_solution: false)
n3.options.create!(response: "Houston Rockets", is_solution: false)
n3.options.create!(response: "Boston Celtics", is_solution: false)

# NBA Legends — Question 4
n4 = Question.create(question: "Who holds the NBA record for most championships won as a player?")
n4.update(deck: nba_deck)
n4.options.create!(response: "Bill Russell", is_solution: true)
n4.options.create!(response: "Michael Jordan", is_solution: false)
n4.options.create!(response: "Kareem Abdul-Jabbar", is_solution: false)
n4.options.create!(response: "Magic Johnson", is_solution: false)
