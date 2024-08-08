<?php
    require_once("db.php");

    class language extends db{
        // check language
        function checklanguage($languageid,$languagename){
            $sql="CALL `sp_checklanguage`({$languageid},'{$languagename}')";
            return $this->getData($sql)->rowCount();
        }

        // save language
        function savelanguage($languageid,$languagename,$languagecode,$addedby){
            // check if langauge exists
            if($this-> checklanguage($languageid,$languagename)){
                return ["status"=>"exists","message"=>"language exists"];
            }else{
                 $sql="CALL `sp_savelanguage`({$languageid},'{$languagename}','{$languagecode}',{$addedby})";
                $this->getData($sql);
                return ["status"=>"success","message"=>"language saved succesfully"];
            }
        }

        // get language
        function getlanguage(){
            $sql="CALL `sp_getlanguage`()";
            return $this->getJSON($sql);
        }

        // get language details
        function getlanguagedetails($languageid){
            $sql="CALL `sp_getlanguagedetails`({$languageid})";
            return $this->getJSON($sql);
        }

        // delete language
        function deletelanguage($languageid){
            $sql="CALL `sp_deletelanguage`({$languageid},{$this->userid})";
            // echo $sql.PHP_EOL;
            $this->getData($sql);
            return ["status"=>"success","message"=>"language deleted successfully"];
        }
    }
?>