<!DOCTYPE html>
<html>
<head>
  <title>Rescue Org</title>
  <link type="text/css" rel="stylesheet" href="styles.css"/>
</head>

<body>
  <center>
	  <div class="topButtons">
		<a id="spca" href="SPCAInfo.php">SPCA INFO</a>
		<a id="adopt" href="adoptions.php">ADOPT</a>
		<a id="donate" href="donations.php">DONATIONS</a>
		<a id="rescuers" href="rescuers.php">RESCUERS</a>
	  </div>

    <div class="search">
		  <form action="" method="post">
			<p id="title">Search For Rescuers</p>
			<input class="searchBar" name = "rescue" type="search" list="SPCA_Loc" placeholder="Search">
			<datalist id="SPCA_Loc">
      <option value="Ruby's Rescue">
      <option value="Lost Paws">
      <option value="No Paws Left Behind">
			</datalist>
      <input type = submit name = "rescueorg">
		  </form>
		</div>

	<div class="container">




  <?php


  $user = 'root';
  $pass = '';



    try {
      $dbh = new PDO("mysql:host=localhost;dbname=animalrescue", $user, $pass);
    } catch (\PDOException $e) {
      throw new \PDOException($e->getMessage(),(int)$e->getCode());
    }

    class driver {
      public $fname;
      public $lname;
      public $org_name;
      public $lplate;
      public $lnumber;
    }

    if (isset($_POST['rescueorg'])) {
      $org = $_POST['rescue'];

      $sql2 = "select count(animal_id) as num_saved from driven d where d.business_name = ? AND extract(year from d.driven_date) = 2018";
      $val = $dbh -> prepare($sql2);
      $val->execute([$org]);
      $result2 = $val->fetchColumn();
      echo "<p id='rescued'>".$org." rescued <strong>".$result2."</strong> animals in 2018!</p>";

      $stmt = $dbh -> prepare("select * from drivers d
      where d.business_name = ?");
      $stmt->execute([$org]);
      $result = $stmt->fetchAll(PDO::FETCH_CLASS, "driver");

      $driverFname = array_column($result,'fname');
      $driverLname = array_column($result,'lname');
      $driverOrg = array_column($result,'business_name');
      $driverLplate = array_column($result,'license_plate');
      $driverLnum = array_column($result,'license_number');


      for($i=0;$i<count($driverLnum);$i++) {
        echo "<center><div class='driver'><p class='driverTitle'>Driver</p>";
      	echo "<p class='name'>Name: ".$driverFname[$i]." ".$driverLname[$i]."</p>";
        echo "<p class='org'> Organization: ".$driverOrg[$i]."</p>";
        echo "<p class='plate'> License Plate: ".$driverLplate[$i]."</p>";
        echo "<p class='license'> License Number: ".$driverLnum[$i]."</p></div></center>";
      }
    }
      ?>
      </div>


</center>


	</body>
</html>
