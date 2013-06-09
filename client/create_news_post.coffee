
Template.create_news_post.events =
  "click .cancel": () ->
    Session.set('createPost', false)

  "click #submit": () ->
    title = $("#title").val()
    description = $("#description").val()
    console.log(title)
    console.log(description)
    
