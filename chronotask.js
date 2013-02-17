Events = new Meteor.Collection("events");

String.prototype.toTime = function () {
  sec_numb    = parseInt(this);
  var hours   = Math.floor(sec_numb / 3600);
  var minutes = Math.floor((sec_numb - (hours * 3600)) / 60);
  var seconds = sec_numb - (hours * 3600) - (minutes * 60);

  if (hours   < 10) {hours   = "0"+hours;}
  if (minutes < 10) {minutes = "0"+minutes;}
  if (seconds < 10) {seconds = "0"+seconds;}
  var time    = hours+':'+minutes+':'+seconds;
  return time;
}

Session.set("timer", false);
Session.set("eventId", null);


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

  Template.timer.status = function() {
    if (Session.get("timer") == true)
    {
      return "stop";
    }
    else
    {
      return "start";
    }
    
  };

  Template.events.size = function() {
    return Events.find({}).count();    
  }  

  Template.timer.time = function() {
    if (Session.get("eventId") != null)
    {
      e = Events.findOne(Session.get("eventId"));
      return e.seconds.toString().toTime();
    }
    return "00:00:00";

  }
  id = null;
  Template.timer.events({
    'click #start' : function () {
      //Start the timer and add an event
      Session.set("timer", true);
      if (Session.get("eventId") == null)
      {
        event = Events.insert({user_id: Meteor.userId(), seconds: 0);
        Session.set("eventId", event);
        id = Meteor.setInterval(function() {
          Events.update(Session.get("eventId"), {$inc: {seconds: 1}});
        }, 1000);
      }      
    }
    ,'click #stop' : function () {
      Session.set("timer",false);
      Meteor.clearInterval(id);
    }
  });


}

if (Meteor.isServer) {
  Meteor.startup(function () {
  });
}
