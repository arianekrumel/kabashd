

GameState.delete_all
Action.delete_all

##################################
#### LEVEL 1 - Sprained Ankle ####
##################################


	##STATES##

	gs1 = GameState.create(level: "Sprained_Ankle", nameGiven: false)

	gs2 = GameState.create(level: "Sprained_Ankle", examined:false)

	gs3 = GameState.create(level: "Sprained_Ankle", ankleMoved: false)

	gs4 = GameState.create(level: "Sprained_Ankle", diagnosisMade: false)

	gs5 = GameState.create(level: "Sprained_Ankle", diagnosisMade: true, treated: false)

	gsNextLevel =  GameState.create(level: "Lyme_Disease", diagnosed_lyme: false)

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
	Action.create(command: "Finished Treating", response: "It appears that the patient has been properly treated. You may move to the next level", start_state_id: gs5.id, result_state_id: gsNextLevel.id)


##################################
#### LEVEL 2 - Lyme Disease ######
##################################

	##STATES##

	gs1 = gsNextLevel

	gs2 = GameState.create(level: "Lyme_Disease", doxycycline: false)

	gsNextLevel =  GameState.create(level: "Burn", diagnose_burn: false)


	##State 1 Actions

	Action.create(command: "Diagnose Lyme", response: "You have successfully diagnosed Lyme Disease.", start_state_id: gs1.id, result_state_id: gs2.id)

	Action.create(command: "Bad response", response: "That is the wrong diagnosis.", start_state_id: gs1.id, result_state_id: gs1.id)

	##State 2 Actions

	Action.create(command: "Doxycycline", response: "You prescribe the patient Doxycycline. Go to the next level.", start_state_id: gs2.id, result_state_id: gsNextLevel.id)





##################################
#### LEVEL 3 - Burn ##############
##################################

	##STATES##

	gs1 = gsNextLevel

	gs2 = GameState.create(level: "Burn", diagnose_burn: true)


	##State 1 Actions

	Action.create(command: "Diagnose Third Degree Burn", response: "You have successfully diagnosed the burn.", start_state_id: gs1.id, result_state_id: gs2.id)

	Action.create(command: "Bad response", response: "That is a not a good treatment", start_state_id: gs1.id, result_state_id: gs1.id)

	##State 2 Actions





