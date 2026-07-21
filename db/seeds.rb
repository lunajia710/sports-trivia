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
q1 = world_cup_deck.questions.create!(question: "Who scored for France in the 2006 World Cup Semi Final against Brazil?")
q1.options.create!(response: "Thierry Henry", is_solution: true)
q1.options.create!(response: "Zinedine Zidane")
q1.options.create!(response: "Franck Ribéry")
q1.options.create!(response: "Patrick Vieira")

# World Cup 2026 — Question 2
q2 = world_cup_deck.questions.create!(question: "Which country won the first World Cup in 1930?")
q2.options.create!(response: "Uruguay", is_solution: true)
q2.options.create!(response: "Argentina")
q2.options.create!(response: "Brazil")
q2.options.create!(response: "USA")

# World Cup 2026 — Question 3
q3 = world_cup_deck.questions.create!(question: "Which countries are jointly hosting the 2026 World Cup?")
q3.options.create!(response: "USA, Canada & Mexico", is_solution: true)
q3.options.create!(response: "USA only")
q3.options.create!(response: "Mexico & Brazil")
q3.options.create!(response: "Canada only")

# World Cup 2026 — Question 4
q4 = world_cup_deck.questions.create!(question: "How many teams will compete in the 2026 World Cup, up from 32?")
q4.options.create!(response: "48", is_solution: true)
q4.options.create!(response: "40")
q4.options.create!(response: "36")
q4.options.create!(response: "64")

# NBA Legends — Question 1
n1 = nba_deck.questions.create!(question: "Who is the NBA's all-time leading scorer as of 2023?")
n1.options.create!(response: "LeBron James", is_solution: true)
n1.options.create!(response: "Kareem Abdul-Jabbar")
n1.options.create!(response: "Karl Malone")
n1.options.create!(response: "Kobe Bryant")

# NBA Legends — Question 2
n2 = nba_deck.questions.create!(question: "Which player is known as 'The Greek Freak'?")
n2.options.create!(response: "Giannis Antetokounmpo", is_solution: true)
n2.options.create!(response: "Joel Embiid")
n2.options.create!(response: "Nikola Jokić")
n2.options.create!(response: "Luka Dončić")

# NBA Legends — Question 3
n3 = nba_deck.questions.create!(question: "Which team drafted Michael Jordan in 1984?")
n3.options.create!(response: "Chicago Bulls", is_solution: true)
n3.options.create!(response: "Portland Trail Blazers")
n3.options.create!(response: "Houston Rockets")
n3.options.create!(response: "Boston Celtics")

# NBA Legends — Question 4
n4 = nba_deck.questions.create!(question: "Who holds the NBA record for most championships won as a player?")
n4.options.create!(response: "Bill Russell", is_solution: true)
n4.options.create!(response: "Michael Jordan")
n4.options.create!(response: "Kareem Abdul-Jabbar")
n4.options.create!(response: "Magic Johnson")
