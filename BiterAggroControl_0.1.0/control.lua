--control.lua

--Set cease fire to false on player join
script.on_event({defines.events.on_player_joined_game}, 
    function(event)
        game.forces["enemy"].set_cease_fire(game.players[event.player_index].force, false)
    end
)

--Set cease fire to true on player leave
script.on_event({defines.events.on_player_left_game}, 
    function(event)
        game.forces["enemy"].set_cease_fire(game.players[event.player_index].force, true)
    end
)
	
--Set cease fire to all disconnected players forces
script.on_event({defines.events.on_tick},
   function (event)
      if event.tick % 600 == 0 then --reduce how often this runs, every 10 seconds
	local player_is_connected = false
         -- Set all forces to friendly
	for name, force in pairs (game.forces) do
	   for player_name, player in pairs (force.players) do
	      for connected_player_name, connected_player in pairs (force.connected_players) do
		 if player_name == connected_player_name then
		    player_is_connected = true
		 end
	      end
	      -- Set enemy cease fire state to opposite of the connected state
	      game.forces["enemy"].set_cease_fire(force, not player_is_connected)
	      player_is_connected = false
	   end
	end
      end
   end
)
