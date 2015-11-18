angular.module('jobApp', ['ionic','LocalStorageModule','chart.js'])

.run(function($ionicPlatform) {
	$ionicPlatform.ready(function() {
		
		if (window.cordova && window.cordova.plugins && window.cordova.plugins.Keyboard) {
			cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
			cordova.plugins.Keyboard.disableScroll(true);

		}
		if (window.StatusBar) {
			
			StatusBar.styleLightContent();
		}
	});
})



.config(function($ionicConfigProvider) {
	$ionicConfigProvider.tabs.position('bottom');
})



.run(function($state,$rootScope,AuthService){
	$rootScope.$on('$stateChangeStart',function(event,next,nextParams,fromState){
		if(next.name !='login'){
			if(next.name !='reg'){
				if(AuthService.getLoggedInUserToken()==undefined 
					|| AuthService.getLoggedInUserToken()==null){
					event.preventDefault();
				$state.go("login");
			}
		}

	}

})


    })