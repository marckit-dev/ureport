AccessControl = require('accesscontrol');
ac = new AccessControl();
ac.grant('viewer')
    .readAny('dashboard')
    .readAny('dashboard_template')
    .readAny('build')
    .readAny('setting')
    .readAny('test')
    .readAny('investigate')
    .readAny('relation')
    .readAny('assignment')
    .readAny('dependency')
    .updateOwn('preference')
    .updateOwn('user')
    .updateOwn('userFav')
    .createOwn('userFav')
    .deleteOwn('userFav')
  .grant('operator')
    .extend('viewer')
    .createAny('test')
    .updateAny('test')
    .createAny('assignment')
    .updateAny('assignment') #Tested
    .deleteAny('assignment') #Tested
    .createAny('build') #Tested -- public API for use to push data
    .updateAny('build') #Tested -- delete outage is actually equvilent to update build
    .updateAny('outage') #Tested
    .createOwn('dashboard') #Tested
    .updateOwn('dashboard') #Tested
    .deleteOwn('dashboard') #Tested
    .readAny('user')
    .createAny('comment') #this include comments in build, dashboard, test, assignment
    .createAny('investigate')  #Tested
    .updateAny('investigate')  #Tested
    .deleteOwn('investigate')
    .createAny('dependency')
    .updateAny('dependency')
  .grant('admin')
    .createAny('dashboard_template')
    .updateOwn('dashboard_template')
    .deleteOwn('dashboard_template')
    .extend('operator')
    .deleteAny('build') #Tested
    .deleteAny('dashboard')
    .deleteAny('investigate')  #Tested
    .createAny('setting') #Tested
    .updateAny('setting') #Tested
    .deleteAny('setting') #Tested
    .createAny('user')
    .updateAny('user')
    .deleteAny('user')
    .deleteAny('test')
    .deleteAny('dependency')

ac.canAccessCreateAnyIfOwn = (user, userId, component) ->
  return user._id.toString() == userId.toString() && ac.can(user.role).createOwn(component).granted

ac.canAccessUpdateAnyIfOwn = (user, userId, component) ->
  return user._id.toString() == userId.toString() && ac.can(user.role).updateOwn(component).granted

ac.canAccessDeleteAnyIfOwn = (user, userId, component) ->
  return user._id.toString() == userId.toString() && ac.can(user.role).deleteOwn(component).granted

ac.canAccessUpdateAnyIfOwnByName = (user, username, component) ->
  return user.username.toString() == username.toString() && ac.can(user.role).updateOwn(component).granted

ac.canAccessCreateAny = (role, component) ->
  return ac.can(role).createAny(component).granted

ac.canAccessReadAny = (role, component) ->
  return ac.can(role).readAny(component).granted

ac.canAccessUpdateAny = (role, component) ->
  return ac.can(role).updateAny(component).granted

ac.canAccessDeleteAny = (role, component) ->
  return ac.can(role).deleteAny(component).granted

module.exports = ac
