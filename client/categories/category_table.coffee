Template.category_table.categories = () ->
  Categories.find({user_id: Meteor.userId()})

Template.categories.events =
  "click #new_category": () ->
    Session.set("createCategory",true)