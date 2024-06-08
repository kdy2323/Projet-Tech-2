<?php

class VoitureBD extends Voiture
{
    private $_db;
    private $_array = array();

    public function __construct($cnx)
    {
        $this->_db = $cnx;
    }

    public function editVoiture($champ, $id, $valeur)
    {
        try {
            $query = "UPDATE produits SET $champ = '$valeur' WHERE id_voiture = '$id'";
            $res = $this->_db->prepare($query);
            $res->execute();
            return true;
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
            return false;
        }
    }

    public function addVoiture($libelle, $prix, $illustration, $qstock, $id_categorie)
{
    try {
        $query = "INSERT INTO voitures (libelle, prix, illustration, qstock, id_categorie) VALUES (:libelle, :prix, :illustration, :qstock, :id_categorie)";
        $res = $this->_db->prepare($query);
        $res->bindValue(':libelle', $libelle);
        $res->bindValue(':prix', $prix);
        $res->bindValue(':illustration', $illustration);
        $res->bindValue(':qstock', $qstock);
        $res->bindValue(':id_categorie', $id_categorie);
        $res->execute();
        return true;
    } catch (PDOException $e) {
        print "Echec " . $e->getMessage();
        return false;
    }
}
    public function deleteVoiture($id)
    {
        try {
            $query = "DELETE FROM voitures WHERE id_voiture = :id";
            $res = $this->_db->prepare($query);
            $res->bindValue(':id', $id);
            $res->execute();

            return true;
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();

            return false;
        }
    }

    public function getVoitureById($id)
    {
        try {
            $query = "SELECT * FROM produits WHERE id_voiture = :id";
            $res = $this->_db->prepare($query);
            $res->bindValue(':id', $id);
            $res->execute();
            $data = $res->fetch();
            return $data;
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }

    public function getVueAllVoitures()
    {
        try {
            $query = "SELECT * FROM vue_voitures ORDER BY id_voiture";
            $res = $this->_db->prepare($query);
            $res->execute();

            while ($data = $res->fetch()) {
                $_array[] = new Voiture($data);
            }
            if (!empty($_array)) {
                return $_array;
            } else {
                return array();
            }
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }


    public function getAllCategories()
    {
        try {
            $query = "SELECT * FROM categorie ORDER BY nom_cat";
            $res = $this->_db->prepare($query);
            $res->execute();

            while ($data = $res->fetch()) {
                $_array[] = new Categorie($data);
            }
            if (!empty($_array)) {
                return $_array;
            } else {
                return null;
            }
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }

}
