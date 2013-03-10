Template.bottom_display.display = (name) ->
  Session.get("mininav") == name

Template.bottom_display.events =
  'click #stats': () ->
    Session.set("mininav","stats")