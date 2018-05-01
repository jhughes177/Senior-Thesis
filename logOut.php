<?php
session_start();
unset($_SESSION);
session_destroy();
header("Location:loginPortal.php"); //to redirect back to "index.php" after logging out
exit();
?>
