Config = {}

Config.Framework = 'qb' -- 'qb', 'esx', 'custom'

Config.Identifier = 'license'

Config.UpdateInterval = 1000 -- milliseconds (Recommended: 500 and Above)

Config.Sprites = {
    Vehicle = {
        -- [[Please change blip sprites only dont change the names]]
        ['other'] --[[You cant change these]] = 1, -- [[You can change these values]]
        ['bike'] = 559,
        ['boat'] = 427,
        ['heli'] = 43,
        ['automobile'] = 672
    },
    Job = {
        -- [[You can add more jobs and change their blip colours]]
        -- ['JOB_NAME'] = BLIP_COLOUR
        ['police'] = 18,
        ['ambulance'] = 35
    }
}

Config.DutyBlipJobs = {
    ['police'] = true,
    ['ambulance'] = true
}