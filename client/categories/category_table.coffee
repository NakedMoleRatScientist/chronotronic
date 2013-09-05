Template.category_table.categories = () ->
  Categories.find({user_id: Meteor.userId()})

Template.categories.create = () ->
  Session.get("createCategory")

Template.categories.events =
  "click #new_category": () ->
    Session.set("createCategory",true)