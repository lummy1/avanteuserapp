<?php
require 'PasswordHash.php';
require 'Slim/Slim.php';
\Slim\Slim::registerAutoloader();


$app = new \Slim\Slim();
$app->get('/hello', function () {
  echo "Hello, World";
});

if (isset($_SERVER['HTTP_ORIGIN'])) {
  header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
  header('Access-Control-Allow-Credentials: true');
        header('Access-Control-Max-Age: 86400');    // cache for 1 day
      }

    // Access-Control headers are received during OPTIONS requests
      if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {

        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
          header("Access-Control-Allow-Methods: GET, POST, OPTIONS");        

        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
          header("Access-Control-Allow-Headers:        {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

        exit(0);}


//login user

//login user


$app->post('/user/login', function() use($app) {
    $postdata = file_get_contents("php://input");
    $request = json_decode($postdata);
    $response = array();
    $userno = $request->userno;
    $password = $request->password;
    $password=md5($password);

    $sql = "SELECT   sn, email,password,userId FROM config_user WHERE userId=:userno and password=:password";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam(":userno",$userno,PDO::PARAM_STR);
        $stmt->bindParam(":password", $password,PDO::PARAM_STR);
        $stmt->execute();
        $errorInfo = $stmt->errorInfo();
        if(isset($errorInfo[2])){
            $response['error']=true;
            $response['message']=$errorInfo[2];
            echo json_encode($response);
        }
        $resulta = $stmt->fetch();
        $merchantId= $resulta['merchantId'];
        $userId= $resulta['userId'];


        $sql2="SELECT CM.`merchantName` , CM.`merchantDb` , CM.`merchantEmail` , UM.`userId` , UM.`serialNo` , U.`firstName` ,
	                           U.`lastName` ,U.`default` ,U.`email` , U.`status` , U.`dateCreated` , U.`status`
								FROM `config_user_merchant_info` UM, `config_user` U, `config_merchant` CM
								WHERE U.`userId` =:usernos
             AND U.`password`=:password

								LIMIT 1";

//             $sql2="Select * from config_user where userId=:usernos and password=:password";
        try {
            $db2 = getConnection();
            $stmt2 = $db2->prepare($sql2);
            $stmt2->bindParam(":usernos", $userno,PDO::PARAM_STR);
            $stmt2->bindParam(":password", $password,PDO::PARAM_STR);
            //$stmt2->bindParam(":merchantId", $merchantId,PDO::PARAM_STR);

            $stmt2->execute();
            $errorInfos = $stmt2->errorInfo();
            if(isset($errorInfos[2])){
                $response['error']=true;
                $response['message']=$errorInfos[2];
                echo json_encode($response);
            }
            $result = $stmt2->fetch();
            $merchantDB= $result['merchantDb'];

            if($result){


                if ($merchantDB) {
                    $response['error']=false;
                    $response['id'] = $resulta['sn'];
                    $response['email'] = $resulta['email'];
                    $response['merchantDb'] = $result['merchantDb'];
                    $response['serialNo'] = $result['serialNo'];
                } else {
                    $response['error']=true;
                    $response['message']="wrong user id or password";         }

            }else{
                $response['error']=true;
                $response['message']="wrong user id or password";

            }
            echo json_encode($response);

            $db = null;
            $db2 = null;
        } catch(PDOException $e) {
            $response['error']=true;
            $response['message']=$e->getMessage();
            echo json_encode($response);

        }
    } catch(PDOException $e) {
        $response['error']=true;
        $response['message']=$e->getMessage();
        echo json_encode($response);

    }
});
//Register Users

