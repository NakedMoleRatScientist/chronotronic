
Template.create_news_post.events =
  "click .cancel": () ->
    Session.set('createPost', false)

  "click #submit": () ->

    title = $("#title").val()
    description = $("#description").val()
    unless title == "" || description == ""
      Session.set('createPost',false)
      Posts.insert({user_id: Meteor.userId(), title: title, description: description, publish: moment()._d})  

    
