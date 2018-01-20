--control.lua

--Set cease fire to false on player join
script.on_event({defines.events.on_player_joined_game}, 
    function(event)
        --game.forces["enemy"].set_cease_fire(game.players[event.player_index].force, false)
	game.players[event.player_index].force.set_turret_attack_modifier("turret", 1)
    end
)

--Set cease fire to true on player leave
script.on_event({defines.events.on_player_left_game}, 
    function(event)
        --game.forces["enemy"].set_cease_fire(game.players[event.player_index].force, true)
	game.players[event.player_index].force.set_turret_attack_modifier("turret", 1000)
    end
)
	
--Set cease fire to all disconnected players forces
script.on_event({defines.events.on_tick},
   function (event)
      if event.tick % 60 == 0 then --reduce how often this runs, every 1 second
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
	      if player_is_connected == true then
		 game.players[event.player_index].force.set_turret_attack_modifier("turret", 1)
	      else
		 game.players[event.player_index].force.set_turret_attack_modifier("turret", 1000)
	      end
	      player_is_connected = false
	   end
	end
      end
   end
)
