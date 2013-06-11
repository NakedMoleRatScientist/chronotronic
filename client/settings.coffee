
getUserProfile = () ->
  u = Meteor.user()
  if u.profile.mode == undefined
    Meteor.users.update({_id: u._id }, {$set: {"profile.mode": "Normal", "profile.pomotime": 10}})
  u.profile

Template.settings.mode = () ->
  u = getUserProfile()
  u.mode

Template.settings.pomotime = () ->
  u = getUserProfile()
  u.pomotime       

Template.settings.pomo = () ->
  u = getUserProfile()
  if u.mode == "Pomodoro"
    return true
  false             

Template.settings.events =
  'click #mode' : () ->
    $("#mode").replaceWith("<dd id='modeForm'><select id='modeSelect'><option>Normal</option><option>Pomodoro</option></select><input type='button' value='submit' id='modeSubmit'/></dd>")

   'click #modeSubmit' : () ->
     choice = $("#modeSelect").val()
     u = getUserProfile()
     Meteor.users.update({_id: Meteor.userId()}, {$set: {"profile.mode": choice}})
     $("#modeForm").replaceWith("<dd id='mode'>#{u.mode}</dd>")

   'click #pomo' : () ->
     console.log("beep")