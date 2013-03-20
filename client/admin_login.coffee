Template.admin_login.events =
  "click #submit": () ->
    username = $("#username").val()
    password = $("#password").val()
    Meteor.loginWithPassword(username,password (err) ->
      if err
        console.log(err)
      else
        Meteor.go("/admin")
    )
