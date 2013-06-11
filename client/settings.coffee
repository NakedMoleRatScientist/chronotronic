
getUserProfile = () ->
  u = Meteor.user()
  if u.profile.mode == undefined
    Meteor.users.update({_id: u._id }, {$set: {"profile.mode": 0}})
  u.profile

decideMode = (mode) ->
  if mode == 0
    "Normal"
  else if mode == 1
    "Pomodoro"

Template.settings.mode = () ->
  u = getUserProfile()
  decideMode(u.mode)

Template.settings.events =
  'click #mode' : () ->
    id = "#mode"
    u = getUserProfile()
    $(id).replaceWith("<dd id='modeForm'><select id='modeSelect'><option>Normal</option><option>Pomodoro</option></select><input type='button' value='submit' id='modeSubmit'/></dd>")

   'click #modeSubmit' : () ->
     choice = $("#modeSelect").val()