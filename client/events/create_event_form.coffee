Template.create_event_form.date = () ->
  formatDate(new Date())

Template.create_event_form.categories = () ->
  names = []
  Categories.find({user_id: Meteor.userId()}).fetch().forEach((c) ->
    names.push(c.name)
  )
  names
  
Template.create_event_form.rendered = () ->
  $("#date").datepicker({dateFormat: "yy-mm-dd"})

Template.create_event_form.events =
  'click .cancel' : () ->
    Session.set("createEvent",false)
  'click #submit' : () ->
    name = $("#name").val()
    date = $("#date").val()
    #multiplying by a number coverts the value of hours, seconds, and minutes from string to integers.
    hours = $("#hours").val() * 3600
    minutes = $("#minutes").val() * 60
    seconds = $("#seconds").val() * 1
    time = hours + minutes + seconds
    Events.insert({user_id: Meteor.userId(), seconds: time, pomo: 0 ,date: moment(date)._d, name: name})
    Session.set("createEvent",false)