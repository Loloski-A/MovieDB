<?php
    require_once("db.php");

    class cast extends db{
        // check cast
        function checkcast($castid,$castname){
            $sql="CALL `sp_checkcast`({$castid},'{$castname}')";
            return $this->getData($sql)->rowCount();
        }

        // save cast
        function savecast($castid,$castname,$dob,$biography,$roleid,$nationality,$gender,$socialmedialinks, $addedby,$profileimageurl){
            // check if cast exists
            if($this-> checkcast($castid,$castname)){
                return ["status"=>"exists","message"=>"genre exists"];
            }else{
                 $sql="CALL `sp_savecast`({$castid},'{$castname}','{$dob}','{$biography}',{$roleid},{$nationality},'{$gender}','{$socialmedialinks}',{$addedby},'{$profileimageurl}')";
                $this->getData($sql);
                return ["status"=>"success","message"=>"cast saved succesfully"];
            }
        }

        // get cast
        function getcast(){
            $sql="CALL `sp_getcast`()";
            return $this->getJSON($sql);
        }

        // get cast details
        function getcastdetails($castid){
            $sql="CALL `sp_getcastdetails`({$castid})";
            return $this->getJSON($sql);
        }

        // delete cast
        function deletecast($castid){
            $sql="CALL `sp_deletecast`({$castid},{$this->userid})";
            // echo $sql.PHP_EOL;
            $this->getData($sql);
            return ["status"=>"success","message"=>"cast deleted successfully"];
        }
    }
?>