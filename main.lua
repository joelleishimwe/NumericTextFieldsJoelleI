
-- Title: NumericTextFields
-- Name: Joelle Ishimwe
-- Course: ICS2O
-- This program displays...
-----------------------------------------------------------------------------------------------

-- Hide the status bar
display.setStatusBar (display.HiddenStatusBar)

-- change the backround colour
display.setDefault ("background", 124/255, 249/255, 199/255)

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

-----------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------------

local function AskQuestion(  )
	-- generate 2 random numbers between max. and a min. number
	randomNumber1 = math.random (10, 20)
	randomNumber2 = math.random (10, 20)

	correctAnswer = randomNumber1 + randomNumber2

	-- create question in text object
	questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "

end

local function HideCorrect(  )
	correctObject.isVisible = false
	AskQuestion()
end

local function NumericTextFieldListener( event )
	
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
			timer.performWithDelay(2000, HideCorrect)


		end
	end
end

-----------------------------------------------------------------------------------------------
-- OBJECT CREATION
-----------------------------------------------------------------------------------------------

-- dispalys a question and sets the colour
questionObject = display.newText( "", 230, 250, nil, 60 )
questionObject:setTextColor(155/255, 14/255, 198/255)

-- create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
correctObject:setTextColor(5/255, 140/255, 198/255)
correctObject.isVisible = false

-- create the incorrect text object and make it invisible
incorrectObject = display.newText( "Incorrect", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
incorrectObject:setTextColor(255/255, 0/255, 0/255)
incorrectObject.isVisible = false

-- create numeric feild 
numericField = native.newTextField( 475, 250, 200, 100 )
numericField.inputType = "number"

-- add event listener for the numeric field
--numericField:addEventListener( "userInput", NumericFieldListener )

-----------------------------------------------------------------------------------------------
-- FUNCTION CALLS
-----------------------------------------------------------------------------------------------

-- call the function to ask the question
AskQuestion()