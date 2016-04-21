=begin

### GameState Attributes ###

  *REQUIRED*
  level: String

    Holds the name of the current level
    eg. "Lyme Disease"

  *REQUIRED*
  goalActions: String

    Holds a list of all commands that will result in a change of state.
    Must be separated by comma-spaces.

    eg. "Finished Treating, Already Done"

  saveValue: String

    Holds the name of the 'Game' attribute in which to save the user's input.
    This value must also be migrated into the Game model's schema.
	
	Default: nil

    eg. "player_name"


  keys: String

    Holds a set of key commands for each goalAction respectively.
    A key command is a command that must be called before its corresponding goalAction will be called.
    Each set of key commands is a comma-space separated list surrounded by parentheses.
    These sets of key commands must also be separated by comma-spaces.
    The corresponding goalAction will automatically be called when all keys in the set are called.
    Thus we do not need to put these values in the corpus.
    Any goalAction that has keys must have an action for "Already Done"
	
	Default: nil

    eg. "(Rest, Ice Ankle), (Elevate Ankle, Rest)"

### Action Attributes ###

  *REQUIRED*
  command: String

    Holds the name of the command needed to initiate this action in the current state.

    eg. "Ice Ankle"

  *REQUIRED*
  response: String

    Holds the response part of the conversation resulting from this action.
    Will be saved into a Conversation object.

    eg. "You examine the ankle."

  repeatResponse: String

    Holds the response to be delivered in the case that this action is called more than once.
    If set to 'default', it will be equal to response.

	Default: "You can't do that right now."

    eg. "Patient: I can't do it again, it hurts too much!"

  earlyResponse: String

    Holds the response to be delivered in the case that this action is called before the appropriate state.

	Default: "You can't do that right now."

    eg. "WATSON: You haven't even diagnosed him yet!"

  score_reward: int

    Increments game's score by value. Can be negative.

	Default: 0

    eg. 150

  progress_reward: int

    Increments game's progress by given percent. Must be between 0-100.

	Default: 0

    eg. 25

  image: String

    Specifies location of an image file that is added to the conversation.

	Default: nil

    eg. "SwollenAnkle.png"

  *REQUIRED*
  start_state_id: int

    Holds an integer id that references the GameState that this action must be called from.

    eg. gs1.id

  *REQUIRED*
  result_state_id: int

    Holds an integer id that references the GameState that we will enter after the action is called.

    eg. gsNextLevel.id

=end

GameState.delete_all
Action.delete_all

##################################
#### LEVEL 1 - Sprained Ankle ####
##################################

# #STATES##

gs1 = GameState.create(level: 'Sprained_Ankle', goalActions: 'Name', saveValue: 'player_name')

gs2 = GameState.create(level: 'Sprained_Ankle', goalActions: 'Injury Details')

gs3 = GameState.create(level: 'Sprained_Ankle', goalActions: 'Examine')

gs4 = GameState.create(level: 'Sprained_Ankle', goalActions: 'Move Ankle')

gs5 = GameState.create(level: 'Sprained_Ankle', goalActions: 'Diagnose Sprained Ankle')

gs6 = GameState.create(level: 'Sprained_Ankle', goalActions: 'Finished Treating', keys: '(Rest, Ice Ankle, Elevate Ankle)')

gsNextLevel = GameState.create(level: 'Lyme_Disease', goalActions: 'Injury Details')

# #State 1 Actions

Action.create(command: 'Name', response: "Nurse: Hello, %n. Take a look at this patient please, I'm sure it'll only take a few seconds...\nWATSON: Wow, you've really gotten yourself in quite the predicament there %n. Well, I'll tell you what, getting revenge on the guy that kicked your dog is a pretty admirable goal you got there. I'll make myself available to you. Whenever you have a question, just ask me it and I'll try and grab some info for you. You'll be able to navigate the hospital by telling me where you want to go, but of course some locations aren't gonna be available until you get past certain people. Use your wit and my knowledge to get past these obstacles and get yourself up to the 5th floor. I've heard that's where he's staying.\nPatient: OWWWWWW!\nNurse: Hey %n! Get over here!\nWATSON: Psst, ask her what's wrong", start_state_id: gs1.id, result_state_id: gs2.id)

# #State 2 Actions

Action.create(command: 'Injury Details', response: "Patient: I don't know... That's why I came here. I think I broke my ankle, it really hurts when I put pressure on it.", repeatResponse: 'default', score_reward: 500, progress_reward: 20, start_state_id: gs2.id, result_state_id: gs3.id)

