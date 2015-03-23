var TicTacToeApp = angular.module('TicTacToeApp', []);

TicTacToeApp.controller('GridCtrl', ['$scope', '$routeParams', '$http',
    function($scope, $routeParams, $http) {
        $http.post('/game/set/', null).success(function(data) {
            // Use the response to update the information
            $scope.moves = data.moves;
            $scope.active_player = data.active_player;

        })
    }
])