--control.lua

script.on_event({defines.events.on_player_joined_game}, 
    function(event)
        game.forces["enemy"].set_cease_fire(game.players[event.player_index].name, false)
    end
)

script.on_event({defines.events.on_player_left_game}, 
    function(event)
        game.forces["enemy"].set_cease_fire(game.players[event.player_index].name, true)
    end
)
	