Action.create(command: 'Get Situation', response: "Patient: I don't know... That's why I came here. I think I broke my ankle, it really hurts when I put pressure on it.", repeatResponse: 'default', score_reward: 500, progress_reward: 20, start_state_id: gs2.id, result_state_id: gs3.id)

# #State 3 Actions

Action.create(command: 'Examine', response: "Nurse: Ouch, that looks pretty bad.\nWATSON: I'm not too sure that's a broken ankle. Why don't you try asking him to move it", repeatResponse: 'default', earlyResponse: "WATSON: You haven't even asked him what's wrong. Get the details first.", image: 'SwollenAnkle.png', score_reward: 500, progress_reward: 20, start_state_id: gs3.id, result_state_id: gs4.id)

# #State 4 Actions

Action.create(command: 'Move Ankle', response: 'Patient: I can move it, but it hurts really bad!', repeatResponse: "Patient: I can't do it again, it hurts too much!", earlyResponse: "WATSON: You haven't looked at it yet. What if it's broken?", image: 'move_ankle.gif', score_reward: 500, progress_reward: 20, start_state_id: gs4.id, result_state_id: gs5.id)

# #State 5 Actions

Action.create(command: 'Diagnose Sprained Ankle', response: 'WATSON: You are correct! Now we should treat it.', repeatResponse: 'WATSON: You already diagnosed this patient. Perhaps he needs more treatment.', earlyResponse: 'WATSON: I think you should find out more about the injury before jumping to such a conclusion', score_reward: 1000, progress_reward: 20, start_state_id: gs5.id, result_state_id: gs6.id)

Action.create(command: 'Bad response', response: 'WATSON: That is the wrong diagnosis. You need to be more careful!', repeatResponse: 'Another wrong diagnosis? You need to ask more questions.', earlyResponse: 'You need to learn more about the patient before you make a diagnosis.', score_reward: -100, start_state_id: gs5.id, result_state_id: gs5.id)

# #State 6 Actions

Action.create(command: 'Ice Ankle', response: '*The patient begins icing his ankle.*', repeatResponse: "Patient: I'm already icing my ankle!", earlyResponse: "WATSON: You haven't even diagnosed him yet!", score_reward: 200, progress_reward: 7,  start_state_id: gs6.id, result_state_id: gs6.id)

Action.create(command: 'Elevate Ankle', response: '*You elevate the ankle*', repeatResponse: "Patient: It's elevated enough!", earlyResponse: "WATSON: You haven't even diagnosed him yet!", score_reward: 200, progress_reward: 7, start_state_id: gs6.id, result_state_id: gs6.id)

Action.create(command: 'Rest', response: '*You tell the patient to rest his ankle.*', repeatResponse: "Patient: I'm already resting my ankle, What else should I do?", earlyResponse: "WATSON: You haven't even diagnosed him yet!", score_reward: 200, progress_reward: 6,  start_state_id: gs6.id, result_state_id: gs6.id)

