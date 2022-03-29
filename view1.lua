-----------------------------------------------------------------------------------------
--
-- view1.lua
-- 
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImageRect("image/background.png", 1280, 720)
	background.x, background.y = display.contentWidth*0.5, display.contentHeight*0.5
	sceneGroup:insert(background)

	-- 스코어 출력 --
	local score = 0 
	local scoreText = display.newText("점수: ", display.contentWidth*0.13, display.contentHeight*0.2)
	scoreText:setFillColor(0)
	scoreText.size = 40

	local showScore = display.newText(score, display.contentWidth*0.19, display.contentHeight*0.2) 
	showScore:setFillColor(0) 
	showScore.size = 60
	sceneGroup:insert(showScore)

	-- 두더지 배치 --
	local m1 = display.newImageRect("image/mole1.png", 250, 210)
	local m2 = display.newImageRect("image/mole1.png", 250, 210)
	local m3 = display.newImageRect("image/mole1.png", 250, 210)
	local m4 = display.newImageRect("image/mole1.png", 250, 210)
	local m5 = display.newImageRect("image/mole1.png", 250, 210)
	
	sceneGroup:insert(m1)
	sceneGroup:insert(m2)
	sceneGroup:insert(m3)
	sceneGroup:insert(m4)
	sceneGroup:insert(m5)

	m1.alpha = 0
	m2.alpha = 0
	m3.alpha = 0
	m4.alpha = 0
	m5.alpha = 0

	local function m1Setting(event)
		m1.x, m1.y = 400, 300
		m1.alpha = 1

		local function remove1()
			m1.alpha = 0
		end
		timer.performWithDelay(2000, remove1, 1)
	end

	local function m2Setting(event)
		m2.x, m2.y = 270, 550
		m2.alpha = 1

		local function remove2()
			m2.alpha = 0
		end
		timer.performWithDelay(2000, remove2, 1)
	end

	local function m3Setting(event)
		m3.x, m3.y = 900, 300
		m3.alpha = 1

		local function remove3()
			m3.alpha = 0
		end
		timer.performWithDelay(2000, remove3, 1)
	end

	local function m4Setting(event)
		m4.x, m4.y = 1030, 550
		m4.alpha = 1

		local function remove4()
			m4.alpha = 0
		end
		timer.performWithDelay(2000, remove4, 1)
	end

	local function m5Setting(event)
		m5.x, m5.y = 650, 420
		m5.alpha = 1

		local function remove5()
			m5.alpha = 0
		end
		timer.performWithDelay(2000, remove5, 1)
	end

	-- 무작위로 나옴 --
	timer.performWithDelay(math.random(4000, 6000), m1Setting, -1)
	timer.performWithDelay(math.random(2000, 5000), m2Setting, -1)
	timer.performWithDelay(math.random(2000, 5000), m3Setting, -1)
	timer.performWithDelay(math.random(4000, 7000), m4Setting, -1)
	timer.performWithDelay(math.random(2000, 7000), m5Setting, -1)

	-- 탭하면 사라짐 --
	local function catch(event)
		event.target.alpha = 0
		score = score + 10
		showScore.text = score
		if score == 100 then
			composer.setVariable("complete", true)
			composer.gotoScene("view2")
		end
	end	

	m1:addEventListener("tap", catch)
	m2:addEventListener("tap", catch)
	m3:addEventListener("tap", catch)
	m4:addEventListener("tap", catch)
	m5:addEventListener("tap", catch)

	--시간 제한--
	local limit = 20
	local limitText = display.newText("남은 시간: ", display.contentWidth*0.13, display.contentHeight*0.1)
	limitText:setFillColor(0)
	limitText.size = 40
	local showLimit = display.newText(limit, display.contentWidth*0.22, display.contentHeight*0.1)
	showLimit:setFillColor(0) 
	showLimit.size = 60
	sceneGroup:insert(showLimit)

	local function timeAttack( event )
		limit = limit - 1
		showLimit.text = limit

		if(limit == 0) then
			composer.setVariable("complete", false)
			composer.gotoScene("view2")
		end
	end

	timer.performWithDelay( 1000, timeAttack, -1 )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
		composer.removeScene("view1")
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene