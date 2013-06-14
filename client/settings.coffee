
@getUserProfile = () ->
  u = Meteor.user()
  if u.profile.mode == undefined
    Meteor.users.update({_id: u._id }, {$set: {"profile.mode": "Normal", "profile.pomotime": 10, "profile.activitylength": 60}})
  u.profile

Template.settings.mode = () ->
  u = getUserProfile()
  u.mode

Template.settings.pomotime = () ->
  u = getUserProfile()
  u.pomotime       

Template.settings.activitylength = () ->
  u = getUserProfile()
  u.activitylength
      
Template.settings.pomo = () ->
  u = getUserProfile()
  if u.mode == "Pomodoro"
    return true
  false             

Template.settings.events =
  'click #mode' : () ->
    $("#mode").replaceWith("<dd id='modeForm'><select id='modeSelect'><option>Normal</option><option>Pomodoro</option></select><input type='button' value='submit' id='modeSubmit'/></dd>")

  'click #active': () ->
    u = getUserProfile()     
    $("#active").replaceWith("<dd id='activeForm'><input id='activeInput' type='number' value='#{u.activitylength}'><input type='button' value='submit' id='activeSubmit'><input type='button' value='cancel' id='activeCancel'></dd>")

  'click #activeSubmit': () ->
    u = getUserProfile()
    choice = parseInt($("#activeInput").val())
    Meteor.users.update({_id: Meteor.userId()}, {$set: {"profile.activitylength": choice}})
    $("#activeForm").replaceWith("<dd id='active'>#{u.activitylength} minutes</dd>")
     
  'click #modeSubmit' : () ->
    choice = $("#modeSelect").val()
    u = getUserProfile()
    Meteor.users.update({_id: Meteor.userId()}, {$set: {"profile.mode": choice}})
    $("#modeForm").replaceWith("<dd id='mode'>#{u.mode}</dd>")

  'click #pomo' : () ->
    u = getUserProfile()
    $("#pomo").replaceWith("<dd id='pomoForm'><input id='pomoInput' type='number' value='#{u.pomotime}'><input type='button' value='submit' id='pomoSubmit'><input type='button' id='pomoCancel' value='cancel'>/dd>")
  'click #pomoSubmit' : () ->
    choice = parseInt($("#pomoInput").val())
    Meteor.users.update({_id: Meteor.userId()}, {$set: {"profile.pomotime": choice}})
    u = getUserProfile()
    $("#pomoForm").replaceWith("<dd id='mode'>#{u.pomotime} minutes</dd>")       
