-- Jail Commands Mod
-- By homthack and RAPHAEL (mods commands)
-- license: whatever

minetest.register_privilege("jail", { description = "Allows one to send/release prisoners" })

local jailpos = { x = -586, y = 15, z = -125 }

local players_in_jail = { };

minetest.register_chatcommand("jail", {
    params = "<player>",
    description = "Sends a player to Jail",
	privs = {jail=true},
    func = function ( name, param )
        local player = minetest.env:get_player_by_name(param)
        if (player) then
            players_in_jail[param] = player;
            player:setpos(jailpos)
			minetest.chat_send_player(param, "You have been sent to jail")
			minetest.chat_send_all(""..param.." has been sent to jail by "..name.."")
        end
    end,
})


local releasepos = {x = -21,y = 36,z = 115}
 
minetest.register_chatcommand("release", {
    params = "<player>",
    description = "Releases a player from Jail",
	privs = {jail=true},
    func = function ( name, param )
        if (param == "") then return end
        local player = minetest.env:get_player_by_name(param)
        players_in_jail[param] = nil;
        if (player) then
            player:setpos(releasepos)
			minetest.chat_send_player(param, "You are free now, behave better.")
			minetest.chat_send_all(""..param.." has been released from jail by "..name.."")
        end
    end,
})

local function do_teleport ( )
    for name, player in pairs(players_in_jail) do
            player:setpos(jailpos)
    end
    minetest.after(15, do_teleport)
end
minetest.after(15, do_teleport)

