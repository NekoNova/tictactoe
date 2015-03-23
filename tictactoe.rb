# TicTacToe programming test
# ===========================
#
# This file is the loaded from command line to fire up the application.
# It auto-includes all required files needed for the app to run properly.
#
# The game is a basic form of TicTacToe where two players play on a 3x3 field.
# The front end is kept rather simple, using basic AJAX calls towards the back-end
# where all logic is stored.
#
# The reason behind this is, is security. Too much logic in the JS side allows tampering with the
# game logic, which we want to prevent to keep the game fair.
# The other reason being that my knowledge about JavaScript is limited compared to my Ruby knowledge.
#
require "sinatra"

# Route definitions
# =================
#
# Here all the routes for the web application are defined.
# These routes are needed by the game for the callbacks to check whether the moves made by the players are
# valid, and whether the game is finished or not.
#
#
# Shows the home page of the application. On this page both players are able to enter their name.
# This information is then submitted to the "/game" URL which will start the game.
get "/" do
  haml :welcome
end

# Accepts the player names and starts the game.
# When the game is properly set up, the game screen is shown and all feature requests are being done
# through the JavaScript library to ensure that the settings cannot be tampered with.
post "/game" do

end

# Set's the move by a player.
# This is called from the game using the following parameters:
#
# - row: The row the player clicked on
# - col: The column the player clicked on
# - player: The player that executed the action, either 1 or 2
#
# If the move is considered valid, then HTTP Status 200 will be returned and
# the game can continue.
# If the move is considered invalid, then HTTP Status 400 will be returned.
post "/game/set" do

end

# Returns a JSON hash containing the current status of the game.
# The information returned will be:
#
# active_player: The currently active player, either 1 or 2
# status: ongoing/game over
# winner: The player who won the game, either 1 or 2
get "/game/status" do

end