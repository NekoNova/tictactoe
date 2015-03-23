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
require "json"
require "yaml"
require "haml"
require "./lib/game"

enable :sessions
set :session_secret, "tic_tac_toe_programming_test_secret"

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
  # This is actually an anti-pattern. We should never, ever store objects inside our session.
  # But in order to keep the test simple, I will ignore this for now.
  session[:game] = YAML::dump(Game.new(params[:player_1], params[:player_2]))

  haml :game
end

# Set's the move by a player.
# This is called from the game using the following parameters:
#
# - row: The row the player clicked on
# - column: The column the player clicked on
# - active_player: The player that set the command.
#
# If the move is considered valid, then HTTP Status 200 will be returned and
# the game can continue.
# If the move is considered invalid, then HTTP Status 400 will be returned.
post "/game/set" do
  data = JSON.parse(request.body.read)  # Manual parsing of the submitted data
  @game = YAML::load(session[:game])
  value = data["active_player"].eql?(@game.player_1) ? Game::PLAYER_1_SYMBOL : Game::PLAYER_2_SYMBOL

  puts data
  puts value

  if @game.set(data["row"], data["column"], value)
    response ={
        moves: @game.moves,
        active_player: @game.active_player,
        status: @game.winner? ? "game over" : "ongoing",
        winner: @game.winner
    }

    session[:game] = YAML::dump(@game)

    status 200
    content_type :json
    response.to_json
  else
    status 400
  end
end

# Returns the players stored in the Game as JSON.
# This is called by Angular after submitting the information, to properly display this
# on the Game page.
get "/players.json" do
  @game = YAML::load(session[:game])

  status 200
  content_type :json

  {
      player_1: @game.player_1,
      player_2: @game.player_2,
      active_player: @game.active_player
  }.to_json
end