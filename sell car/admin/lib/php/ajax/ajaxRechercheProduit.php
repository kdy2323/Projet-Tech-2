<?php
header('Content-Type: application/json');
// Chemin d'accès depuis le fichier ajax php
require '../dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/voiture.class.php';
require '../classes/VoitureBD.class.php';
$cnx = Connexion::getInstance($dsn, $user, $password);

$voiture = new VoitureBD($cnx);
$data[] = $voiture->getVoitureById($_GET['id_voiture']);
print json_encode($data);
