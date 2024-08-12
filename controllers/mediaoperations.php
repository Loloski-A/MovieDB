<?php
    require_once("../models/media.php");

    $media = new media();

    if(isset($_POST['savemedia'])){
        $mediaid=$_POST['mediaid'];
        $mediatype=$_POST['mediatype'];
        $title=$_POST['title'];
        $description=$_POST['description'];
        $filepath=$_POST['filepath'];
        $addedby=$_POST['addedby'];        
        $response=$media->savemedia($mediaid,$mediatype,$title,
               $description,$filepath,$addedby);
        echo json_encode($response);
    }

    if(isset($_GET['getmedia'])){
        echo $media->getmedia();
    }

    if(isset($_GET['getmediadetails'])){
        $mediaid=$_GET['mediaid'];
        echo $media->getmediadetails($mediaid);
    }

    if(isset($_POST['deletemedia'])){
        $mediaid=$_POST['mediaid'];
        $response=$media->deletemedia($mediaid);
        echo json_encode($response);
    }

?>