<?php
    require_once("db.php");

    class media extends db{
        // check media
        function checkmedia($mediaid,$mediatype){
            $sql="CALL `sp_checkmedia`({$mediaid},'{$mediatype}')";
            return $this->getData($sql)->rowCount();
        }

        // save media
        function savemedia($mediaid,$mediatype,$title,$description,$filepath,$addedby){
            // check if media exists
            if($this-> checkmedia($mediaid,$mediatype)){
                return ["status"=>"exists","message"=>"media exists"];
            }else{
                 $sql="CALL `sp_savemedia`({$mediaid},'{$mediatype}','{$title}','{$description}','{$filepath}',{$addedby})";
                $this->getData($sql);
                return ["status"=>"success","message"=>"media saved succesfully"];
            }
        }

        // get media
        function getmedia(){
            $sql="CALL `sp_getmedia`()";
            return $this->getJSON($sql);
        }

        // get media details
        function getmediadetails($mediaid){
            $sql="CALL `sp_getmediadetails`({$mediaid})";
            return $this->getJSON($sql);
        }

        // delete media
        function deletemedia($mediaid){
            $sql="CALL `sp_deletemedia`({$mediaid},{$this->userid})";
            // echo $sql.PHP_EOL;
            $this->getData($sql);
            return ["status"=>"success","message"=>"media deleted successfully"];
        }
    }
?>