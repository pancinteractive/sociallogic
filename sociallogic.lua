

local GGTwitter = require( "GGTwitter" )
local facebook = require( "facebook" )

local fontName = "Xolonium"
local timerLevMoveStash = {}
local group = display.newGroup()

	local fvC = 300
	local fS1 = 50
local function cancelAllLevMoveTimers()
    local k, v
    for k,v in pairs(timerLevMoveStash) do
        timer.cancel( v )
        v = nil; k = nil
    end
    timerLevMoveStash = nil
    timerLevMoveStash = {}
end

local function startGame(event)
	if event.phase == "ended" then
		storyboard.gotoScene( "mainlevel", options)
	end
end

local function optScreen(event)
	if event.phase == "ended" then
		storyboard.gotoScene( "mainlevel", options)
	end
end

	
local titleGame = display.newEmbossedText("SAMPLE APP", display.contentWidth/2, display.contentHeight/8, fontName, 54)
titleGame.x = display.contentCenterX*1.65
titleGame:setFillColor(255)
titleGame.alpha = 1
titleGame.anchorX = 1


local color1 = 
{
    highlight = 
    {
        r =0, g = 0, b = 0, a = 255
    },
    shadow =
    {
        r = 0, g = 0, b = 0, a = 255
    }
}
local color2 = 
{
    highlight = 
    {
         r = 255, g = 255, b = 255, a = 255
    },
    shadow =
    {
        r = 255, g = 255, b = 255, a = 255
    }
}
titleGame:setEmbossColor(color1)
	

local titleGame0 = display.newImage("media/images/ui/guisample5aa.png",display.contentCenterX, display.contentHeight/1.18)
titleGame0:setFillColor(255)
titleGame0.alpha = 1


local titleGame1 = display.newEmbossedText("Start ", display.contentWidth/2, titleGame.y+110, fontName, fS1)
titleGame1.x = titleGame.x-fvC
titleGame1:setFillColor(255)
titleGame1.alpha = 1
titleGame1.anchorX = 0
titleGame1.anchorY = 0
titleGame1:addEventListener("touch", startGame)

local titleGame2 = display.newEmbossedText("Options ", display.contentWidth/2, titleGame1.y+130, fontName, fS1)
titleGame2.x = titleGame.x-fvC
titleGame2:setFillColor(255)
titleGame2.alpha = 1
titleGame2.anchorX = 0
titleGame2.anchorY = 0
titleGame2:addEventListener("touch", optScreen)


local twitter
local titleGame3 = display.newImageRect("media/images/ui/twitter1a.png",60,60)
titleGame3.x = display.contentCenterX+30
titleGame3.y = display.contentHeight/1.18

local twitter
local titleGame4 = display.newImageRect("media/images/ui/facebook1a.png",60,60)
titleGame4.x = display.contentCenterX-120
titleGame4.y = display.contentHeight/1.18

local titleGame5 = display.newImageRect("media/images/ui/shareicon1a.png",60,60)
titleGame5.x = display.contentCenterX+180
titleGame5.y = display.contentHeight/1.18


local twitterlistener = function( event )
    if event.phase == "authorised" then
		print("TWITTER ICON WORKING!!")
    end
end

twitter = GGTwitter:new( "xxxxxx", "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx", twitterlistener)

	timer.performWithDelay(500, function()
		
		twitter:authorise()
		print(twitter:isAuthorised())
		--titleGame2.text = twitter:isAuthorised()
		if twitter:isAuthorised() == true then
		end
	end, 1)
	
	local function twitterPostTest(event)
		if event.phase == "began" then
			titleGame3.alpha = .4
		end
		if event.phase == "ended" then
			twitter:post( "Testing out GGTwittter!" )
			print("TWITTER ICON WORKING!!")
			titleGame3.alpha = 1
		end
	end
	
	titleGame3:addEventListener("touch", twitterPostTest)


-- listener for "fbconnect" events
local function listener( event )
    print( "event.name", event.name )  --"fbconnect"
    print( "event.type:", event.type ) --type is either "session", "request", or "dialog"
    print( "isError: " .. tostring( event.isError ) )
    print( "didComplete: " .. tostring( event.didComplete ) )
if event.phase == "ended" then
    --"session" events cover various login/logout events
    --"request" events handle calls to various Graph API calls
    --"dialog" events are standard popup boxes that can be displayed

		if ( "session" == event.type ) then
			--options are: "login", "loginFailed", "loginCancelled", or "logout"
			if ( "login" == event.phase ) then
				print("00000000000 SUCCESFUL LOGIN 0000000000000")
				local access_token = event.token
			end
	
		elseif ( "request" == event.type ) then
			print("facebook request")
			if ( not event.isError ) then
				local response = json.decode( event.response )
				--process response data here
			end
	
		elseif ( "dialog" == event.type ) then
			print( "dialog", event.response )
			--handle dialog results here
		end
    end
end

-- first argument is the app id that you get from Facebook

	if GameSettings.fbLoggedIn == false then
		local fbIDapp = "587756487997994"
		--facebook.login( fbIDapp, listener, { "publish_actions" }  ) 
		facebook.login( fbIDapp, listener, { "publish_actions" }  ) 
		--facebook.request("me/feed", "POST", {message=replaceWildCards(msg_content)})
		GameSettings.fbLoggedIn = true
	end
	local function postToFacebook(event)
		if event.phase == "ended" then	
	--[[
		local options = {
			service = "facebook",
			message = "TEST OF THE BROADCAST METHODS",
			},
]]		
				--facebook.showDialog( "me/feed", "POST", options )
				--facebook.showDialog( "feed", options )
				facebook.request("me/feed", "POST", {message="TESTING FACEBOOK MESSAGE POSTING!"})
				
		end
	end
	
	local function shareToEverywhere(event)
		if event.phase == "ended" then	
		local options = {
			message = "Testing the social plugin from CL!",
			url = "http://coronalabs.com"
		}
		native.showPopup( "social", options )
		end
	end

	titleGame4:addEventListener("touch", postToFacebook)
	titleGame5:addEventListener("touch", shareToEverywhere)

group:insert(titleGame)
group:insert(titleGame0)
group:insert(titleGame1)
group:insert(titleGame2)
group:insert(titleGame3)
group:insert(titleGame4)
group:insert(titleGame5)




