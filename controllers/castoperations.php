<?php
    require_once("../models/cast.php");

    $cast= new cast();

    if(isset($_POST['savecast'])){
        $castid=$_POST['castid'];
        $castname=$_POST['castname'];
        $dob=$_POST['dob'];
        $biography=$_POST['biography'];
        $roleid=$_POST['roleid'];
        $gender=$_POST['gender'];
        $socialmedialinks=$_POST['socialmedialinks'];
        $addedby=$_POST['addedby'];
        $profilemediaurl=$_POST['profilemediaurl'];
        $response=$genre->savegenre($castid,$castname,$dob,$biography,$roleid,$nationality,
                  $gender,$socialmedialinks,$addedby,$profileimageurl);
        echo json_encode($response);
    }

    if(isset($_GET['getcast'])){
        echo $cast->getcast();
    }

    if(isset($_GET['getcastdetails'])){
        $castid=$_GET['castid'];
        echo $cast->getcastdetails($castid);
    }

    if(isset($_POST['deletecast'])){
        $castid=$_POST['castid'];
        $response=$cast->deletecast($castid);
        echo json_encode($response);
    }

?>