<?php
class CategorieBD extends Categorie
{
    private $_db;
    private $_array = array();

    public function __construct($cnx)
    {
        $this->_db = $cnx;
    }

    public function getAllCategories(){
        try{
            $query="select * from categorie order by nom_cat";
            $res = $this->_db->prepare($query);
            $res->execute();
            while($data = $res->fetch()){
                $_array[] = new Categorie($data);
            }
            if(!empty($_array)){
                return $_array;
            }else {
                return null;
            }
        }catch(PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }
}
