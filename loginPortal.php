<?php
   
session_start();
#include('cofig.php');
$userName = $_POST['userName'];
$passWord = $_POST['passWord'];
$DB_SERVER = "localhost";
$DB_USERNAME = "jhughes";
$DB_PASSWORD = "memoirsfromspace";
$DB_DATABASE = "jhughes";




	if(isset($userName)&&isset($passWord)){

		
		$db = new mysqli($DB_SERVER,$DB_USERNAME,$DB_PASSWORD,$DB_DATABASE);
		$query = mysqli_query($db,"SELECT * FROM LoginInfo WHERE username = '$userName'");
		#$numrows = mysqli_num_rows($query);
		$numrows = $query->num_rows;
	    #echo "SELECT * FROM LoginInfo WHERE username =" .$userName."";

		#echo $userName, $passWord;
		#print_r($query->fetch_assoc());
		#print_r(mysqli_num_rows($query));

		if($numrows > 0){
		
		while($row = $query->fetch_assoc()){
		
		$dbUserName = $row['username'];
		$dbPassWord = $row['password'];
		
		echo $dbUserName;
		
		}
		
		if($userName==$dbUserName && $passWord==$dbPassWord){
		
	    header("Location: adminPortal.php");
		
		}else{
			echo "incorrect username or password";
		}
		
		
		}	

	}else{
		echo"enter in a username and pass";
	}


?>

<html>
<body>
<form method="post" action=<?php echo $_SERVER['PHP_SELF'];?>>
Username:<br>
<input type="text" name="userName"><br>
Password:<br>
<input type="password" name="passWord"><br>
<button type="submit" value="login">Login</button>
</form>
</body>
</html>