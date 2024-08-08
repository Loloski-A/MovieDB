<?php
    require_once("../models/genre.php");

    $genre= new genre();

    if(isset($_POST['savegenre'])){
        $genreid=$_POST['genreid'];
        $genrename=$_POST['genrename'];
        $description=$_POST['description'];
        $response=$genre->savegenre($genreid,$genrename,$description);
        echo json_encode($response);
    }

    if(isset($_GET['getgenre'])){
        echo $genre->getgenre();
    }

    if(isset($_GET['getgenredetails'])){
        $genreid=$_GET['genreid'];
        echo $genre->getgenredetails($genreid);
    }

    if(isset($_POST['deletegenre'])){
        $genreid=$_POST['genreid'];
        $response=$genre->deletegenre($genreid);
        echo json_encode($response);
    }

?>