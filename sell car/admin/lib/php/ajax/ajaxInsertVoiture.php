<?php
header('Content-Type: application/json');
require '../dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/voiture.class.php';
require '../classes/VoitureBD.class.php';

$cnx = Connexion::getInstance($dsn,$user,$password);

$Voiture = new VoitureBD($cnx);
$data[] = $voiture->addProduit($_GET['libelle'],$_GET['prix'],$_GET['illustration'],$_GET['qstock'],$_GET['id_categorie']);
print json_encode($data);
