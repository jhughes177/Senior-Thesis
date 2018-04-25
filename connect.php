<?php
 
$connection=mysqli_connect("localhost","jhughes","memoirsfromspace","jhughes");
 

if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
 

$sql = "SELECT * FROM Cruises";
 

if ($result = mysqli_query($connection, $sql))
{
	
	$resultArray = array();
	$tempArray = array();
 
	
	while($row = $result->fetch_object())
	{
		
		$tempArray = $row;
	    array_push($resultArray, $tempArray);
	}
 
	
	echo json_encode($resultArray);
}
 

mysqli_close($connection);
?>