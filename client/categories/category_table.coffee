Template.category_table.categories = () ->
  Categories.find({user_id: Meteor.userId()})