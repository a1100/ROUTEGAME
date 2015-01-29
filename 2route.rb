require 'bundler'
Bundler.require

# number guessing game
playerpts, computerpts = 0, 0
get '/guess/:number' do
  player = params[:number].to_i
  numbers = (1..5).to_a
  computer = numbers.sample.to_i
  random = numbers.sample.to_i
  playerdiff = (player - random).abs
  compdiff = (computer - random).abs
  winner = nil
  if numbers.include?(player) == false
    winner = "computer because player did not choose a number from 1-20"
  elsif numbers.include?(player)
    if player = random && computer = random
      playerpts += 2
      computerpts += 2
      winner = "it's a tie!"
      next
    elsif player = random && computer != random
      playerpts += 2
      winner = "player"
      next
    elsif computer = random && player != random
      computerpts += 2
      winner = "computer"
      next
    elsif playerdiff < compdiff
      winner = "player"
      playerpts += 1
      next
    elsif playerdiff > compdiff
      winner = "computer"
      computerpts += 1
      next
    elsif playerdiff == compdiff
      winner = "it's a tie!"
      next
    end
  end
  "Guesses: <br> Player: #{player} | Computer: #{computer}  <br> <br> The winner is...#{winner}!!! <br> The random number was #{random}. <br> <br> Points: <br> Player: #{playerpts} | Computer: #{computerpts} <br> Note: you receive one point for winning a round, and two for exactly guessing the number."
end



