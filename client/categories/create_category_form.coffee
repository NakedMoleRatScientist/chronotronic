Template.create_category_form.events =
  "click #cancel": () ->
    Session.set("createCategory",false)
  "click #submit": () ->
    name = $("#category").val()
    length = Categories.find({name: name}).fetch().length
    if length == 0
      Categories.insert({user_id: Meteor.userId(), name: name})
      Session.set("createCategory",false)