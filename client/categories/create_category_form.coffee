Template.create_category_form.events =
  "click #cancel": () ->
    Session.set("createCategory",false)
  "click #create": () ->
    name = $("#category").val()
    if Categories.find({name: name}).fetch().length == 0
      Categories.insert({user_id: Meteor.userId(), name: name})
      Session.set("createCategory",false)