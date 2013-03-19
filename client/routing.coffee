Meteor.pages({
  '/' : {to: 'index', as: 'index'}
  '/dashboard' : 'dashboard'
  '/admin' : 'admin'
  },
  {
    defaults: { layout: 'layout'}
  })
