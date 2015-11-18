angular.module('jobApp')

.config(function($stateProvider, $urlRouterProvider) {
	
	$stateProvider
	
	.state('login', {
		url: '/login',
		templateUrl: 'views/auth/login.html',
		controller:'AuthController'
	})
	.state('reg', {
		url: '/reg',
		templateUrl: 'views/auth/register.html',
		controller:"AuthRegController"
	})
	.state('app', {
		url: '/app',
		abstract: true,
		templateUrl: 'views/sidemenu.html',
		controller:"AuthController"
	})
	.state('tab', {
		url: '/tab',
		abstract: true,
		templateUrl: 'views/tab.html'
	})


	.state('app.listing', {
		url: '/listing',
		views: {
			'menuContent': {
				templateUrl:'views/coreviews/joblist.html',
				controller:''
			}
		}
	})

        .state('app.transactions', {
            url: '/transactions',
            views: {
                'menuContent': {
                    templateUrl:'views/coreviews/transactions.html',
                    controller:'TransactionsController'
                }
            }
        })


        .state('app.qr', {
            url: '/qr',
            views: {
                'menuContent': {
                    templateUrl:'views/coreviews/qr.html',
                    controller:'QrController'
                }
            }
        })



	.state('app.jobdetails', {
		url: '/jobdetails',
		views: {
			'menuContent': {
				templateUrl:'views/coreviews/jobdetails.html',
				controller:'JobDetailController'
			}
		}
	})

	.state('app.profile', {
		url: '/profile',
		views: {
			'menuContent': {
				templateUrl: 'views/coreviews/profile.html',
				controller:"ProfileController"
			}
		}
	})
	.state('app.applications', {
		url: '/applications',
		views: {
			'menuContent': {
				templateUrl: 'views/coreviews/applications.html',
				controller:"UserJobsController"
				
			}
		}
	})

	//


	//JobsController
	// .state('publist', {
	// 	url: '/publist',
	// 	templateUrl: 'partials/views/publiclist.html',
	// 	controller: 'JobsController'
	// })

	// .state('app', {
	// 	url: '/app',
	// 	abstract: true,
	// 	templateUrl: 'partials/sidemenu.html'
	// })
	// .state('app.listing', {
	// 	url: '/listing',
	// 	views: {
	// 		'menuContent': {
	// 			templateUrl: 'partials/views/joblist.html',
	// 			controller:'JobsController'
	// 		}
	// 	}
	// })

$urlRouterProvider.otherwise('/login');

})