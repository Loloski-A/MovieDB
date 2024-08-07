<?php
    require_once("db.php");

    class genre extends db{
        // check genre
        function checkgenre($genreid,$genrename){
            $sql="CALL `sp_checkgenre`({$genreid},'{$genrename}')";
            return $this->getData($sql)->rowCount();
        }

        // save genre
        function savegenre($genreid,$genrename,$description){
            // check if genre exists
            if($this-> checkgenre($genreid,$genrename)){
                return ["status"=>"exists","message"=>"genre exists"];
            }else{
                 $sql="CALL `sp_savegenre`({$genreid},'{$genrename}','{$description}',{$this->userid})";
                $this->getData($sql);
                return ["status"=>"success","message"=>"genre saved succesfully"];
            }
        }

        // get genre
        function getgenre(){
            $sql="CALL `sp_getgenre`()";
            return $this->getJSON($sql);
        }

        // get genre details
        function getgenredetails($genreid){
            $sql="CALL `sp_getgenredetails`({$genreid})";
            return $this->getJSON($sql);
        }

        // delete genre
        function deletegenre($genreid){
            $sql="CALL `sp_deletegenre`({$genreid},{$this->userid})";
            // echo $sql.PHP_EOL;
            $this->getData($sql);
            return ["status"=>"success","message"=>"genre deleted successfully"];
        }
    }
?>