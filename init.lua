minetest.register_on_joinplayer(function(player)
	if player:get_attribute("rank_color") == nil then
		player:set_attribute("rank_color", "green")
	end
	
	if player:get_attribute("rank_name") == nil then
		player:set_attribute("rank_name", "Player")
	end
end)




minetest.register_privilege("rank_master", {description = "Can create ranks and also grant them"})

minetest.register_chatcommand("rank", {
	description = "Create a rank and give player a rank",
	privs = {rank_master=true},
	func = function(name, param)
	local param1 = param:split(' ')[1]
	local param2 = param:split(' ')[2]
	local param3 = param:split(' ')[3]
	local player = minetest.get_player_by_name(param1)
	
	if not player then
		return
		minetest.chat_send_player(name, "player is not online")
	end
	
	if param2 == "" then
		return
		minetest.chat_send_player(name, "rank name is missing")
	else
		player:set_attribute("rank_name", param2)
	end
	
	if param3 == "blue" or param3 == "red" or param3 == "yellow" or param3 == "green" or param3 == "black" or param3 == "white" then
		player:set_attribute("rank_color", param3)
	else
		return
		minetest.chat_send_player(name, "Invaild rank color you can use red, blue, yellow, green, black, white") 
	end
	end
})



rank_color = {
	red = "#FF0000",
	blue = "#0000FF",
	yellow = "FFFF00",
	green = "#008000",
	black = "#000000",
	white = "#FFFFFF"
}


minetest.register_on_chat_message(function(name, message)
    local player = minetest.get_player_by_name(name) 
	if player:get_attribute("rank_color") == nil then return end
	if player:get_attribute("rank_name") == nil then return end
    minetest.chat_send_all(""..minetest.colorize(rank_color[player:get_attribute("rank_color")], player:get_attribute("rank_name")).." <"..name.."> "..message)
	
	return true
end)
