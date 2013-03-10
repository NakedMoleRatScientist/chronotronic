Template.mininav.checkActive = (name) ->
  if Session.get("mininav") == name
    return "active"
  ""

Template.mininav.events =
  'click #events': () ->
    console.log("beep")
    Session.set("mininav","stats")