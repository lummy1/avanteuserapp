angular.module('jobApp')

.service('Constants', [function(){

	var _API ={
		//baseUrl:"http://127.0.0.1/loyaluserscript/api/",
		baseUrl:"http://www.avantesoft.com/loyaluserscript/api/",
		//baseUrl:"http://www.byteshareinnovations.com/jobsearch/api/",
		userIdToken : "AppToken",
        merchantDbToken : "DbToken",
        serialNoToken : "SerialToken"


	}

	var constants={
		API :_API
	};

	return constants;
	
}])