<?php
// Connect to your RDS database
$pdo = new PDO('mysql:host=your-rds-endpoint;dbname=your-db-name', 'username', 'password');

// Query for the "X" value
$stmt = $pdo->query('SELECT value FROM your_table');
$x = $stmt->fetchColumn();

// Display the content
echo "<h1>Hello Labcom $x</h1>";
?>
