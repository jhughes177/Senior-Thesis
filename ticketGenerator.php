<?php
function generateTicketCode() { 

    $ticketCharacters = "abcdefghijkmnopqrstuvwxyz0123456789"; 
    srand((double)microtime()*1000000); 
    $i = 0; 
    $pass = '' ; 

    for($i; $i<= 5; $i++) { 
        $num = rand() % 33; 
        $tmp = substr($ticketCharacters, $num, 1); 
        $pass = $pass . $tmp; 
    } 

    return $pass; 

} 

$servername = "localhost";
$username = "jhughes";
$password = "memoirsfromspace";
$dbname = "jhughes";

$ticketNum = generateTicketCode();
echo $ticketNum;

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

$sql = "INSERT INTO TicketSales VALUES ('".$ticketNum."', '50', 'Boston Ferry to Provincetown',false)";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();




?>