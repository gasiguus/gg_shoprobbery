Config = {}

Config.NotificationType = 'ox_lib' -- ox_lib / esx

Config.OxProgressTime = 3000 -- Cash register cooldown | 1000 = 1 second
Config.OxProgressTimeSafe = 3000 -- Cash register cooldown | 1000 = 1 second
Config.RobCooldownCH = 60 -- Seconds | Cash Register
Config.RobCooldownSafe = 60 -- Seconds | Safes
Config.LockpickItem = 'lockpick' -- What item you use in lockpick
Config.PoliceCount = 1 -- Police count

-- Rewards
Config.CashRegisterReward = math.random(1000, 2000) -- min, max
Config.SafeReward = math.random(5000, 6000) -- min, max

-- Coords
Config.Safecoords = {
    [1] = vector3(-43.45613, -1748.423, 29.42099),
    [2] = vector3(28.1395, -1339.157, 29.49702),
    [3] = vector3(-3047.781, 585.554, 7.908927),
    [4] = vector3(-3249.988, 1004.37, 12.83072),
    [5] = vector3(1734.912, 6420.816, 35.03722),
    [6] = vector3(1707.865, 4920.4, 42.06363),
    [7] = vector3(1959.3, 3748.987, 32.34373),
    [8] = vector3(546.4423, 2662.851, 42.15649),
    [9] = vector3(2672.792, 3286.709, 55.24113),
    [10] = vector3(2549.234, 384.8363, 108.6229),
    [11] = vector3(378.1743, 333.3306, 103.5664),
    [12] = vector3(-709.7484, -904.2379, 19.21558),
}