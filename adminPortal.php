<?php

$connection = mysqli_connect("localhost","jhughes","memoirsfromspace","jhughes");

if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL:" . mysqli_connect_error();
}

$sql = "SELECT cruisename ,count(*) as number FROM TicketSales GROUP BY cruisename";

$result = mysqli_query($connection,$sql);
?>
<html>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
.row { padding-top:20px; padding-left:20px; }

</style>
<head>
<div class="row">
    <div class ="col-lg-10">BHC Admin Portal</div>
</div>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
google.charts.load('current', {'packages':['corechart']});

google.charts.setOnLoadCallback(drawChart);

function drawChart() {
  var data = google.visualization.arrayToDataTable([
	['Cruise Name', 'Number'],
	<?php
	 while($row = mysqli_fetch_array($result)){
	 if($row['cruisename'] != ''){
	   	echo "['" .$row['cruisename'] . "'," .$row["number"]."],";
	   	}
	  }
	?>
  ]);
  
// function drawChart() {
// 
// 	var data = google.visualization.arrayToDataTable([
// 	['Cruise Name', 'Number'],
// 	['Boston Ferry to Charlestown', 5],
// 	['Boston Ferry to Provincetown', 6],
// 	['Provincetown Ferry to Boston', 6]
// ]);

  // Optional; add a title and set the width and height of the chart
  var options = {'title':'Cruises Sold', 'width':550, 'height':400, pieHole: 0.4,};
  
  var chart = new google.visualization.PieChart(document.getElementById('chartOfCruises'));
  chart.draw(data, options);
}
</script>
</head>
<body>
<div class="row">
    <div class="col-lg-4">
    <form action="">
    <div class="form-group">
      <label>Scan Code:</label>
      <input type="text" class="form-control" id="codeScan" placeholder="Enter code to scan">
    </div>
    <button type="submit" class="btn btn-default">Submit</button>
  </form>
    </div>
    <div class ="col-lg-10" id="chartOfCruises"></div>
</div>
</body>
</html>