Action.create(command: 'Finished Treating', response: "It appears that the patient has been properly treated.\nLevel 2\nYou walk up to the second floor, wondering what new challenge awaits you. As you exit the stairwell, Diana calls out to a tall, middle aged doctor. He marches towards you, looking like he doesn’t suffer fools lightly. You’d best be on your toes.\nNurse Diana: Dr. Johnson! We have a new resident here, and it’s your turn as mentor.\nShe gives him a stern look. \n"Play nice," she admonishes. "\nDr. Johnson: So you're my new resident. You're going to have to impress me before I let you near my interesting patients.\nHe points to a sickly man lying in a bed across the room.\nDr. Johnson: You see that man there? His name is Jack Smirnoff, and I was just getting started talking to him before you interrupted. Why don’t you make yourself useful and handle it? If you can diagnose and treat him correctly, it would go a long way towards getting in my good books. \nYou gather yourself and walk over to the bed. At least you still have Watson in your pocket and Diana by your side to give you a little guidance. Dr. Johnson is scribbling on a notepad across the room, periodically looking up and giving you little glances and glares. You’d better not mess this one up.\nJack: If you’re my new doctor, I really hope you can tell me what’s wrong with me!
", score_reward: 1000, progress_reward: -100, start_state_id: gs6.id, result_state_id: gsNextLevel.id)

##################################
#### LEVEL 2 - Lyme Disease ######
##################################

# #STATES##

gs1 = gsNextLevel

gs2 = GameState.create(level: 'Lyme_Disease', goalActions: 'Examine')

gs3 = GameState.create(level: 'Lyme_Disease', goalActions: 'Diagnose Lyme')

gs4 = GameState.create(level: 'Lyme_Disease', goalActions: 'Doxycycline')

gsNextLevel = GameState.create(level: 'Burn', goalActions: 'Diagnose Third Degree Burn')

# #State 1 Actions

Action.create(command: 'Injury Details', response: "Jack: Well I've been getting these really terrible headaches, and feeling awful feverish. My neck is stiff and my joints are all swollen and painful. And I've got this really weird rash on my shoulder.", repeatResponse: 'default', score_reward: 500, progress_reward: 25, start_state_id: gs1.id, result_state_id: gs2.id)

Action.create(command: 'Get Situation', response: "Jack: Well I've been getting these really terrible headaches, and feeling awful feverish. My neck is stiff and my joints are all swollen and painful. And I've got this really weird rash on my shoulder.", repeatResponse: 'default', score_reward: 500, progress_reward: 25, start_state_id: gs1.id, result_state_id: gs2.id)

# #State 2 Actions

Action.create(command: 'Travelling', response: 'Jack: I went hiking in Yellowstone recently.', repeatResponse: 'default', earlyResponse: "Jack: What does that matter? You haven't even asked me what's wrong.", score_reward: 200, start_state_id: gs2.id, result_state_id: gs2.id)

Action.create(command: 'How Long', response: "Jack: Everything started a few weeks ago but it's been worse recently.", repeatResponse: 'default', earlyResponse: "Jack: Aren't you going to ask what's wrong first?", score_reward: 200, start_state_id: gs2.id, result_state_id: gs2.id)

Action.create(command: 'Blood Test', response: "*In Progress... In Progress... Done!*\nNurse: The Blood test showed an unusually high level of IgG and IgM antibodies.", repeatResponse: "Dr. Johnson: We can't take another blood test, are you crazy?", earlyResponse: "Dr. Johnson: Why do you want to take a blood test? You haven't even asked what the problem is.", score_reward: 200, start_state_id: gs2.id, result_state_id: gs2.id)

Action.create(command: 'Examine', response: 'This rash is bright red and has a distinct bullseye pattern.', image: 'lyme-symptoms.jpg' score_reward: 500, progress_reward: 25, repeatResponse: 'default', start_state_id: gs2.id, result_state_id: gs3.id)

# #State 3 Actions

Action.create(command: 'Diagnose Lyme', response: "Dr. Johnson: You're right! Good job %n. There must be some kind of medication we can prescribe him.", repeatResponse: 'Dr. Johnson: You already diagnosed the patient. We need to focus on treatment, now.', earlyResponse: 'Dr. Johnson: You need to learn more about the patient before you make a diagnosis.', score_reward: 1000, progress_reward: 25, start_state_id: gs3.id, result_state_id: gs4.id)

Action.create(command: 'Bad response', response: 'Dr. Johnson: That is the wrong diagnosis. You need to be more careful!', repeatResponse: 'Dr. Johnson: Another wrong diagnosis? You need to ask more questions.', earlyResponse: 'Dr. Johnson: You need to learn more about the patient before you make a diagnosis.', score_reward: -100, start_state_id: gs3.id, result_state_id: gs3.id)

# #State 4 Actions

Action.create(command: 'Doxycycline', response: 'You prescribe the patient Doxycycline. Go to the next level.', earlyResponse: "WATSON: Are you crazy? You can't just prescribe medication without making a diagnosis!", score_reward: 500, progress_reward: 25, start_state_id: gs4.id, result_state_id: gsNextLevel.id)

##################################
#### LEVEL 3 - Burn ##############
##################################

# #STATES##

gs1 = gsNextLevel

gs2 = GameState.create(level: 'Burn', goalActions: 'Diagnose Third Degree Burn')

# #State 1 Actions

Action.create(command: 'Diagnose Third Degree Burn', response: 'You have successfully diagnosed the burn.', start_state_id: gs1.id, result_state_id: gs2.id)

Action.create(command: 'Bad response', response: 'That is a not a good treatment', start_state_id: gs1.id, result_state_id: gs1.id)

# #State 2 Actions
