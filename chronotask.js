Events = new Meteor.Collection("events");


if (Meteor.isClient) {
  Template.nav.profile = function () {
    user = Meteor.user()
    if (user.name != null)
    {
      return name;
    }
    else
    {
      return "noname";
    }
  };


}

if (Meteor.isServer) {
  Meteor.startup(function () {
  });
}
