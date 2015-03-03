require 'bundler'
Bundler.require
get '/play' do
  "You can play the guessing game from this page. Enter a random number guess from 1-20 after /play/guess in the url."
end

# number guessing game
playerpts, computerpts = 0, 0
invalid_enters = 0
get '/play/guess/:number' do
  player = params[:number].to_i
  numbers = (1..20).to_a
  computer = numbers.sample.to_i
  random = numbers.sample.to_i
  playerdiff = (player - random).abs
  compdiff = (computer - random).abs
  winner = nil
  if numbers.include?(player) == false
    invalid_enters += 1
    winner = "computer because player did not choose a number from 1-20"
    if invalid_enters > 1
      playerpts -= 1
    end
  else
    if playerdiff == compdiff
      winner = "it's a tie!"
    elsif playerdiff < compdiff
      winner = "player"
      if player == random
        playerpts += 2
      else
        playerpts += 1
      end
    elsif compdiff < playerdiff
      winner = "computer"
        if computer == random
          computerpts += 2
        else
          computerpts += 1
        end
    end
  end
  "Guesses: <br> Player: #{player} | Computer: #{computer}  <br> <br> The winner is...#{winner}!!! <br> The random number was #{random}. <br> <br> Points: <br> Player: #{playerpts} | Computer: #{computerpts} <br> <br> Note: you receive one point for winning a round, and two for exactly guessing the number. <br> Also if you invalidly guess a number more than once, you will lose a point."
end




