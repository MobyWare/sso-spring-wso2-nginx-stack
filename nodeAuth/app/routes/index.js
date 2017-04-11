var express = require('express');
var passport = require('passport');
var router = express.Router();

// GET /account
router.get('/account', ensureAuthenticated, require('../controllers/account/index').getRoute);

// GET /account/login
router.get('/account/login', require('../controllers/account/login').getRoute);

// GET /account/logout
router.get('/account/logout', require('../controllers/account/logout').getRoute);

// GET /auth/openidconnect
router.get('/auth/oauth2', passport.authenticate('openidconnect'));

// // GET /auth/openidconnect/callback
// router.get('/auth/oauth2/callback', 
//   passport.authenticate('openidconnect', { failureRedirect: '/login' }),
//   function(req, res) {
//     res.redirect('/');
//   });


router.get('/auth/oauth2/callback', function(req, res, next) {
  passport.authenticate('openidconnect', function(err, user, info) {
    if (err) { return next(err); }
    if (!user) { return res.redirect('/login'); }
    req.logIn(user, function(err) {
      if (err) { return next(err); }
      return res.redirect('/account');
    });
  })(req, res, next);
});


// Simple route middleware to ensure user is authenticated.
//   Use this route middleware on any resource that needs to be protected.  If
//   the request is authenticated (typically via a persistent login session),
//   the request will proceed.  Otherwise, the user will be redirected to the
//   login page.
function ensureAuthenticated(req, res, next) {
  if (req.isAuthenticated()) { return next(); }
  res.redirect('/login')
}


module.exports = router;