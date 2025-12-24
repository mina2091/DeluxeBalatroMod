
-- you can have shared helper functions
function shakecard(self) --visually shake a card
    G.E_MANAGER:add_event(Event({
        func = function()
            self:juice_up(0.5, 0.5)
            return true
        end
    }))
end

function return_JokerValues() -- not used, just here to demonstrate how you could return values from a joker
    if context.joker_main and context.cardarea == G.jokers then
        return {
            chips = card.ability.extra.chips,       -- these are the 3 possible scoring effects any joker can return.
            mult = card.ability.extra.mult,         -- adds mult (+)
            x_mult = card.ability.extra.x_mult,     -- multiplies existing mult (*)
            card = self,                            -- under which card to show the message
            colour = G.C.CHIPS,                     -- colour of the message, Balatro has some predefined colours, (Balatro/globals.lua)
            message = localize('k_upgrade_ex'),     -- this is the message that will be shown under the card when it triggers.
            extra = { focus = self, message = localize('k_upgrade_ex') }, -- another way to show messages, not sure what's the difference.
        }
    end
end

SMODS.Sound {
    key = 'sj_ohnejimboscore',
    path = 'ohnejimboscore.ogg'
}

SMODS.Atlas {
	-- Key for code to find it with
	key = "ohnejimbo",
	-- The name of the file, for the code to pull the atlas from
	path = "ohne.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

SMODS.Atlas({
    key = "roffle",
    path = "looksinside.png",
    loc_txt = {
        name = 'Double Exposure',
        },
    px = 71,
    py = 95,
})

SMODS.Atlas({
    key = "sj_sample_obelisk",
    path = "j_sample_obelisk.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "sj_sample_specifichand",
    path = "j_sample_specifichand.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "sj_sample_money",
    path = "j_sample_money.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "sj_sample_roomba",
    path = "j_sample_roomba.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "sj_sample_drunk_juggler",
    path = "j_sample_drunk_juggler.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "sj_sample_hackerman",
    path = "j_sample_hackerman.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "sj_sample_baroness",
    path = "j_sample_baroness.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "sj_sample_rarebaseballcard",
    path = "j_sample_rarebaseballcard.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "sj_sample_multieffect",
    path = "j_sample_multieffect.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "sample_obelisk",
    config = { extra = { x_mult = 0.1 } },
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'sj_sample_obelisk',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and context.scoring_name then
            local current_hand_times = (G.GAME.hands[context.scoring_name].played or 0) -- how many times has the player played the current type of hand. (pair, two pair. etc..)
            local current_xmult = 1 + (current_hand_times * card.ability.extra.x_mult)
            
            return {
                message = localize{type='variable',key='a_xmult',vars={current_xmult}},
                colour = G.C.RED,
                x_mult = current_xmult
            }

            -- you could also apply it to the joker, to do it like the sample wee, but then you'd have to reset the card and text every time the previewed hand changes.
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult }, key = self.key }
    end
}

SMODS.Joker{
    key = "sample_specifichand",
    config = { extra = { poker_hand = "Five of a Kind", x_mult = 5 } },
    pos={ x = 0, y = 0 },
    rarity = 3,
    cost = 10,
    blueprint_compat=true,
    eternal_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'sj_sample_specifichand',

    calculate = function(self,card,context)
        if context.joker_main and context.cardarea == G.jokers then
            if context.scoring_name == card.ability.extra.poker_hand then
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.x_mult}},
                    colour = G.C.RED,
                    x_mult = card.ability.x_mult
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.poker_hand, card.ability.extra.x_mult }, key = self.key }
    end        
}

SMODS.Joker{
    key = "sample_money",
    config={ },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'sj_sample_money',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.end_of_round and not (context.individual or context.repetition) then --and not (context.individual or context.repetition) => make sure doesn't activate on every card like gold cards.
            ease_dollars(G.GAME.round_resets.blind_ante*2) -- ease_dollars adds or removes provided amount of money. (-5 would remove 5 for example)
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { }
    end
}

