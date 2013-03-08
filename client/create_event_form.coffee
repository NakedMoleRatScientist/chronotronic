Template.create_event_form.date = () ->
  new Date().toISOString().substring(0,10)

Template.create_event_form.events =
  'click #cancel' : () ->
    Session.set("create",false)
  'click #submit' : () ->
    name = $("#name").val()
    date = $("#date").val()
    #multiplying by a number coverts the value of hours, seconds, and minutes from string to integers.
    hours = $("#hours").val() * 3600
    minutes = $("#minutes").val() * 60
    seconds = $("#seconds").val() * 1
    time = hours + minutes + seconds
    Meteor.call("createNewEvent", (err,result) ->
      if err
        console.log(err)
      Session.set("create",false)
    )
