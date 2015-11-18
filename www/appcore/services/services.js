angular.module('jobApp')
.service('AuthService', ['Constants','$http','localStorageService',
	function(Constants,$http,localStorageService){
		var Loginurl = Constants.API.baseUrl + "user/login",
		loggedInUserId = undefined;
        loggedInMerchantDb = undefined;
        loggedInSerialNo = undefined;
		var Authsrv ={
			loginUser:function(loginParams){
			console.log(loginParams);
                console.log(Loginurl);
			return $http.post(Loginurl,loginParams);
			
		},
		setLoginUserIdToken:function(userId){
			localStorageService.set(Constants.API.userIdToken,userId);
			//localStorage.setItem(Constants.API.userIdToken,userId);
		},

		removeUserToken:function(){
			localStorageService.remove(Constants.API.userIdToken);
			loggedInUserId = undefined;
			//localStorage.removeItem(Constants.API.userIdToken);
		},
		getLoggedInUserToken:function(){
			loggedInUserId= localStorageService.get(Constants.API.userIdToken);
			return loggedInUserId
			//return localStorage.getItem(Constants.API.userIdToken);
		},



//use to set merchantdb local storage

            setMerchantDbToken:function(merchantdb){
                localStorageService.set(Constants.API.merchantDbToken,merchantdb);
                //localStorage.setItem(Constants.API.userIdToken,userId);
            },

            removeMerchantDbToken:function(){
                localStorageService.remove(Constants.API.merchantDbToken);
                loggedInMerchantDb = undefined;
                //localStorage.removeItem(Constants.API.userIdToken);
            },
            getMerchantDbToken:function(){
                loggedInMerchantDb= localStorageService.get(Constants.API.merchantDbToken);
                return loggedInMerchantDb
                //return localStorage.getItem(Constants.API.userIdToken);
            },


            //use to set SerialNo local storage

            setSerialNoToken:function(serialno){
                localStorageService.set(Constants.API.serialNoToken,serialno);
                //localStorage.setItem(Constants.API.userIdToken,userId);
            },

            removeSerialNoToken:function(){
                localStorageService.remove(Constants.API.serialNoToken);
                loggedInSerialNo = undefined;
                //localStorage.removeItem(Constants.API.userIdToken);
            },
            getSerialNoToken:function(){
                loggedInSerialNo= localStorageService.get(Constants.API.serialNoToken);
                return loggedInSerialNo
                //return localStorage.getItem(Constants.API.userIdToken);
            },





		registerApplicant:function(applicant){
			//console.log(applicant);
			return $http.post(Constants.API.baseUrl + "users/register" ,applicant);
		},
		getUserProfile:function(id){
			return $http.get(Constants.API.baseUrl + "user/profile?id="+id);
		},

		updateUserProfile:function(applicant){
			return $http.post(Constants.API.baseUrl + "user/update",applicant);
		}
	}

	return Authsrv;
	
}])

.service('TransactionService', ['Constants','$http', function(Constants,$http){
	var transactionsurl = Constants.API.baseUrl + "transactions/all";
	var Transactionsrv ={
		//getAllTransactions:function(){
		//	return $http.get(transactionsurl);
		//},
		//applyForJob:function(job){
		//	return $http.post(Constants.API.baseUrl + "job/apply",job);
		//},
		getUserTransaction:function(transact){
			return $http.post(Constants.API.baseUrl + "transact/getMyTransaction",transact);
		}
	}

	return Transactionsrv;
	
}])

.factory('$fileFactory', ['$q', function($q){
	var File = function() { };

	File.prototype = {

		getParentDirectory: function(path) {
			var deferred = $q.defer();
			window.resolveLocalFileSystemURI(path, function(fileSystem) {
				fileSystem.getParent(function(result) {
					deferred.resolve(result);
				}, function(error) {
					deferred.reject(error);
				});
			}, function(error) {
				deferred.reject(error);
			});
			return deferred.promise;
		},

		getEntriesAtRoot: function() {
			var deferred = $q.defer();
			window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, function(fileSystem) {
				var directoryReader = fileSystem.root.createReader();
				directoryReader.readEntries(function(entries) {
					deferred.resolve(entries);
				}, function(error) {
					deferred.reject(error);
				});
			}, function(error) {
				deferred.reject(error);
			});
			return deferred.promise;
		},

		getEntries: function(path) {
			var deferred = $q.defer();
			window.resolveLocalFileSystemURI(path, function(fileSystem) {
				var directoryReader = fileSystem.createReader();
				directoryReader.readEntries(function(entries) {
					deferred.resolve(entries);
				}, function(error) {
					deferred.reject(error);
				});
			}, function(error) {
				deferred.reject(error);
			});
			return deferred.promise;
		}

	};

	return File;
}])

