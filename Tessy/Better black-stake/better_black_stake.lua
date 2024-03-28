to_replace = "if G.GAME.modifiers.enable_eternals_in_shop and pseudorandom('stake_shop_joker_eternal'..G.GAME.round_resets.ante) > 0.7 then"
replacement = [[local etern_check = pseudorandom('stake_shop_joker_eternal'..G.GAME.round_resets.ante)
            if etern_check > 0.7 or (G.GAME.modifiers.enable_eternals_in_shop and etern_check > 0.5) then]]
fun_name = "create_card"
file_name = "functions/common_events.lua"

table.insert(mods,
        {
            mod_id = "better_black_stake",
            name = "Better Black Stake",
            version = "1.0.0",
            author = "Tessy of Root",
            description = {
                "Makes the normal effects of black stake on by default, \nand makes black stake increase the chances. "
            },
            enabled = true,
            on_enable = function()
                inject(file_name, fun_name, to_replace:gsub("([^%w])", "%%%1"), replacement:gsub("([^%w])", "%%%1"))


                G.localization.descriptions.Stake['stake_black'].text = { "{C:attention} Eternal{} Jokers will appear more frequently in shops",
                                                                                            "{C:inactive,s:0.8}(Can't be sold or destroyed)",
                                                                                            "{s:0.8}Applies all previous Stakes"
                                                                                          }
                init_localization()
                local patch = [[
                G.localization.descriptions.Stake['stake_black'].text = { "Shop will have {C:attention}more Eternal{} Jokers",
                                                                                            "{C:inactive,s:0.8}(Can't be sold or destroyed)",
                                                                                            "{s:0.8}Applies all previous Stakes"
                                                                                          }
                init_localization()
                ]]
                local toPatch = "init_localization()"

                inject("game.lua", "Game:set_language", toPatch:gsub("([^%w])", "%%%1"), patch)
            end,
             on_disable = function()
                inject(file_name, fun_name, replacement:gsub("([^%w])", "%%%1"), to_replace:gsub("([^%w])", "%%%1")) 

                
                local patch = [[
                G.localization.descriptions.Stake['stake_black'].text = { "Shop will have {C:attention}more Eternal{} Jokers",
                                                                                            "{C:inactive,s:0.8}(Can't be sold or destroyed)",
                                                                                            "{s:0.8}Applies all previous Stakes"
                                                                                          }
                init_localization()
                ]]
                local toPatch = "init_localization()"

                inject("game.lua", "Game:set_language", patch:gsub("([^%w])", "%%%1"), toPatch:gsub("([^%w])", "%%%1"))
                G.localization.descriptions.Stake['stake_black'].text = { "Shop can have {C:attention}Eternal{} Jokerss",
                                                                                            "{C:inactive,s:0.8}(Can't be sold or destroyed)",
                                                                                            "{s:0.8}Applies all previous Stakes"
                                                                                          }
                init_localization()
            end,
        }
)
