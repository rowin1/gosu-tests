require 'gosu'
require_relative 'states/game_state'
require_relative 'states/menu_state'
require_relative 'states/play_state'
require_relative 'entities/die'
require_relative 'entities/yahtzee'
require_relative 'game_window'
require_relative 'utils'


$window = GameWindow.new
GameState.switch(MenuState.instance)
$window.show
