-- frosty development -- 

local kutuYetki = "OzelYetki"

function table.random ( theTable )
    return theTable[math.random ( #theTable )]
end

function kutuDagit(thePlayer,cmd)
	for _, oyuncu in ipairs(getElementsByType("player")) do
		if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup(kutuYetki))then
			setElementData(oyuncu, "kutu:sure", true)
			outputChatBox(">> #ffffffBir yetkili herkese kutu dağıttı, /kutuac ile kutunuzu açabilirsin.", oyuncu, 0, 255, 0, true)
			outputChatBox(">> #ffffff3 dakika içerisinde kutu isteğini onaylamazsan kutu silinecek!", oyuncu, 0, 0, 255, true)
			triggerClientEvent(oyuncu, "playKutuSound", oyuncu)
			setTimer(function()
				if getElementData(oyuncu, "kutu:sure") == true then
					outputChatBox(">> #ffffffKutu isteğini onaylamadığın için kutu silindi.", oyuncu, 255, 0, 0, true)
					setElementData(oyuncu, "kutu:sure", false)
				end
			end, 180000, 1)
		else
			outputChatBox(">> #ffffffSen yetkili misin aptal ucube.", thePlayer, 255, 0, 0, true)
		end
	end
end
addCommandHandler("kutudagit", kutuDagit)

function kutuOnayla(thePlayer, cmd)
	if not getElementData(thePlayer, "kutu:sure") == true then
		outputChatBox(">> #ffffffKutu isteğin bulunamadı, kutu dağıtılmasını bekle.", thePlayer, 255, 0, 0, true)
	return end
	local para = {5000, 10000, 20000, 50000, 100000, 200000, 500000, 1000000, 2000000}
	local randomPara = table.random(para)
	givePlayerMoney(thePlayer, randomPara)
	setElementData(thePlayer, "kutu:sure", false)
	outputChatBox(">> #ffffffKutu isteğini onayladın  ve içerisinden "..formatMoney(randomPara).."$ para çıktı!", thePlayer, 0, 255, 0, true)
	triggerClientEvent(thePlayer, "stopKutuSound", thePlayer)
end
addCommandHandler("kutuac", kutuOnayla)

function formatMoney(amount)
    local left,num,right = string.match(tostring(amount),'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end