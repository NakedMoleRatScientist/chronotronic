
Template.settings.mode = () ->
  u = Meteor.user()
  if u.profile.mode == 0
    "Normal"
  else if u.profile.mode == 1
    "Pomodoro"      
        
        