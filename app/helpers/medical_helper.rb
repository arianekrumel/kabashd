module MedicalHelper
  include ApplicationHelper

  # This class is a game with seven states:
    # State 0: Start
    # State 1: Give_Identity
    # State 2: Ask_Patient
    # State 3: Examine
    # State 4: Move_Ankle
    # STate 5: Get_Details
    # State 6: Diagnosis
    # State 7: Treatment
    # State 8: Done

  # Each state has specific actions/commands which can be inputted by the user:
    # State 0: Yes, Bad response
    # State 1: <any text>
    # State 2: Get Situation, Bad response
    # State 3: Examine, Bad response
    # State 4: Move Ankle, Bad response
    # State 5: Get Details, Bad response
    # State 6: Diagnosis, Bad response
    # State 7: Rest, Ice, Elevate, Bad response

  #Visit this game at /medical/index
  class Gamestate < GameSkeleton

      #define all possible actions as constants
     YES = 'Yes'
     BAD_RESPONSE = 'Bad response'
     NAME = 'User gave name'
     GET_SITUATION = 'Get Situation'
     EXAMINE = 'Examine'
     GET_DETAILS = 'Injury Details'
     MOVE_ANKLE = 'Move Ankle'
     DIAGNOSIS = 'Diagnosis'
     REST = 'Rest'
     ICE = 'Ice'
     ELEVATE = 'Elevate Ankle'
     TREATMENT_DONE = "Treatment done"


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
      @@actions[YES] = 'Give_Identity'
      @@actions[BAD_RESPONSE] = @user_state
      @@actions[NAME] = "Ask_Patient"
      @@actions[GET_SITUATION] = "Examine"
      @@actions[EXAMINE] = 'Get_Details'
      @@actions[GET_DETAILS] = 'Move_Ankle'
      @@actions[MOVE_ANKLE] = 'Diagnosis'
      @@actions[DIAGNOSIS] = 'Treatment'
      @@actions[TREATMENT_DONE] = 'Done'

      # These three actions will keep you in the same state unless they
      # are all completed
      @@actions[REST] = @user_state
      @@actions[ICE] = @user_state
      @@actions[ELEVATE] = @user_state

    end

    def self.initialize_states()
      # This is a mapping from a state to a unique ID.
      @@states['Start'] = 0
      @@states['Give_Identity'] = 1
      @@states['Ask_Patient'] = 2
      @@states['Examine'] = 3
      @@states['Get_Details'] = 4
      @@states['Move_Ankle'] = 5
      @@states['Diagnosis'] = 6
      @@states['Treatment'] = 7
      @@states['Done'] = 8

    end


    def self.initialize_actions_to_response()
        @@actions_to_responses['Initial phrase'] = "<h1>Level: Sprained Ankle</h1>
        <p>You've heard that a certain high powered businessman is having an extended
        stay at Northwest General.</p>

        <p> He's the one that's responsible for kicking your dog.</p>

        <p>It's time to give him a piece of your mind. Of course, you're gonna get nowhere
        just going into the hospital and demanding to see him. No, you'll have to be more
        clever than that.</p>
        <p>You enter the first floor of the hospital. You've picked up
        a white coat from a costume shop, swiped a stethoscope off some resident's desk,
        and are equipped to the brim with the best bandaids $5 at CVS could buy.
        Oh yeah, and WATSON, you have him too.</p>
        <p>You're ready.</p>
        <p>FIRST FLOOR - NORTHWEST HOSPITAL</p>
        <p>Nurse: Hey You! You're new here, but the ER is overflowing, could you take
         a look at this guy? I'm sure it'll only take a few seconds...</p>".html_safe

        @@actions_to_responses[YES] = "Awesome, thanks! What's your name by the way?"
        @@actions_to_responses[NAME] =
        "<p>Nurse: Thanks #{@user_name}!</p>
        <p>WATSON: Wow, you've really gotten yourself in quite the predicament there.
        Well, I'll tell you what, getting revenge on the guy that kicked your dog is a
        pretty admirable goal you got there. I'll make myself available to you. Whenever
        you have a question, just ask me it and I'll try and grab some info for you.
         You'll be able to navigate the hospital by telling me where you want to go,
         but of course some locations aren't gonna be available until you get past
         certain people. Use your wit and my knowledge to get past these obstacles
          and get yourself up to the 5th floor. I've heard that's where he's staying.
           </p>
          <p> Patient 1: OWWWWWW! </p>

        <p> Nurse: Hey #{@user_name}, Get over here</p>
         <p> WATSON: Psst, ask her what's wrong</p>".html_safe

        @@actions_to_responses[BAD_RESPONSE] = "That's not what you should be doing right now...
                                   You'll get caught if you don't act like a real doctor"

        @@actions_to_responses[GET_SITUATION] = "Patient 1: I don't know... That's why I came here.
                         I think I broke my ankle, it really hurts when I put pressure on it. "

        @@actions_to_responses[EXAMINE] = "<p>Nurse: Ouch, that looks pretty bad.</p>
         <p>WATSON: I'm not too sure that's a broken ankle. Why don't you try asking
         him how he got this injury?</p>".html_safe

         @@actions_to_responses[GET_DETAILS] = "<p>Patient 1: I was playing basketball... I was going
          up for a layup when I got hit and had to land really awkwardly.</p>

          <p>WATSON: Alright, that certainly doesn't sound like a broken ankle.</p> ".html_safe

          @@actions_to_responses[MOVE_ANKLE] = "Patient 1: Ouch!"

          @@actions_to_responses[DIAGNOSIS] = "WATSON: Ok, Now Let's treat it."

          @@actions_to_responses[REST] = "Patient 1:  Okay, Sounds Good"

          @@actions_to_responses[ICE] = "Patient 1: Okay, Sounds Good"

          @@actions_to_responses[ELEVATE] = "Patient 1:  Okay, Sounds Good?"

          @@actions_to_responses[TREATMENT_DONE] = "<p>Patient 1: Ok, thanks</p>
          <p>WATSON: I think you've convinced that nurse, good job.</p>
          <p>Nurse: #{@user_name}, there's another patient on the next floor
          that needs to see someone immediately, but all of the other doctors are
          busy, mind if you give me a hand?</p>
           <p>You: Sure, coming right up.</p>

           <h1> END LEVEL 1 </h1>".html_safe


    end

    def self.initialize_states_to_actions()
     # This is a mapping from a particular state to the valid actions.
     @@states_to_actions['Start'] =  [YES, BAD_RESPONSE]
     @@states_to_actions['Give_Identity'] = [NAME]
     @@states_to_actions['Ask_Patient'] = [GET_SITUATION, BAD_RESPONSE]
     @@states_to_actions['Examine'] = [EXAMINE, BAD_RESPONSE]
     @@states_to_actions['Get_Details'] = [GET_DETAILS, BAD_RESPONSE]
     @@states_to_actions['Move_Ankle'] = [MOVE_ANKLE, BAD_RESPONSE]
     @@states_to_actions['Diagnosis'] = [DIAGNOSIS, BAD_RESPONSE]
     @@states_to_actions['Treatment'] = [REST, ICE, ELEVATE, TREATMENT_DONE, BAD_RESPONSE]
     end

    def set_user_name(new_name)
      @user_name = new_name
    end

    def get_user_name()
      return @user_name

    end

    def get_user_state()
      return @user_state
    end

  end
end
