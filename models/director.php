<?php
    require_once("db.php");

    class director extends db{
        // check director
        function checkdirector($directorid,$directorname){
            $sql="CALL `sp_checkdirector`({$directorid},'{$directorname}')";
            return $this->getData($sql)->rowCount();
        }

        // save director
        function savedirector($directorid,$directorname,$dob,$biography,$nationality,$gender,$socialmedialinks,$addedby,$profileimageurl){
            // check if director exists
            if($this-> checkdirector($directorid,$directorname)){
                return ["status"=>"exists","message"=>"director exists"];
            }else{
                 $sql="CALL `sp_savedirector`({$directorid},'{$directorname}','{$dob}','{$biography}',{$nationality},'{$gender}','{$socialmedialinks}',{$addedby},'{$profileimageurl}')";
                $this->getData($sql);
                return ["status"=>"success","message"=>"director saved succesfully"];
            }
        }

        // get director
        function getdirector(){
            $sql="CALL `sp_getdirector`()";
            return $this->getJSON($sql);
        }

        // get director details
        function getdirectordetails($directorid){
            $sql="CALL `sp_getdirectordetails`({$directorid})";
            return $this->getJSON($sql);
        }

        // delete director
        function deletedirector($directorid){
            $sql="CALL `sp_deletedirector`({$directorid},{$this->userid})";
            // echo $sql.PHP_EOL;
            $this->getData($sql);
            return ["status"=>"success","message"=>"director deleted successfully"];
        }
    }
?>