var express = require('express'),
    expressLayouts = require("express-ejs-layouts"),
    passport = require('passport'),
    OpenIdConnectStrategy = require('passport-openidconnect').Strategy,
    OAuth2Strategy = require('passport-oauth2').Strategy,
    session = require('express-session'),
    favicon = require('static-favicon'),
    path = require('path'),
    cookieParser = require('cookie-parser'),
    methodOverride = require('method-override'),
    bodyParser = require('body-parser');


// Passport session setup.
//   To support persistent login sessions, Passport needs to be able to
//   serialize users into and deserialize users out of the session.  Typically,
//   this will be as simple as storing the user ID when serializing, and finding
//   the user by ID when deserializing.  However, since this example does not
//   have a database of user records, the complete Facebook profile is serialized
//   and deserialized.
passport.serializeUser(function(user, done) {
    done(null, user);
});

passport.deserializeUser(function(obj, done) {
    done(null, obj);
});




passport.use(new OpenIdConnectStrategy({
        authorizationURL: 'https://localhost:' + process.env.WSO2_IDP_PORT + '/oauth2/authorize',
        tokenURL: 'https://localhost:' + process.env.WSO2_IDP_PORT + '/oauth2/token',
        clientID: process.env.WSO2_CLIENT_ID_FED,
        /*local 5.2.0-alpha: y7rfL6VbNvewO9OuzXW4oxRwGlYa, local 5.1.alpha2: 7yXhtpzobThjV1kd78qqw5UjplYa, local 5.1.alpha2|vpn tenant: ofpMQ5uSG7AkcJeOTtoZH5UytmAa, AWS: MJX_nfCdv6HCfcVfoAwK0qRHMBsa*/
        clientSecret: process.env.WSO2_CLIENT_SECRET_FED,
        /*local5.2.0-alpha:fq6ms9B2XsOlxJTjmyM7u5KSef0a, local 5.1.alpha2: b0Ohy9JIO4B3ni5XWgcjrt0AfKYa, local 5.1.alpha2|vpn tenant:Q1_WgbWwfvEc1Pa77C4XYlJI1Kga, AWS: piQeh2nXiNDfTZGMpIDYyebCNXUa*/
        callbackURL: 'http://localhost:' + process.env.WSO2_NODE_CLIENT_PORT + '/auth/oauth2/callback',
        userInfoURL: 'https://localhost:' + process.env.WSO2_IDP_PORT + '/oauth2/userinfo',
    },
    function(accessToken, refreshToken, profile, done) {
        return done(null, profile);
    }
));





var app = express();



// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');


/*
 Middleware setup
 */

app.use(favicon());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(expressLayouts);
app.use(methodOverride());
app.use(session({ secret: 'keyboard cat' }));
app.use(cookieParser());
app.use(passport.initialize());
app.use(passport.session());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/', require('./routes'));


app.get('/', function(req, res) {
    res.render('index', { user: req.user });
});




/// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
    app.use(function(err, req, res, next) {
        res.status(err.status || 500);
        res.render('error', {
            message: err.message,
            error: err
        });
    });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
        message: err.message,
        error: {}
    });
});

process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

// server
app.listen(process.env.WSO2_NODE_CLIENT_PORT, function() {
    console.log('Example app listening on port ' + process.env.WSO2_NODE_CLIENT_PORT + '!');
});

module.exports = app;