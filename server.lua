-- frosty development -- 

local kutuYetki = "BoxAuthority"

function table.random ( theTable )
    return theTable[math.random ( #theTable )]
end

function boxDistribute(thePlayer,cmd)
	for _, oyuncu in ipairs(getElementsByType("player")) do
		if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup(BoxAuthority))then
			setElementData(oyuncu, "box:time", true)
			outputChatBox(">> #ffffffAn official has distributed boxes to everyone, you can open your box with /kutuac.", oyuncu, 0, 255, 0, true)
			outputChatBox(">> #ffffff If you don't approve the box request within 3 minutes, the box will be deleted!", oyuncu, 0, 0, 255, true)
			triggerClientEvent(player, "playKutuSound", player)
			setTimer(function()
				if getElementData(player, "box:time") == true then
					outputChatBox(">> #ffffffThe box has been deleted because you did not approve the box request.", oyuncu, 255, 0, 0, true)
					setElementData(player, "box:time", false)
				end
			end, 180000, 1)
		else
			outputChatBox(">> #ffffffAre you in charge you stupid freak.", thePlayer, 255, 0, 0, true)
		end
	end
end
addCommandHandler("thebox", boxDistribute)

function boxConfirm(thePlayer, cmd)
	if not getElementData(thePlayer, "box:time") == true then
		outputChatBox(">> #ffffff Your box request was not found, wait for the box to be deployed.", thePlayer, 255, 0, 0, true)
	return end
	local money = {5000, 10000, 20000, 50000, 100000, 200000, 500000, 1000000, 2000000}
	local randomMoneyy = table.random(money)
	givePlayerMoney(thePlayer, randomMoneyy)
	setElementData(thePlayer, "box:time", false)
	outputChatBox(">> You approved the #ffffffBox request and it contained "..formatMoney(randomPara).."$ money!", thePlayer, 0, 255, 0, true)
	triggerClientEvent(thePlayer, "stopKutuSound", thePlayer)
end
addCommandHandler("boxopen", boxConfirm)

function formatMoney(amount)
    local left,num,right = string.match(tostring(amount),'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end
