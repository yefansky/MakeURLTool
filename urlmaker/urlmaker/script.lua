require 'md5'
require 'mime'
require "iuplua"

local strMD5EncodingAddition = "kkking" -- 用于MD5校验的附加字符串后缀

local tInput = {
	account = "AAA",
	role = "NAME",
	roleid = "9527",
	gateway="1-1",
	reservation="",	-- 保留字段
	md5="",
}

local colname = {"account", "role", "roleid", "gateway", "reservation"}
local thBox = {}
for _,v in ipairs(colname) do
	table.insert(thBox, iup.vbox{iup.label{title = v}, iup.text{ value = "", size = "100"}})
end

local submit = iup.button{title="submit", size="40X20"}
local answer = iup.text{size="500"}

function submit:action()
	tInput.account 		= thBox[1][2].value
	tInput.role 		= thBox[2][2].value
	tInput.roleid 		= thBox[3][2].value
	tInput.gateway 		= thBox[4][2].value
	tInput.reservation 	= thBox[5][2].value

	tInput.md5 = md5.sumhexa(tInput.account .. strMD5EncodingAddition)
	local strOrg = string.format(
		"%s||%s||%s||%s||%s||%s", 
		tInput.role, tInput.gateway, tInput.account, tInput.roleid, tInput.reservation, tInput.md5
	)
	local strURL = mime.b64(strOrg)
	local strEscapeURL = string.gsub(strURL, "/", "-")	-- 去除转义字符
	strEscapeURL = string.gsub(strEscapeURL, "+", "!")

 	--iup.Message("URL:",strEscapeURL)
 	answer.value = strEscapeURL
end

table.insert(thBox, submit)
local hBox = iup.hbox(thBox)
local vBox = iup.vbox{hBox, answer}

local dlg = iup.dialog{vBox, title="URL Maker", size="600X50"}
dlg:show()
iup.MainLoop()


