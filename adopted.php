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

</center>

</div>

<?php
$user = 'root';
$pass = '';

try{
  $dbh = new PDO("mysql:host=localhost;dbname=animalrescue", $user, $pass);
}  catch (\PDOException $e) {
     throw new \PDOException($e->getMessage(), (int)$e->getCode());
}

class adoptTrans {
    public $fname;
    public $lname;
    public $phone;
    public $addr;
    public $amount;
    public $animalID;
}


if(isset($_POST['UID'])){
  $animalID = intval($_POST['UID']);
  $fname = $_POST['fname'];
  $lname = $_POST['lname'];
  $phone = $_POST['phone'];
  $addr = $_POST['address'];
  $city = $_POST['city'];
  $amount = floatval($_POST['amount']);


  // insert adopter into person
  $personstmt = $dbh->prepare("INSERT INTO `person` (fname,lname,street,city) values (:fname,:lname,:street,:city)");
  $personstmt->execute(['fname'=>$fname,'lname'=>$lname,'street'=>$addr,'city'=>$city]);

  // insert adopter into adopter
  $adopterstmt = $dbh->prepare("INSERT INTO `adopter` values (:fname,:lname)");
  $adopterstmt->execute(['fname'=>$fname,'lname'=>$lname]);

  // insert phone number
  $phonestmt = $dbh->prepare("INSERT INTO `person_phone` (fname,lname,phone_number) values (:fname,:lname,:phone)");
  $phonestmt->execute(['fname'=>$fname,'lname'=>$lname,'phone'=>$phone]);


  // insert into transaction
  $stmt = $dbh->prepare("INSERT INTO `transactions` (fname,lname,amount,trans_date) values (:fname,:lname,:amount,curdate())");
  $stmt->execute(['fname'=>$fname,'lname'=> $lname, 'amount' => $amount]);

  // capture last submitted transaction_id
  $id = intval($dbh->lastInsertId());

  // insert into animal_payment
  $stmt2 = $dbh->prepare("INSERT INTO `animal_payment`(transaction_id,fname,lname,animal_id) values (:trans_id,:fname,:lname,:animal_id)");
  $stmt2->execute(['trans_id'=>$id,'fname'=>$fname,'lname'=> $lname, 'animal_id'=>$animalID]);

  // update adoption id
  $stmt3 = $dbh->prepare("UPDATE `animal` SET adoption = 1 WHERE id = :animal_id");
  $stmt3->execute(['animal_id'=>$animalID]);

  // delete medical records
  $stmt4 = $dbh->prepare("DELETE FROM `vet_visit` WHERE animal_id = :id");
  $stmt4->execute(['id'=>$id]);

  echo "<center><p id='congrats'>Congratulations, adoption successful!</p></center>";

}


?>
