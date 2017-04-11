var accountController = (function(){
    
    var _getRoute = function(req, res) {
       
        req.logout();
        res.redirect('/');

    };
    
    return {
        getRoute: _getRoute
    }
    
})();

module.exports = accountController;