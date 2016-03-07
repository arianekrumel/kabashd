module MedicalHelper
  include ApplicationHelper

  # This class is a simple game with two states:
    # State 0: Start
  	# State 1: Emergency Room
  # Each state has specific actions/commands which can be inputted by the user:
    # State 0: Yes, Bad response
    # State 1: Whats happening to the patient, Let me examine, How did this happen, Move ankle joints,
    #You have a sprained ankle, You should rest, Keep your ankle elevated
    #
  #Visit this game at /medical/index
  class Gamestate < GameSkeleton

      #define all possible actions as constants

     Action1 = 'Yes'
     Action2 = 'Bad response'
     Action3 = 'Whats happening to the patient'
     Action4 = 'Let me examine'
     Action5 = 'How did this happen'
     Action6 = 'Move ankle joints'
     Action7 = 'You have a sprained ankle'
     Action8 = 'You should rest'
     Action9 = 'Keep your ankle elevated'
     Action0 = 'Bad Response'    # Two bad responses, one for the initial question and other for duration of game

    def initialize(user_state)
      @user_state = user_state
      @game_output = Array.new
      Gamestate.initilize_actions()
      Gamestate.initialize_states()
      Gamestate.initialize_states_to_actions()
      Gamestate.initialize_actions_to_response()
    end

    def self.initilize_actions()
      # This is a mapping from a user action to an updated state.
      @@actions[Action1] = 'Emergency Room'
      @@actions[Action2] = 'Start'
      @@actions[Action3] = 'Emergency Room'
      @@actions[Action4] = 'Emergency Room'
      @@actions[Action5] = 'Emergency Room'
      @@actions[Action6] = 'Emergency Room'
      @@actions[Action7] = 'Emergency Room'
      @@actions[Action8] = 'Emergency Room'
      @@actions[Action9] = 'Emergency Room'
      @@actions[Action0] = 'Emergency Room'
    end

    def self.initialize_states()
      # This is a mapping from a state to a unique ID.
      @@states['Start'] = 0
      @@states['Emergency Room'] = 1
    end

    def self.initialize_actions_to_response()
        @@actions_to_responses['Initial phrase'] = "Level: Sprained Ankle
        You've heard that a certain high powered businessman is having an extended
        stay at Northwest General.He's the one that's responsible for kicking your dog.
        It's time to give him a piece of your mind. Of course, you're gonna get nowhere
        just going into the hospital and demanding to see him. No, you'll have to be more
        clever than that.You enter the first floor of the hospital. You've picked up
        a white coat from a costume shop, swiped a stethoscope off some resident's desk,
        and are equipped to the brim with the best bandaids $5 at CVS could buy.
        Oh yeah, and WATSON, you have him too.
        You're ready.
        FIRST FLOOR - NORTHWEST HOSPITAL
        Nurse: Hey you! You're new here, but the ER is overflowing, could you take
         a look at this guy? I'm sure it'll only take a few seconds..."

        @@actions_to_responses[Action1] = "Nurse: Awesome, thanks! \n
        WATSON: Wow, you've really gotten yourself in quite the predicament there.
        Well, I'll tell you what, getting revenge on the guy that kicked your dog is a
        pretty admirable goal you got there. I'll make myself available to you. Whenever
        you have a question, just ask me it and I'll try and grab some info for you.
         You'll be able to navigate the hospital by telling me where you want to go,
         but of course some locations aren't gonna be available until you get past
         certain people. Use your wit and my knowledge to get past these obstacles
          and get yourself up to the 5th floor. I've heard that's where he's staying.

          Patient 1: OWWWWWW!

      Nurse: Hey (Name)! Get over here!
       WATSON: Psst, ask her what's wrong"

        @@actions_to_responses[Action2] = "That's not what you should be doing right now...
                                   You'll get caught if you don't act like a real doctor"

        @@actions_to_responses[Action3] = "Patient 1: I don't know... That's why I came here.
                         I think I broke my ankle, it really hurts when I put pressure on it. "

        @@actions_to_responses[Action4] = "Nurse: Ouch, that looks pretty bad.
         WATSON: I'm not too sure that's a broken ankle. Why don't you try asking
         him how he got this injury?"

         @@actions_to_responses[Action5] = "Patient 1: I was playing basketball... I was going
          up for a layup when I got hit and had to land really awkwardly.

          WATSON: Alright, that certainly doesn't sound like a broken ankle. "

          @@actions_to_responses[Action6] = "Patient 1: Ouch!"

          @@actions_to_responses[Action7] = "WATSON: Ok, Now Let's treat it."

          @@actions_to_responses[Action8] = "Patient 1: Alright, anything else?"

          @@actions_to_responses[Action9] = "Patient 1: Ok, thanks
          WATSON: I think you've convinced that nurse, good job.
          Nurse: (Name), there's another patient on the next floor
          that needs to see someone immediately, but all of the other doctors are
          busy, mind if you give me a hand?
           You: Sure, coming right up.

           END LEVEL 1"

          @@actions_to_responses[Action0] =  "That's not what you should be doing right now...
                                     You'll get caught if you don't act like a real doctor"

    end

    def self.initialize_states_to_actions()
     # This is a mapping from a particular state to the valid actions.
     @@states_to_actions['Start'] =  [Action1, Action2]
     @@states_to_actions['Emergency Room'] = [Action3, Action4, Action5, Action6, Action7, Action8, Action9, Action0]
     end


  end
end
