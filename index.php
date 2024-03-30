<?php
// Connect to your RDS database
$pdo = new PDO('mysql:host=<RDS_Endpoint>;dbname=mydatabase', 'admin', '123456');

// Query for the "X" value
$stmt = $pdo->query('SELECT value FROM your_table');
$x = $stmt->fetchColumn();

// Display the content
echo "<h1>Hello There $x</h1>";
?>
