Template.mininav.checkActive = (name) ->
  if Session.get("mininav") == name
    return "active"
  ""

Template.mininav.events =
  'click #stats': () ->
    Session.set("mininav","stats")