$app->post('/users/register', function() use($app) {
    $postdata = file_get_contents("php://input");
    $request = json_decode($postdata);
    $response = array();

    $firstname= $request->firstname;
    $lastname= $request->lastname;
    $email= $request->email;
    $password= PassHash::hash($request->password);
    $othername= $request->othername;

    if(isEmailExist($email)){
        $response['error']=true;
        $response['message']="This email already exist";
        echo json_encode($response);
        return;
    }

    $sql = "INSERT INTO users(firstname,lastname,email,password_hash,status,othername)
 VALUES (:firstname,:lastname,:email,:password,:status,:othername)";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam(":firstname", $firstname,PDO::PARAM_STR);
        $stmt->bindParam(":lastname", $lastname,PDO::PARAM_STR);
        $stmt->bindParam(":email", $email,PDO::PARAM_STR);
        $stmt->bindParam(":password", $password,PDO::PARAM_STR);
        $stmt->bindValue(":status", 1,PDO::PARAM_INT);
        $stmt->bindParam(":othername", $othername,PDO::PARAM_STR);
        $stmt->execute();
        if($stmt->rowCount()){
            $response['error']=false;
        }else{
            $response['error']=true;
            $response['message']="There was an error contacting the server";
        }
        echo json_encode($response);

    } catch(PDOException $e) {
        $response['error']=true;
        $response['message']=$e->getMessage();
        echo json_encode($response);

    }
});

