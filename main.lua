
-- Title: NumericTextFields
-- Name: Joelle Ishimwe
-- Course: ICS2O
-- This program displays...
-----------------------------------------------------------------------------------------------

-- Hide the status bar
display.setStatusBar (display.HiddenStatusBar)

-- change the backround colour
display.setDefault ("background", 40/255, 190/255, 199/255)

-----------------------------------------------------------------------------------------------
-- LOCAL IMAGES
-----------------------------------------------------------------------------------------------

-- create your incorrect image
local red = display.newImageRect("Images/RedX.png", 130, 130)
red.x = 750
red.y = 390
red.isVisible = false

-----------------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------------

-- create local variables
local questionObject
local correctObject
local incorrectObject
local numericField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer

local incorrectObject
local pointsObject
local points = 0

-----------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------------

local function AskQuestion(  )
	-- generate 2 random numbers between max. and a min. number
	randomNumber1 = math.random (10, 20)
	randomNumber2 = math.random (10, 20)

	-- generate random number for the operator
	randomOperator = math.random(1, 3)
	if (randomOperator == 1) then

		--calculate the correct answer for addition
		correctAnswer = randomNumber1 + randomNumber2

		-- create question in text object for addition
		questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "

		elseif (randomOperator == 2) then

		--calculate the correct answer for subtraction
		correctAnswer = randomNumber1 - randomNumber2

		-- create question in text object for subtraction
		questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "

		elseif (randomOperator == 3) then

		--calculate the correct answer for multiplication
		correctAnswer = randomNumber1 * randomNumber2

		-- create question in text object for multiplication
		questionObject.text = randomNumber1 .. " x " .. randomNumber2 .. " = "
	end
end


local function HideCorrect(  )
	correctObject.isVisible = false
	AskQuestion()
end

local function HideIncorrect(  )
	incorrectObject.isVisible = false
	AskQuestion()
end


local function NumericFieldListener( event )
	
	-- User begins editing "numericField"
	if ( event.phase == "began" ) then

		-- clear text field
		event.target.text = ""

	elseif event.phase == "submitted" then

		-- when the answer is submitted (enter key is pressed) set user input to user's answer
		userAnswer = tonumber(event.target.text)

		-- if the user answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
			correctObject.isVisible = true

			-- when the user gets it correct add one point to the code and display it in text
			points = points + 1
			pointsObject.text = "Points : " .. points

			-- call the HideCorrect function after 2 seconds
			timer.performWithDelay(2000, HideCorrect)
		 else

			incorrectObject.isVisible = true
			-- call the HideInCorrect function after 1 second
			timer.performWithDelay(2000, HideIncorrect)
		end
	end
end

-----------------------------------------------------------------------------------------------
-- OBJECT CREATION
-----------------------------------------------------------------------------------------------

-- dispalys a question and sets the colour
questionObject = display.newText( "", 230, 250, "Georgia", 60 )
questionObject:setTextColor(155/255, 14/255, 198/255)

-- create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
correctObject:setTextColor(5/255, 140/255, 198/255)
correctObject.isVisible = false

-- create the incorrect text object and make it invisible
incorrectObject = display.newText( "Incorrect", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
incorrectObject:setTextColor(255/255, 0/255, 0/255)
incorrectObject.isVisible = false

-- make the points object
pointsObject = display.newText( "Points : " .. points, display.contentWidth/2, display.contentHeight/2, nil, 60 )

-- change the colour of the "points" object
pointsObject: setTextColor(5/255, 0/255, 255/255)

-- create numeric feild 
numericField = native.newTextField( 475, 250, 200, 100 )
numericField.inputType = "decimal"

-- add event listener for the numeric field
numericField:addEventListener( "userInput", NumericFieldListener )

-----------------------------------------------------------------------------------------------
-- FUNCTION CALLS
-----------------------------------------------------------------------------------------------

-- call the function to ask the question
AskQuestion()