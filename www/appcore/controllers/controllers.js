angular.module('jobApp')

    .controller('AuthController', ['AuthService','$scope','$ionicLoading','$state',
        '$ionicPopup','$timeout',function(AuthService,$scope,$ionicLoading,$state,$ionicPopup,$timeout){

            $scope.login ={};
            var error = function(error){
                $ionicLoading.hide();

                $scope.error = error.data.statusText;

                var errorPopup = $ionicPopup.show({
                    templateUrl: 'views/common/erorr.html',
                    title: 'Error',
                    scope: $scope,
                    buttons: [
                        { text: 'Ok' }
                    ]
                });


                $timeout(function() {
                    errorPopup.close(); //close the popup after 3 seconds for some reason
                }, 4000);
            }


            var success = function(response){

                //console.log($scope.login.userno);
                $ionicLoading.hide();
                //AuthService.removeUserToken();
                if(response.data.error==true){
                    $scope.error = response.data.message;

                    var errorPopup = $ionicPopup.show({
                        templateUrl: 'views/common/erorr.html',
                        title: 'Error',
                        scope: $scope,
                        buttons: [
                            { text: 'Ok' }
                        ]
                    });


                    $timeout(function() {
                        errorPopup.close(); //close the popup after 3 seconds for some reason
                    }, 4000);

                    return;
                }
                //console.log(response.data.merchantDb);
                AuthService.setLoginUserIdToken(response.data.id);
                AuthService.setMerchantDbToken(response.data.merchantDb);
                AuthService.setSerialNoToken(response.data.serialNo);
                //console.log(response.data.serialNo);
                //console.log(AuthService.getSerialNoToken());

                $state.go('app.listing',{},{reload:true});
                //console.log(response);

            }




            $scope.login =function(){

                $ionicLoading.show({
                    templateUrl:"views/common/wait.html"
                });
                AuthService.loginUser({userno:$scope.login.userno,password:$scope.login.password})
                    .then(success,error);
            }

            $scope.logOut=function(){
                AuthService.removeUserToken();
                $state.go('login');
            }

        }])




    .controller('QrController', ['AuthService','$scope',function(AuthService,$scope) {





                //console.log(response.data.serialNo);
                //console.log(AuthService.getSerialNoToken());
                $scope.ser = AuthService.getSerialNoToken()
                console.log($scope.ser);

                //console.log(response);

            }]
            )
                .controller("DoughnutCtrl", function ($scope) {
        $scope.labels = ["Accruals", "Redemption", "Credit Balance"];
        $scope.data = [500, 300, 100];
    })

    .controller("LinegraphCtrl", function($scope) {

        $scope.labels = ["01 Nov", "02 Nov", "03 Nov", "04 Nov", "05 Nov", "06 Nov", "07 Nov","08 Nov", "09 Nov", "10 Nov","11 Nov", "12 Nov", "13 Nov","14 Nov"];
        $scope.series = ['Accruals', 'Redemption'];
        $scope.colours= [{
            fillColor: 'rgba(47, 132, 71, 0.8)',
            strokeColor: 'rgba(47, 132, 71, 0.8)',
            highlightFill: 'rgba(47, 132, 71, 0.8)',
            highlightStroke: 'rgba(47, 132, 71, 0.8)'
        }];
        $scope.data = [
            [65, 0, 80, 81, 56, 55, 40,35,67,78,33,24,12,45],
            [28, 48, 40, 19, 86, 27, 90,55,23,52,78,23,21,65]
        ];

    })

    .controller('AuthRegController', ['AuthService','$scope','$ionicLoading','$state','$ionicPopup','$timeout',
        function(AuthService,$scope,$ionicLoading,$state,$ionicPopup,$timeout){

            $scope.user ={};


            var registerData = {firstname: $scope.user.firstname,othername: $scope.user.othername, lastname: $scope.user.lastname,email: $scope.user.email, password: $scope.user.password};
            var error = function(error){
                console.log(error);
                $ionicLoading.hide();

                $scope.error = error.data.statusText;

                var errorPopup = $ionicPopup.show({
                    templateUrl: 'views/common/erorr.html',
                    title: 'Error',
                    scope: $scope,
                    buttons: [
                        { text: 'Ok' }
                    ]
                });


                $timeout(function() {
                    errorPopup.close(); //close the popup after 3 seconds for some reason
                }, 4000);
            }


            var success = function(response){

                $ionicLoading.hide();
                if(response.data.error==true){
                    $scope.error = response.data.message;

                    var errorPopup = $ionicPopup.show({
                        templateUrl: 'views/common/erorr.html',
                        title: 'Error',
                        scope: $scope,
                        buttons: [
                            { text: 'Ok' }
                        ]
                    });

                    $timeout(function() { errorPopup.close();}, 4000);
                    //return;
                }else{
                    $state.go("login");
                }

            }




            $scope.register =function(){

                $ionicLoading.show({
                    templateUrl:"views/common/wait.html"
                });
                AuthService.registerApplicant({firstname: $scope.user.firstname,othername: $scope.user.othername, lastname: $scope.user.lastname,email: $scope.user.email, password: $scope.user.password})
                    .then(success,error);
            }

        }])



    .controller('TransactionsController', ['TransactionService','AuthService','$scope','$state','$ionicLoading',
        '$timeout','$ionicPopup',
        function(TransactionService,AuthService,$scope,$state,$ionicLoading,$timeout,$ionicPopup){



            $scope.transactions=[];

            $ionicLoading.show({
                templateUrl:"views/common/wait.html"
            });

            var error = function(error){
                $ionicLoading.hide();
                console.log(error.data);
                //$scope.error = error.data.text;

                var errorPopup = $ionicPopup.show({
                    templateUrl: 'views/common/erorr.html',
                    title: 'Error',
                    scope: $scope,
                    buttons: [
                        { text: 'Ok' }
                    ]
                });


                $timeout(function() {
                    errorPopup.close(); //close the popup after 3 seconds for some reason
                }, 4000);
            }


            var success = function(response){

                $ionicLoading.hide();
                $scope.transactions=response.data.tra;
                console.log(response.data.tra);
                //console.log($scope.jobs);

            }


            //TransactionService.getAllTransactions().then(success,error);
            TransactionService.getUserTransaction({id:AuthService.getLoggedInUserToken(),
                dbname:AuthService.getMerchantDbToken(), serialnum:AuthService.getSerialNoToken()})
                .then(success,error);

            //$scope.showJobDetails=function(job){
            //    localStorage.removeItem('jobdetail');
            //    localStorage.setItem('jobdetail',JSON.stringify({job:job}));
            //    $state.go('app.jobdetails');
            //}
        }])



    .controller('JobDetailController', ['JobService','$scope','AuthService','$ionicLoading','$timeout','$ionicPopup',
        function(JobService,$scope,AuthService,$ionicLoading,$timeout,$ionicPopup){

            $scope.singlejob=JSON.parse(localStorage.getItem('jobdetail'));

            var error = function(error){
                $ionicLoading.hide();

                $scope.error = error.data.statusText;

                var errorPopup = $ionicPopup.show({
                    templateUrl: 'views/common/erorr.html',
                    title: 'Error',
                    scope: $scope,
                    buttons: [
                        { text: 'Ok' }
                    ]
                });


                $timeout(function() {
                    errorPopup.close(); //close the popup after 3 seconds for some reason
                }, 4000);
            }


            var success = function(response){

                $ionicLoading.hide();
                if(response.data.error==true){
                    $scope.error = response.data.message;

                    var errorPopup = $ionicPopup.show({
                        templateUrl: 'views/common/erorr.html',
                        title: 'Error',
                        scope: $scope,
                        buttons: [
                            { text: 'Ok' }
                        ]
                    });


                    $timeout(function() {
                        errorPopup.close(); //close the popup after 3 seconds for some reason
                    }, 4000);
                }

                return;
                //console.log(response);
            }

            $scope.apply=function(id){
                $ionicLoading.show({
                    templateUrl:"views/common/wait.html"
                });
                var job = {id:id,userid:AuthService.getLoggedInUserToken()}
                JobService.applyForJob(job).then(success,error);
            }

        }])

    .controller('UserJobsController', ['$state','JobService','$scope','AuthService','$ionicLoading','$timeout','$ionicPopup',
        function($state,JobService,$scope,AuthService,$ionicLoading,$timeout,$ionicPopup){

            $ionicLoading.show({
                templateUrl:"views/common/wait.html"
            });

            var error = function(error){
                $ionicLoading.hide();

                $scope.error = error.data.statusText;

                var errorPopup = $ionicPopup.show({
                    templateUrl: 'views/common/erorr.html',
                    title: 'Error',
                    scope: $scope,
                    buttons: [
                        { text: 'Ok' }
                    ]
                });
                $timeout(function() {errorPopup.close();}, 4000);
            }; //End error Function


            var loadsuccess = function(res){

                $ionicLoading.hide();
                //alert("Hello " + AuthService.getLoggedInUserToken());
                //AuthService.getLoggedInUserToken();
                $scope.jobs = res.data.jobs;
            };//load Success function

            $scope.jobs = [];
            JobService.getUserJobs(AuthService.getLoggedInUserToken()).then(loadsuccess,error);

            $scope.showJobDetails=function(job){
                localStorage.removeItem('jobdetail');
                localStorage.setItem('jobdetail',JSON.stringify({job:job}));
                $state.go('app.jobdetails');
            }

            //getUserJobs
        }])


    .controller('ProfileController', ['AuthService','$scope','$ionicLoading',
        '$timeout','$ionicPopup','$ionicModal','$ionicPlatform',
        function(AuthService,$scope,$ionicLoading,$timeout,$ionicPopup,$ionicModal,$ionicPlatform){

            $ionicLoading.show({
                templateUrl:"views/common/wait.html"
            });

            $scope.user={};
            var error = function(error){
                $ionicLoading.hide();

                $scope.error = error.data.statusText;

                var errorPopup = $ionicPopup.show({
                    templateUrl: 'views/common/erorr.html',
                    title: 'Error',
                    scope: $scope,
                    buttons: [
                        { text: 'Ok' }
                    ]
                });
                $timeout(function() {errorPopup.close();}, 4000);
            }; //End error Function

            var loadsuccess = function(response){

                $ionicLoading.hide();
                if(response.data.error==true){
                    $scope.error = response.data.message;

                    var errorPopup = $ionicPopup.show({
                        templateUrl: 'views/common/erorr.html',
                        title: 'Error',
                        scope: $scope,
                        buttons: [
                            { text: 'Ok' }
                        ]
                    });
                    $timeout(function() {errorPopup.close();}, 4000);
                }else{
                    $scope.user = response.data.user;
                }
            };//load Success function

            var updatesuccess = function(response){
                $ionicLoading.hide();
                if(response.data.error==true){
                    $scope.error = response.data.message;

                    var errorPopup = $ionicPopup.show({
                        templateUrl: 'views/common/erorr.html',
                        title: 'Error',
                        scope: $scope,
                        buttons: [
                            { text: 'Ok' }
                        ]
                    });
                    $timeout(function() {errorPopup.close();}, 4000);

                }

                else{

                    $scope.successmsg = "Your profile has been updated";

                    var successPopup = $ionicPopup.show({
                        templateUrl: 'views/common/success.html',
                        title: 'Information',
                        scope: $scope,
                        buttons: [
                            { text: 'Ok' }
                        ]
                    });
                    $timeout(function() {successPopup.close();}, 4000);
                }

            };//Updatesuccess function

            //Events
            AuthService.getUserProfile(AuthService.getLoggedInUserToken()).then(loadsuccess,error);

            $scope.updateProfile =function(){
                var userPhone;
                var intialPhone = $scope.user.phone;
                if(intialPhone==undefined){
                    userPhone = " ";
                }else{
                    userPhone = intialPhone;
                }

                var sk = $scope.user.skill;
                var skill;

                if(sk==undefined){
                    skill = '';
                }else{
                    skill = sk;
                }
                var address;
                var Initialstreet = $scope.user.street1;
                if(Initialstreet==undefined){
                    address = " ";
                }else{
                    address = Initialstreet;
                }

                var ski = $scope.user.userId;
                var initialUID;

                if(ski==undefined){
                    initialUID = '';
                }else{
                    initialUID = ski;
                }

                AuthService.updateUserProfile({firstname: $scope.user.firstname,
                    othername: $scope.user.othername,
                    lastname: $scope.user.lastname,
                    UserId:initialUID,
                    id: AuthService.getLoggedInUserToken(),
                    address:address}).then(updatesuccess,error);
            } //End updateprofile Function

        }])