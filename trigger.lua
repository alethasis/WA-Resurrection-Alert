function (allstates, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        -- https://wowpedia.fandom.com/wiki/API_CombatLogGetCurrentEventInfo
        local _, subEvent, _, sourceGUID, sourceName, _, _, destGUID, destName,
              _, _, spellID, spellName, _, auraType = ...

        if (subEvent == "SPELL_CAST_SUCCESS") then
            if (UnitIsUnit(destName, "player")) then
                if (aura_env.RES_IDS[spellID]) then
                    local _, _, icon = GetSpellInfo(spellID)

                    if (not allstates[destName]) then
                        allstates[destName] = {
                            changed = true,
                            show = true,
                            name = WA_ClassColorName(sourceName),
                            icon = icon,
                            spellID = spellID
                        }
                    end

                    return true
                end
            end
        end
    end
end
