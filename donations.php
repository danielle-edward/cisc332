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
				<p id="title">Search Donations By Organization name or Donor Name</p>
				<input class="searchBar" type="search" name="search_don" placeholder="Search">
        <input type="submit" name="orgOrDon">
			  </form>
			</div>

			<div id="organization_display">
				<div id="shown_elements">
				</div>
			</div>
		</center>


    <?php
    $user = 'root';
    $pass = '';

    try{
      $dbh = new PDO("mysql:host=localhost;dbname=animalrescue", $user, $pass);
    } catch (\PDOException $e) {
         throw new \PDOException($e->getMessage(), (int)$e->getCode());
    }

    if(isset($_POST['orgOrDon'])){
      $by = $_POST['search_don'];

      $donorTotal = $dbh->prepare("select sum(amount) as total from transactions, donation where transactions.transaction_id = donation.transaction_id and fname=? and lname=?");
      $donorMadeTo = $dbh->prepare("select distinct made_to as total from transactions, donation where transactions.transaction_id = donation.transaction_id and fname=? and lname=?");
      $org = $dbh->prepare("select sum(amount), made_to from transactions, donation where transactions.transaction_id = donation.transaction_id and extract(year from trans_date) = 2018 and made_to = ?");
      $orgCheck = $dbh->prepare("select business_name from location where business_name = ?");

      $org->execute([$by]);
      $test = $org->fetchColumn();
      $orgCheck->execute([$by]);
      $orgExists = $orgCheck->fetchColumn();

      if(is_null($test)){
        if(empty($orgExists)){
          $strIn = strval($by);
          $FLname = explode(" ", $strIn);
          if(isset($FLname[1])){
            $donorTotal->execute([$FLname[0], $FLname[1]]);
            $donorMadeTo->execute([$FLname[0], $FLname[1]]);
            $total = $donorTotal->fetchColumn();
            if(empty($total)){
              echo "<center><div class='donorInfo'><p id='donorName'>".$FLname[0]." ".$FLname[1]."</p>";
              echo "<p id='totalAmount'> Has not donated any money, but there's always time!</p>";
            } else {
              echo "<center><div class='donorInfo'><p id='donorName'>".$FLname[0]." ".$FLname[1]."</p>";
              echo "<p id='totalAmount'> Has donated a total of <strong>".$total."</strong> to:</p>";
              while($madeTo = $donorMadeTo->fetchColumn()){
                echo "<p class='donorOrg'>".$madeTo."</p>";
              }
            }
            echo "</div></center>";

          } else {
            echo "<center>Sorry, that person or organization doesn't exist</center>";
          }
        } else {
          echo "<center><div class='orgInfo'><p id='noDonation'> The organization ".$by." has not recieved any donations in 2018</p></div></center>";
        }
      } else {
        echo "<center><div class='orgInfo'><p id='money'> The orgranization ".$by." recieved a total of <strong>".$test."</strong> in donations in 2018</p></div></center>";
      }
    }

     ?>

	</body>

</html>
