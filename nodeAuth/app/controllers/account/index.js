var accountController = (function(){

    var _getRoute = function(req, res) {
                                       
        res.render("account/index", { user: req.user });        
    
    }; 
    
    
    return {
      
      getRoute: _getRoute
        
    };
    
    
})();

module.exports = accountController;