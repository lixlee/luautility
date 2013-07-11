local unpack = unpack or table.unpack
local base64 = {}

--local base64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

-- 'A'-'Z' 65-90
-- 'a'-'z' 97-122
-- '0'-'9' 48-57
-- '+' 43
-- '/' 47
-- '=' 61

local base64code = {
	[0]  =  65,[1]  =  66,[2]  =  67,[3]  =  68,[4]  =  69,[5]  =  70,[6]  =  71,[7]  =  72,
	[8]  =  73,[9]  =  74,[10] =  75,[11] =  76,[12] =  77,[13] =  78,[14] =  79,[15] =  80,
	[16] =  81,[17] =  82,[18] =  83,[19] =  84,[20] =  85,[21] =  86,[22] =  87,[23] =  88,
	[24] =  89,[25] =  90,[26] =  97,[27] =  98,[28] =  99,[29] = 100,[30] = 101,[31] = 102,
	[32] = 103,[33] = 104,[34] = 105,[35] = 106,[36] = 107,[37] = 108,[38] = 109,[39] = 110,
	[40] = 111,[41] = 112,[42] = 113,[43] = 114,[44] = 115,[45] = 116,[46] = 117,[47] = 118,
	[48] = 119,[49] = 120,[50] = 121,[51] = 122,[52] =  48,[53] =  49,[54] =  50,[55] =  51,
	[56] =  52,[57] =  53,[58] =  54,[59] =  55,[60] =  56,[61] =  57,[62] =  43,[63] =  47
}

local base64code2 = {
	[65]  =   0,[66]  =   1,[67]  =   2,[68]  =   3,[69]  =   4,[70]  =   5,[71]  =   6,[72]  =   7,
	[73]  =   8,[74]  =   9,[75]  =  10,[76]  =  11,[77]  =  12,[78]  =  13,[79]  =  14,[80]  =  15,
	[81]  =  16,[82]  =  17,[83]  =  18,[84]  =  19,[85]  =  20,[86]  =  21,[87]  =  22,[88]  =  23,
	[89]  =  24,[90]  =  25,[97]  =  26,[98]  =  27,[99]  =  28,[100] =  29,[101] =  30,[102] =  31,
	[103] =  32,[104] =  33,[105] =  34,[106] =  35,[107] =  36,[108] =  37,[109] =  38,[110] =  39,
	[111] =  40,[112] =  41,[113] =  42,[114] =  43,[115] =  44,[116] =  45,[117] =  46,[118] =  47,
	[119] =  48,[120] =  49,[121] =  50,[122] =  51,[48]  =  52,[49]  =  53,[50]  =  54,[51]  =  55,
	[52]  =  56,[53]  =  57,[54]  =  58,[55]  =  59,[56]  =  60,[57]  =  61,[43]  =  62,[47]  =  63
}

-- base64.encode(s)
-- Receives a string and returns a Base64-encoded string.
base64.encode = function (s)
	if type(s)~="string" then
		return nil
	end
	local codes = {string.byte(s,1,string.len(s))}
	local t = {}
	local n1,n2,n3,n,a = nil
	for i = 1, #codes , 3 do
		n1,n2,n3 = codes[i],codes[i+1],codes[i+2]
		n = n1*256*256 + (n2 or 0)*256 + (n3 or 0)
		a = n / (4096*64)
		a = a - a%1
		n = n % (4096*64)
		table.insert(t,base64code[a])
		a = n / 4096
		a = a - a%1
		n = n % 4096
		table.insert(t,base64code[a])
		a = n / 64
		a = a - a%1
		n = n % 64
		table.insert(t,base64code[a])
		a = n
		a = a - a%1
		table.insert(t,base64code[a])
		if n3==nil then
			table.insert(t,61)
		end
		if n2==nil then
			table.insert(t,61)
		end
	end
	local rs = string.char(unpack(t))
	return rs
end

-- base64.decode(s)
-- Receives a Base64-encoded string and returns the decoded string.
base64.decode = function (s)
	if type(s)~="string" then
		return nil
	end
	local codes = {string.byte(s,1,string.len(s))}
	local t = {}
	local na,n,a = nil
	for i = 1, #codes , 4 do
		na = {codes[i],codes[i+1],codes[i+2],codes[i+3]}
		if #na==4 then
			for i=1,#na do
				na[i] = base64code2[na[i]] or 0
			end
			n = na[1]*64*64*64 + na[2]*64*64 + na[3]*64 + na[4]
			a = n / (256*256)
			a = a - a%1
			n = n % (256*256)
			table.insert(t,a)
			a = n / 256
			a = a - a%1
			n = n % 256
			table.insert(t,a)
			a = n
			a = a - a%1
			table.insert(t,a)
		else
			for i=1,#na do
				if na[i]==61 then
					table.remove(t)
				end
			end
		end
	end
	local rs = string.char(unpack(t))
	return rs
end

return base64
