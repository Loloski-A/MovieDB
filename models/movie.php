<?php
    require_once("db.php");

    class movie extends db{
        // check movie
        function checkmovie($movieid,$title){
            $sql="CALL `sp_checkmovie`({$movieid},'{$title}')";
            return $this->getData($sql)->rowCount();
        }

        // save movie
        function savemovie($movieid,$userid,$title,$releasedate,$synopsis,$duration,$posterurl,$trailerurl){
            // check if movie exists
            if($this-> checkmovie($movieid,$title)){
                return ["status"=>"exists","message"=>"movie exists"];
            }else{
                 $sql="CALL `sp_savemovie`({$movieid},{$userid},'{$title}','{$releasedate}','{$synopsis}','{$duration}','{$posterurl}','{$trailerurl}')";
                $this->getData($sql);
                return ["status"=>"success","message"=>"movie saved succesfully"];
            }
        }

        // get movie
        function getmovie(){
            $sql="CALL `sp_getmovie`()";
            return $this->getJSON($sql);
        }

        // get movie details
        function getmoviedetails($movieid){
            $sql="CALL `sp_getmoviedetails`({$movieid})";
            return $this->getJSON($sql);
        }

        // delete movie
        function deletemovie($movieid){
            $sql="CALL `sp_deletemovie`({$movieid},{$this->userid})";
            // echo $sql.PHP_EOL;
            $this->getData($sql);
            return ["status"=>"success","message"=>"movie deleted successfully"];
        }
    }
?>