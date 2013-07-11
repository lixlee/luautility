print(_VERSION)

package.path = "../lua/?.lua;"..package.path
print(package.path)

local base64 = require("base64")

print(base64.encode("Man"))

local s = "Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure."
local s1 = base64.encode(s)
local s2 = base64.decode(s1)
print(s1)
print(s2)


