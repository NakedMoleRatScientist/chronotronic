Template.bottom_display.display = () ->
  Session.get("mininav")

Template.bottom_display.events =
  'click #stats': () ->
    Session.set("mininav","stats")