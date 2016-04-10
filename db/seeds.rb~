

GameState.delete_all
Action.delete_all

##################################
#### LEVEL 1 - Sprained Ankle ####
##################################


	##STATES##

	gs1 = GameState.create(level: "Sprained_Ankle", goalActions: "Name", saveValue: "player_name")

	gs2 = GameState.create(level: "Sprained_Ankle", goalActions: "Examine")

	gs3 = GameState.create(level: "Sprained_Ankle", goalActions: "Move Ankle")

	gs4 = GameState.create(level: "Sprained_Ankle", goalActions: "Diagnose Sprained Ankle")

	gs5 = GameState.create(level: "Sprained_Ankle", goalActions: "Finished Treating, Already Done", keys: "(Rest, Ice Ankle), (Elevate Ankle, Rest)")

	gsNextLevel =  GameState.create(level: "Lyme_Disease", goalActions: "Injury Details")

	##State 1 Actions

	Action.create(command: "Name", response: "Nurse: Hello, %n. Take a look at this patient please, I'm sure it'll only take a few seconds...", start_state_id: gs1.id, result_state_id: gs2.id)

	##State 2 Actions

	Action.create(command: "Examine", response: "You examine the ankle", start_state_id: gs2.id, result_state_id: gs3.id)

	##State 3 Actions

	Action.create(command: "Move Ankle", response: "Patient moves ankle.", start_state_id: gs3.id, result_state_id: gs4.id)

	##State 4 Actions

	Action.create(command: "Ice Ankle", response: "You haven't even diagnosed the patient yet!", start_state_id: gs4.id, result_state_id: gs4.id)

	Action.create(command: "Diagnose Sprained Ankle", response: "Ankle diagnosed", start_state_id: gs4.id, result_state_id: gs5.id)

	##State 5 Actions

	Action.create(command: "Ice Ankle", response: "The patient begins icing the ankle.", start_state_id: gs5.id, result_state_id: gs5.id)

	Action.create(command: "Elevate Ankle", response: "You elevate the ankle", start_state_id: gs5.id, result_state_id: gs5.id)

	Action.create(command: "Rest", response: "You tell the patient to rest his ankle.", start_state_id: gs5.id, result_state_id: gs5.id)

	Action.create(command: "Already Done", response: "You already performed this treatment to the patient. Try another treatment.", start_state_id: gs5.id, result_state_id: gs5.id)
	Action.create(command: "Finished Treating", response: "It appears that the patient has been properly treated. You walk up to the next floor.", start_state_id: gs5.id, result_state_id: gsNextLevel.id)


##################################
#### LEVEL 2 - Lyme Disease ######
##################################

	##STATES##

	gs1 = gsNextLevel

	gs2 = GameState.create(level: "Lyme_Disease", goalActions: "Examine")

	gs3 = GameState.create(level: "Lyme_Disease", goalActions: "Diagnose Lyme")

	gs4 = GameState.create(level: "Lyme_Disease", goalActions: "Doxycycline")

	gsNextLevel =  GameState.create(level: "Burn", goalActions: "Diagnose Third Degree Burn")


	##State 1 Actions

	Action.create(command: "Injury Details", response: "Patient: Well I've been getting these really terrible headaches, and feeling awful feverish. My neck is stiff and my joints are all swollen and painful. And I've got this really weird rash on my shoulder. ", start_state_id: gs1.id, result_state_id: gs2.id)


	##State 2 Actions

	Action.create(command: "Travelling", response: "Patient: I went hiking in Yellowstone recently.", start_state_id: gs2.id, result_state_id: gs2.id)

	Action.create(command: "How Long", response: "Patient: Everything started a few weeks ago but it's been worse recently.", start_state_id: gs2.id, result_state_id: gs2.id)

	Action.create(command: "Blood Test", response: "*In Progress... In Progress... Done!* The Blood test shows an unusually high level of IgG and IgM antibodies.", start_state_id: gs2.id, result_state_id: gs2.id)

	Action.create(command: "Examine", response: "*Picture of a Bullseye Rash* This rash is bright red and has a distinct bullseye pattern.", start_state_id: gs2.id, result_state_id: gs3.id)


	##State 3 Actions

	Action.create(command: "Diagnose Lyme", response: "You have successfully diagnosed Lyme Disease.", start_state_id: gs3.id, result_state_id: gs4.id)

	Action.create(command: "Bad response", response: "That is the wrong diagnosis.", start_state_id: gs3.id, result_state_id: gs3.id)

	##State 4 Actions

	Action.create(command: "Doxycycline", response: "You prescribe the patient Doxycycline. Go to the next level.", start_state_id: gs4.id, result_state_id: gsNextLevel.id)





##################################
#### LEVEL 3 - Burn ##############
##################################

	##STATES##

	gs1 = gsNextLevel

	gs2 = GameState.create(level: "Burn", goalActions: "Diagnose Third Degree Burn")


	##State 1 Actions

	Action.create(command: "Diagnose Third Degree Burn", response: "You have successfully diagnosed the burn.", start_state_id: gs1.id, result_state_id: gs2.id)

	Action.create(command: "Bad response", response: "That is a not a good treatment", start_state_id: gs1.id, result_state_id: gs1.id)

	##State 2 Actions





