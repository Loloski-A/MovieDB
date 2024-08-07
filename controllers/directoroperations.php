<?php
    require_once("../models/director.php");

    $director= new director();

    if(isset($_POST['savedirector'])){
        $directorid=$_POST['directorid'];
        $directorname=$_POST['directorname'];
        $dob=$_POST['dob'];
        $biography=$_POST['biography'];
        $nationality=$_POST['nationality'];
        $gender=$_POST['gender'];
        $socialmedialinks=$_POST['socialmedialinks'];
        $addedby=$_POST['addedby'];
        $profileimageurl=$_POST['profileimageurl'];
        $response=$director->savedirector($directorid,$directorname,$dob,$biography,$nationality,
                  $gender,$socialmedialinks,$addedby,$profileimageurl);
        echo json_encode($response);
    }

    if(isset($_GET['getdirector'])){
        echo $director->getdirector();
    }

    if(isset($_GET['getdirectordetails'])){
        $directorid=$_GET['directorid'];
        echo $director->getdirectordetails($directorid);
    }

    if(isset($_POST['deletedirector'])){
        $directorid=$_POST['directorid'];
        $response=$director->deletedirector($directorid);
        echo json_encode($response);
    }

?>