//get all transaction
$app->get('/transactions/all', function () {
    $sql = "SELECT jp.id,jp.job_title,jp.experience,jp.location,jp.skill_required,
          jp.job_description,DATE_FORMAT(jp.date_posted,'%M %d,  %Y') AS date_posted,
          DATE_FORMAT(jp.expiry_date,'%M %d,  %Y') AS expiry_date,
          sec.name,emp.company_name
          FROM job_postings jp JOIN sectors sec ON sec.id=jp.sector_id
          JOIN employers emp ON emp.id=jp.emp_id
          WHERE jp.status=1";
    try {
        $db = getConnection();
        $stmt = $db->query($sql);
        $jobs = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        echo '{"jobs": ' . json_encode($jobs) . '}';
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
});




//get my transaction
$app->post('/transact/getMyTransaction', function() use($app) {
    $response = array();
    $user = array();
    $postdata = file_get_contents("php://input");
    $request = json_decode($postdata);
    $response = array();

    $dbname= $request->dbname;

    $id= $request->id;
    $serialnum = $request->serialnum;
    //$id = $req->get('id');

//    $sql = "SELECT jp.id,jp.job_title,jp.experience,jp.location,jp.skill_required,
//  jp.job_description,DATE_FORMAT(jp.date_posted,'%M %d,  %Y') AS date_posted,
//  DATE_FORMAT(jp.expiry_date,'%M %d,  %Y') AS expiry_date,
//  sec.name,emp.company_name,app.date_applied
//  FROM job_postings jp JOIN sectors sec ON sec.id=jp.sector_id
//  JOIN employers emp ON emp.id=jp.emp_id JOIN applications app
//  On app.job_posting_id=jp.id WHERE jp.status=1 AND app.user_id=$id";

    $sql = "SELECT `serialNo` , `transAmount` , `comment` , `transDate`
				FROM `transaction`
				WHERE `serialNo`='$serialnum' order by transDate desc limit 100";

    //$sql ="SELECT * FROM applications where user_id=$id";
    try {
        $db = getDynamicConnection($dbname);
        //$stmt = $db->query($sql);
        $stmt = $db->query($sql);
        //$stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_OBJ);
        $db = null;
        echo '{"tra": ' . json_encode($result) . '}';
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }

});


$app->post('/job/apply', function() use($app) {
 $postdata = file_get_contents("php://input");
 $request = json_decode($postdata);
 $response = array();
 $jobId = $request->id;
 $userId = $request->userid;

 if(isUsuerAlreadyForJob($jobId,$userId)){
   $response['error']=true;
   $response['message']="You have already applied for this job";
   echo json_encode($response);
   return;
 }

 $sql = "INSERT INTO applications(job_posting_id,user_id) 
 VALUES (:jid,:userId)";
 try {
  $db = getConnection();
  $stmt = $db->prepare($sql);  
  $stmt->bindParam(":jid", $jobId,PDO::PARAM_INT);
  $stmt->bindParam(":userId", $userId,PDO::PARAM_INT);
  $stmt->execute();
  if($stmt->rowCount()){
    $response['error']=false;
  }else{
    $response['error']=true;
    $response['message']="There was an error contacting the server";
  }
  echo json_encode($response);

} catch(PDOException $e) {
 $response['error']=true;
 $response['message']=$e->getMessage();
 echo json_encode($response);

}
});






$app->post('/user/update', function() use($app) {
 $postdata = file_get_contents("php://input");
 $request = json_decode($postdata);
 $response = array();

 $firstname= $request->firstname;
 $lastname= $request->lastname;
 $othername= $request->othername;
    $userId= $request->UserId;
 $address= $request->address;
 $id=$request->id;

 //$skill = $skill . ',';

 $sql = "UPDATE config_user SET firstName=:firstname,lastName=:lastname,
 userId=:userid,street1=:address WHERE sn=:id";

 try {
  $db = getConnection();
  $stmt = $db->prepare($sql);  
  $stmt->bindValue(":id", $id,PDO::PARAM_INT);
  $stmt->bindParam(":firstname", $firstname,PDO::PARAM_STR);
  $stmt->bindParam(":lastname", $lastname,PDO::PARAM_STR);
  //$stmt->bindParam(":othername", $othername,PDO::PARAM_STR);
  $stmt->bindParam(":userid", $userId,PDO::PARAM_STR);
  $stmt->bindParam(":address", $address,PDO::PARAM_STR);


  $stmt->execute();

  $errorInfo = $stmt->errorInfo();
  if(isset($errorInfo[2])){
   $response['error']=true;
   $response['message']=$errorInfo[2];
   echo json_encode($response);
 }else{
  $response['error']=false;
}

// if($stmt->rowCount()){
//   $response['error']=false;
// }else{
//   $response['error']=true;
//   $response['message']="There was an error contacting the server";
// }
echo json_encode($response);

} catch(PDOException $e) {
 $response['error']=true;
 $response['message']=$e->getMessage();
 echo json_encode($response);

}
});





$app->get('/user/profile', function() use($app) {
  $response = array();
  $user = array();
  $req = $app->request();
  $id = $req->get('id');

  $sql = "SELECT sn,street1, city, state, userId, firstName, lastName, email FROM config_user WHERE sn=$id";

  try {
    $db = getConnection();
    $stmt = $db->query($sql);  
    $stmt->execute();
    $result = $stmt->fetch();
    if($result){
      $user['id']=$result['sn'];
      $user['firstname']=$result['firstName'];
      $user['lastname']=$result['lastName'];
      $user['email']=$result['email'];
      $user['city']=$result['city'];
      $user['state']=$result['state'];
      $user['userId']=$result['userId'];
      $user['street1']=$result['street1'];
      $response['error']=false;
      $response['user'] = $user;

    }else{
      $response['error']=true;
      $response['error']="No profile found";
    }
    $db = null;
    echo json_encode($response);
  } catch(PDOException $e) {
    $response['error']=true;
    $response['error']=getMessage();        
  }

});



function isUsuerAlreadyForJob($id,$userid) {
  $db = getConnection();
  $stmt = $db->prepare("SELECT * from applications WHERE job_posting_id =:jobid AND user_id=:userid");
  $stmt->bindParam(":jobid", $id,PDO::PARAM_INT);
  $stmt->bindParam(":userid", $userid,PDO::PARAM_INT);
  $stmt->execute();
  $result = $stmt->fetch();
  if($result){
    return true;
  }else{
    return false;
  }

}


function isEmailExist($email){
 $db = getConnection();
 $stmt = $db->prepare("SELECT * from users WHERE email =:email");
 $stmt->bindParam(":email", $email,PDO::PARAM_STR);

 $stmt->execute();
 $result = $stmt->fetch();
 if($result){
  return true;
}else{
  return false;
}
}



function getConnection() {
  /* $dbhost="www.byteshareinnovations.com";
  $dbuser="byteshar_new";
  $dbpass="newest\@";
  $dbname="byteshar_jobapp"; */
  $dbhost="localhost";
  $dbuser="root";
  $dbpass="";
  $dbname="avanteso_master";
  $dbh = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass);  
  $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  return $dbh;
}


function getDynamicConnection($dbname) {
    /* $dbhost="www.byteshareinnovations.com";
    $dbuser="byteshar_new";
    $dbpass="newest\@";
    $dbname="byteshar_jobapp"; */
    $dbhost="localhost";
    $dbuser="root";
    $dbpass="";
    //$dbname="jobapp";
    $dbh = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass);
    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    return $dbh;
}

//         function echoRespnse($status_code, $response) {
//             $app = \Slim\Slim::getInstance();
//             $app->status($status_code);
//             $app->contentType('application/json');

//             echo json_encode($response);
//         }
$app->run();

?>