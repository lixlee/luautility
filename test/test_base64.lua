print(_VERSION)

package.path = "../lua/?.lua;"..package.path
--print(package.path)

local base64 = require("base64")

function test()
	print(base64.encode("Man"))

	local s = "Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure."
	local s1 = base64.encode(s)
	local s2 = base64.decode(s1)
	print(s1)
	print(s2)
end
test()

function test_base64_time()
	local s = "Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure."
	local s1 = nil
	local s2 = nil
	local t1,t2,dt = nil,nil
	local count = nil

	print("-- base64 encode test")
	count = 10000
	t1 = os.clock()
	for i=1,count do
		s1 = base64.encode(s)
	end
	t2 = os.clock()
	dt = t2-t1
	print(count*string.len(s)/dt)

	t1 = os.clock()
	for i=1,count do
		s1 = base64.encode(s)
	end
	t2 = os.clock()
	dt = t2-t1
	print(count*string.len(s)/dt)

	print("-- base64 decode test")
	count = 10000
	t1 = os.clock()
	for i=1,count do
		s2 = base64.decode(s1)
	end
	t2 = os.clock()
	dt = t2-t1
	print(count*string.len(s)/dt)
end
test_base64_time()


