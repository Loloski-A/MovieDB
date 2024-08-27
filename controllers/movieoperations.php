<?php
    require_once("../models/movie.php");

    $movie= new movie();

    if(isset($_POST['savemovie'])){
        $movieid=$_POST['movieid'];
        $userid=$_POST['userid'];
        $title=$_POST['title'];
        $releasedate=$_POST['releasedate'];
        $synopsis=$_POST['synopsis'];
        $duration=$_POST['duration'];
        $posterurl=$_POST['posterurl'];
        $trailerurl=$_POST['trailerurl'];
        $response=$movie->savemovie($movieid,$userid,$title,$releasedate,$synopsis
                              ,$duration,$posterurl,$trailerurl);
        echo json_encode($response);
    }

    if(isset($_GET['getmovie'])){
        echo $movie->getmovie();
    }

    if(isset($_GET['getmoviedetails'])){
        $movieid=$_GET['movieid'];
        echo $movie->getmoviedetails($movieid);
    }

    if(isset($_POST['deletemovie'])){
        $movieid=$_POST['movieid'];
        $response=$movie->deletemovie($movieid);
        echo json_encode($response);
    }

?>