SMODS.Joker{
    key = "sample_roomba",
    config={ },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'sj_sample_roomba',
    soul_pos = nil,

        calculate = function(self, card, context)
        if context.end_of_round and not (context.individual or context.repetition) then
            local cleanable_jokers = {}

            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= self then -- if joker is not itself 
                    cleanable_jokers[#cleanable_jokers+1] = G.jokers.cards[i] -- add all other jokers into a array
                end
            end

            local joker_to_clean = #cleanable_jokers > 0 and pseudorandom_element(cleanable_jokers, pseudoseed('clean')) or nil -- pick a random valid joker, or null if no valid jokers

            if joker_to_clean then -- if we have a valid joker we can bump into
                shakecard(joker_to_clean) -- simulate bumping into a card
                if(joker_to_clean.edition) then --if joker has an edition
                    if not joker_to_clean.edition.negative then --if joker is not negative
                        joker_to_clean:set_edition(nil) -- clean the joker from it's edition
                    end
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { }
    end
}

SMODS.Joker{
    key = "sample_drunk_juggler",
    config = { d_size = 1 }, -- d_size  = discard size, h_size = hand size. (HOWEVER, you can't have both on 1 joker!)
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'sj_sample_drunk_juggler',
    soul_pos = nil,

    calculate = function(self, card, context)
        return nil
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.d_size, localize{type = 'name_text', key = 'tag_double', set = 'Tag'} } }
    end
}

SMODS.Joker{
    key = "sample_hackerman",
    config = { repetitions = 1 },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'sj_sample_hackerman',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and (
            context.other_card:get_id() == 6 or 
            context.other_card:get_id() == 7 or 
            context.other_card:get_id() == 8 or 
            context.other_card:get_id() == 9) then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.repetitions,
                card = self
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { }
    end
}

SMODS.Joker{
    key = "sample_baroness",
    config = { extra = { x_mult = 1.5 } },
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'sj_sample_baroness',
    soul_pos = nil,

    calculate = function(self, card, context)
        if not context.end_of_round then
            if context.cardarea == G.hand and context.individual and context.other_card:get_id() == 12 then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = self,
                    }
                else
                    return {
                        x_mult = card.ability.extra.x_mult,
                        card = self
                    }
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end
}

SMODS.Joker{
    key = "sample_rarebaseballcard",
    config = { extra = { x_mult = 2 } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'sj_sample_rarebaseballcard',
    soul_pos = nil,

    calculate = function(self, card, context)
        if not (context.individual or context.repetition) and context.other_joker and context.other_joker.config.center.rarity == 3 and self ~= context.other_joker then
            shakecard(context.other_joker)
            return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
                colour = G.C.RED,
                x_mult = card.ability.extra.x_mult
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult }, key = self.key}
    end
}

SMODS.Joker{
    key = "sample_multieffect",
    config = { extra = { chips = 10, mult = 10, x_mult = 2 } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'sj_sample_multieffect',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 10 then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                x_mult = card.ability.extra.x_mult,
                card = self
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult }, key = self.key }
    end
}

SMODS.Joker {
    key = "ohnejimbo",
    pos = { x = 0, y = 0 },
    rarity = 3,
    blueprint_compat = true,
    cost = 8,
    discovered = true,
    atlas = "ohnejimbo",
    config = { extra = { mult = 385 }, },
    loc_txt = {
        name = "ohnePixel",
        text = {
            "{C:red,s:1.1}+#1#{} Mult",
        },
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
        return {
            mult = card.ability.extra.mult,
            func = function()
    G.E_MANAGER:add_event(Event({
        func = function()
            play_sound('sj_ohnejimboscore')
            return true
        end
    }))
end
        }
        end
    end
}

SMODS.Joker {
    key = "roffle",
    pos = { x = 0, y = 0 },
    rarity = 2,
    blueprint_compat = false,
    cost = 8,
    discovered = true,
    atlas = "roffle",
    loc_txt = {
        name = "Roffle",
        text = {
            "{C:dark_edition}Looks Inside{}",
        }
    },
      calculate = function(self, card, context)
        if context.selling_self then
context.cardarea = G.jokers
	context.elling_card = true
    card = card
            return {
                func = function()
    G.E_MANAGER:add_event(Event({
        func = function()
            local keys = {'j_photograph', 'j_hanging_chad'}
            SMODS.add_card{ key = "j_hanging_chad", edition = { negative = true } }
            SMODS.add_card{ key = "j_photograph", edition = { negative = true } }
            return true 
        end
    }))
end
            }
        end
    end 
}



