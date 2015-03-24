var TicTacToeApp = angular.module('TicTacToeApp', []);

// Define the controller for the Game Application that will be running TicTacToe Client side.
TicTacToeApp.controller('GameCtrl', ['$scope', '$http', '$window',
    function($scope, $http, $window) {
        // Perform a get call to /players.json to obtain the registered player names
        // and store them on the scope of our application.
        $http.get('/players.json').success(function(data) {
            $scope.player_1 = data.player_1;
            $scope.player_2 = data.player_2;
            $scope.active_player = data.active_player
        });

    // Define a function that will be called every time a player clicks on the squares of the grid.
    // The function will set the respective value in the back-end, updating the game status.
    $scope.setField = function($event, row, column) {
        // If a winner has already been declared, then stop the game.
        if ($scope.winner != null) {
            return;
        }

        var data_hash = {
            row: row,
            column: column,
            active_player: $scope.active_player
        };

        // Perform the post function and react on a successful response, updating the local
        // scope with the correct information.
        $http.post("/game/set", data_hash)
            .success(function(data, status, headers, config) {
                // The response was successful, this means we need to perform the following operations:
                // - update the current data
                $scope.active_player = data.active_player;
                $scope.moves = data.moves;
                $scope.winner = data.winner;
                // set the field with the correct Symbol, based on the new active_player
                $event.target.innerHTML = $scope.active_player == $scope.player_1 ? "X" : "O";
            })
            .error(function(data, status, headers, config) {
                alert("You cannot set this field");
            })
    };

    // resets the game, allowing people to play again.
    $scope.resetGame = function() {
        $http.post("/game/reset", {})
            .success(function(data, status, headers, config) {
                $window.location.reload();
            })
    };

    // Shows the ranking of the game.
    $scope.displayRanking = function() {
        $window.location = "/score"
    }
}]);

// Filter to properly display the winner or not
TicTacToeApp.filter('winner', function() {
    return function(input, trueValue, falseValue) {
        return input ? trueValue : falseValue;
    }
});