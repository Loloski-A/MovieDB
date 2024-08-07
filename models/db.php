<?php
    // create a class that connects to my data base and executes sql statements
    $sql="";

    class db {
        // properties
        private $servername;
        private $username;
        private $password;
        private $dbname;
        private $charset;
        public $userid;

        function __construct(){
            $this->userid=1;
        }

        // methods
        function connect(){
           $this->servername="localhost";
           $this->charset="utf8mb4";
           $this->username="root";
           $this->password="";
           $this->dbname="moviedb";
          
           
           try{
                //    connection string "driver:host;servername;databasename"
                $dsn="mysql:host=".$this->servername.";dbname=".$this->dbname.";charset=".$this->charset;
                  // PDO - PHP database Object
                $pdo=new PDO($dsn,$this->username,$this->password);
                $pdo->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
                return $pdo;
           }catch(PDOException $e){
                echo "Connection failed ".$e->getMessage();
           }
        }

        function getData($sql){
            return $this->connect()->query($sql);
        }

        function getJSON($sql){
            $rst=$this->getData($sql);
            return json_encode($rst->fetchAll(PDO::FETCH_ASSOC));
        }

        function mySQLDate($date){
            $date=DateTime::createFromFormat('d-M-Y',$date);
            return $date->format('Y-M-d');
        }
    }

    //  $db= new db();
    // echo $db->getJSON('call `sp_getcast`()');
?>