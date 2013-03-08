Template.create_event_form.date = () ->
  new Date().toISOString().substring(0,10)

Template.create_event_form.events =
  'click #cancel' : () ->
    Session.set("create",false)