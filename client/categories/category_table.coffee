Template.category_table.categories = () ->
  Categories.find({user_id: Meteor.userId()})

Template.category_table.create = () ->
  Session.get("createCategory")

Template.category_table.events =
  "click #new_category": () ->
    Session.set("createCategory",true)