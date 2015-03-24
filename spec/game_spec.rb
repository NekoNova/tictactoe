require "spec_helper"
require "game"

RSpec.describe Game, "#constructor" do
  before(:each) do
    @game = Game.new
  end

  context "initialization" do
    it "sets the default values" do
      expect(@game.player_1).to eq "player 1"
      expect(@game.player_2).to eq "player 2"
      expect(@game.grid).to_not eq nil
      expect(@game.moves).to eq 0
      expect(@game.winner).to eql nil
    end
  end
end

RSpec.describe Game, "#winner" do
  before(:each) do
    @game = Game.new
  end

  context "with no moves set" do
    it "returns true and does not set the winner" do
      expect(@game.winner?).to be_falsey
      expect(@game.moves).to eq 0
      expect(@game.winner).to eq nil
    end
  end

  context "with 5 moves made for a quick win" do
    it "returns true and sets the winning player" do
      @game.set(0,0,Game::PLAYER_1_SYMBOL)
      @game.set(1,0,Game::PLAYER_2_SYMBOL)
      @game.set(0,1,Game::PLAYER_1_SYMBOL)
      @game.set(2,0,Game::PLAYER_2_SYMBOL)
      @game.set(0,2,Game::PLAYER_1_SYMBOL)

      expect(@game.winner?).to be_truthy
      expect(@game.moves).to eq 5
      expect(@game.winner).to eq "player 1"
    end

    it "updates the score properly" do
      @game.set(0,0,Game::PLAYER_1_SYMBOL)
      @game.set(1,0,Game::PLAYER_2_SYMBOL)
      @game.set(0,1,Game::PLAYER_1_SYMBOL)
      @game.set(2,0,Game::PLAYER_2_SYMBOL)
      @game.set(0,2,Game::PLAYER_1_SYMBOL)

      expect(@game.winner?).to be_truthy
      expect(@game.player_1_score).to eq 1
    end

    it "does not change the settings after a winner is declared" do
      @game.set(0,0,Game::PLAYER_1_SYMBOL)
      @game.set(1,0,Game::PLAYER_2_SYMBOL)
      @game.set(0,1,Game::PLAYER_1_SYMBOL)
      @game.set(2,0,Game::PLAYER_2_SYMBOL)
      @game.set(0,2,Game::PLAYER_1_SYMBOL)

      expect(@game.winner?).to be_truthy
      expect(@game.winner).to eq "player 1"


      @game.set(0,0,Game::PLAYER_2_SYMBOL)
      @game.set(0,1,Game::PLAYER_2_SYMBOL)
      @game.set(0,2,Game::PLAYER_2_SYMBOL)

      expect(@game.winner?).to be_truthy
      expect(@game.winner).to eq "player 1"
    end

    it "does not set a winner after 9 moves" do
      # O O X
      # X X O
      # O O X
      @game.set(0,0,Game::PLAYER_1_SYMBOL)
      @game.set(0,1,Game::PLAYER_1_SYMBOL)
      @game.set(0,2,Game::PLAYER_2_SYMBOL)
      @game.set(1,0,Game::PLAYER_2_SYMBOL)
      @game.set(1,1,Game::PLAYER_2_SYMBOL)
      @game.set(1,2,Game::PLAYER_1_SYMBOL)
      @game.set(2,0,Game::PLAYER_1_SYMBOL)
      @game.set(2,1,Game::PLAYER_1_SYMBOL)
      @game.set(2,2,Game::PLAYER_2_SYMBOL)

      expect(@game.winner?).to be_falsey
      expect(@game.winner).to be_nil
    end
  end
end

RSpec.describe Game, "#init_game" do
  before(:each) do
    @game = Game.new
  end

  context "with an ongoing game" do
    it "properly resets the game" do
      @game.set(0,0,Game::PLAYER_1_SYMBOL)
      @game.set(1,0,Game::PLAYER_2_SYMBOL)
      @game.set(0,1,Game::PLAYER_1_SYMBOL)
      @game.set(2,0,Game::PLAYER_2_SYMBOL)
      @game.init_game

      expect(@game.player_1).to eq "player 1"
      expect(@game.player_2).to eq "player 2"
      expect(@game.grid[0][0]).to eq nil
      expect(@game.moves).to eq 0
      expect(@game.winner).to eql nil
    end
  end
end

RSpec.describe Game, "#active_player" do
  before(:each) do
    @game = Game.new
  end

  context "on game init" do
    it "is player 1 by default" do
      expect(@game.active_player).to eq "player 1"
    end
  end

  context "during an ongoing game" do
    it "swaps between sets" do
      @game.set(0,0,Game::PLAYER_1_SYMBOL)
      expect(@game.active_player).to eq "player 2"

      @game.set(1,0,Game::PLAYER_2_SYMBOL)
      expect(@game.active_player).to eq "player 1"

      @game.set(0,1,Game::PLAYER_1_SYMBOL)
      expect(@game.active_player).to eq "player 2"

      @game.set(2,0,Game::PLAYER_2_SYMBOL)
      expect(@game.active_player).to eq "player 1"
    end
  end
end