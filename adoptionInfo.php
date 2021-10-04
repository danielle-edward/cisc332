<!DOCTYPE html>
<html>
<head>
  <title>332 SPCA</title>
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
  </center>

<!-- Input adopter information -->
<div id="info">
  <center>
  <p id="animalsTitle">Input your info</p>
  <?php
  $user = 'root';
  $pass = '';

  try{
    $dbh = new PDO("mysql:host=localhost;dbname=animalrescue", $user, $pass);
  }  catch (\PDOException $e) {
       throw new \PDOException($e->getMessage(), (int)$e->getCode());
  }

  if(isset($_POST['adoptionID'])){
    $inputID = $_POST['UID'];

    $validID = $dbh->prepare("select name from animal where id = ?");
    $validID->execute([$inputID]);
    $exists =  $validID->fetchColumn();
    if(empty($exists)){
      echo "<h2 style='color:red;'>That animal ID doesn't exist, please return and choose a new one</h2>";
      $animalID = " ";
    } else {
      echo "Correct";
      $animalID = $inputID;
    }

  }
  $dbh = null;
  //need to update the DB on submit
  ?>

  <form action="adopted.php" method="post">
    <label for="fname" class="adoptionLabel">First Name:</label>
    <input type="text" name="fname" class="adoptionInput"><br>
    <label for="lname" class="adoptionLabel">Last Name:</label>
    <input type="text" name="lname" class="adoptionInput"><br>
    <label for="phone" class="adoptionLabel">Phone Number:</label>
    <input type="text" name="phone" class="adoptionInput"><br>
    <label for="city" class="adoptionLabel">City:</label>
    <input type="text" name="city" class="adoptionInput"><br>
    <label for="address" class="adoptionLabel">Address:</label>
    <input type="text" name="address" class="adoptionInput"><br>
    <label for="amount" class="adoptionLabel">Amount Paid (By Donation):</label>
    <input type="number" step="0.01" name="amount" class="adoptionInput"><br>
    <!-- value will be a php variable of whatever animal they picked -->
    <label for="UID" class="adoptionLabel">Animal ID:</label>
    <input type="text" name="UID" class="adoptionInput" id="UID" value="1234"><br>
    <input type="submit" value="Adopt Pet" id="submitAdopt">
  </form>
</center>

<script type="text/javascript">
    // this will set the UID in the animal adoption stuff
    var UIDVal = "<?php echo $animalID ?>";
    document.getElementById("UID").value = UIDVal;

</script>

</div>
