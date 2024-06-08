<?php
header('Content-Type: application/json');
/*
la fonction header('Content-Type: application/json') assure que la réponse du serveur est correctement
et directement interprétée comme objet JSON et non texte ou html.
*/
require '../dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/voiture.class.php';
require '../classes/VoitureBD.class.php';

$cnx = Connexion::getInstance($dsn,$user,$password);

try{
    $voiture = new VoitureBD($cnx);
    $rep = $voiture->editVoiture($_GET['champ'],$_GET['id'],$_GET['nouveau']);
}catch(PDOException $e){
    print $e->getMessage();
}
