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

    <div class="search">
      <form action="" method="post">
        <p id="title">Search For SPCA Location</p>
        <input class="searchBar" type="search" name="SPCALoc" list="SPCA_Loc" placeholder="Search">
        <datalist id="SPCA_Loc">
          <option value="Antigonish Branch">
          <option value="Cape Breton Branch">
          <option value="Colchester Branch">
          <option value="Hants County Branch">
          <option value="Lunenberg Branch">
        </datalist>
        <input type="submit" name="submitLoc">
      </form>
    </div>
  </center>

  <div class="allAnimals">
    <!-- Create animals that are in that searchBar value -->
    <center><p id="animalsTitle"> Info for animals currently housed in an SPCA location</p></center>

  </div>
  <?php
  $user = 'root';
  $pass = '';

  try{
    $dbh = new PDO("mysql:host=localhost;dbname=animalrescue", $user, $pass);
  } catch (\PDOException $e) {
       throw new \PDOException($e->getMessage(), (int)$e->getCode());
  }

  class animal{
    public $id;
    public $type;
    public $name;
  }

  if(isset($_POST['submitLoc'])){
    $place = $_POST['SPCALoc'];

    // not sure if we need the vet info for this
    $stmt = $dbh->prepare("select distinct animal.id, animal.type, animal.name from animal, animal_location where animal.id = animal_location.animal_id and animal.adoption = 0 and business_name = ?");
    $date = $dbh->prepare("select arrival_date from animal, animal_location where animal.id = animal_location.animal_id and animal.adoption = 0 and business_name = ?");
    $stmt->execute([$place]);
    $date->execute([$place]);

    $result = $stmt->fetchAll(PDO::FETCH_CLASS, "animal");
    $animalAD = $date->fetch();

    while($animalAD as $row){
      echo $row." ";
    }

    $animalID = array_column($result, 'id');
    $animalType = array_column($result, 'type');
    $animalName = array_column($result, 'name');

    for($i = 0; $i < count($animalID); $i++){
      echo "<br>";
      echo "<div class='animal'><center><p id='a_id'> ID: ".$animalID[$i]."</p>";
      echo "<p class='subInfo' id='a_name'> Name: ".$animalName[$i]."</p>";
      echo "<p class='subInfo' id='a_type'> Type: ".$animalType[$i]."</p>";
      echo "<p class='subInfo' id='a_arrive'> Arrival Date: ".$animalAD[$i]."</p></center></div>";
    }
  }
   ?>
</body>
</html>
