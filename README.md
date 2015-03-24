# TicTacToe
This is a simple programming test to see how someone codes and thinks when solving a problem.

## Requirements
You are required to implement a fully-functioning version of TicTacToe

- It is a 2-player game (no computer opponent)
- Before each round the players are asked for their names
- Players switch after every turn
- Once a round is finished, the winner (or draw) will be displayed on a leaderboard

The following bonuses apply

- +1 if you write tests/specs
- +1 if you code is documented
- +1 if you build the frontent with a modern JavaScript framework

### Technical Requirements
- You are required to use git for versioning
- The application should run with a backend written in Ruby (Rails is not a must)
- Use SQLite if you chose to implement persistence. However, you are not required to.
- Feel free to use any plugin/gem to help you get the task done more effectively
- Google Chrome is the testing browser

## Implementation
So far, I've created the back-end using Sinatra as Back-end Webserver and Ruby
This allows me to store the logic on the server and not so much in the front-end.
The reasons for this are:

- The back-end is more secure for checking the game logic, preventing tampering
- I'm not that proficient in front-end stuff, and it's simply easier for me as I'm a back-end guy
- The back-end class Game.rb is completely under RSpec coverage.

The Front-End is being done with AngularJS. After browsing various Javascript Frameworks, this one appealed the
most to me, as it uses MVC and allows you to separate the JS completely from the application, binding it
on the fly. **Spending most time here now, as I need to look up many things**, but I'm actually enjoying the work
I'm doing with Angular, and slowly I'm becoming more familiar with it.

## Installation and running the game
In order to prepare the environment, you need to have the following installed:

- Ruby or RVM
- Bundler

Run the following commands

    bundle install
    ruby tictactoe.rb

After that, open **Chrome** and redirect it to `http://localhost:4567`

To stop the webserver, simply press `ctrl + c` in the terminal to kill the Sinatra app.


# Screenshot
![screenshot](http://i.imgur.com/VLIXRXD.png)