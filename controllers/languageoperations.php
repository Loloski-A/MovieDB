<?php
    require_once("../models/language.php");

    $language = new language();

    if(isset($_POST['savelanguage'])){
        $languageid=$_POST['languageid'];
        $languagename=$_POST['languagename'];
        $languagecode=$_POST['languagecode'];
        $addedby=$_POST['addedby'];
        $response=$language->savelanguage($languageid,$languagename,$languagecode,$addedby);
        echo json_encode($response);
    }

    if(isset($_GET['getlanguage'])){
        echo $language->getlanguage();
    }

    if(isset($_GET['getlanguagedetails'])){
        $languageid=$_GET['languageid'];
        echo $language->getlanguagedetails($languageid);
    }

    if(isset($_POST['deletelanguage'])){
        $languageid=$_POST['languageid'];
        $response=$language->deletelanguage($languageid);
        echo json_encode($response);
    }
?>