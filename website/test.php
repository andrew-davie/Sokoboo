


<html> 
 <title>HTML with PHP</title>
 <body>
 <h1>My Example</h1>

<?php phpInfo(); ?> 

<?php
	// Connect to the database server
	mysql_connect("localhost", "web_user", "LetMeIn!") or die(mysql_error());

	// Open to the database
	mysql_select_db("MyDatabase") or die(mysql_error());

	// Select all records from the "Individual" table
	$result = mysql_query("SELECT * FROM Individual")
	or die(mysql_error());

	// Loop thru each record (using the PHP $row variable),
	// then display the first name and last name of each record.
	while($row = mysql_fetch_array($result)){
		echo $row['FirstName']. " - ". $row['LastName'];
	}

	echo <i>php generated this</i>;
?>
 <b>Here is some more HTML</b>
 <?php
 //more PHP code
 ?>
 
 </body>
 </html>