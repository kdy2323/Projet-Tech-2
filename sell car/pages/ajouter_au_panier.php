<?php


if (isset($_POST['idVoiture'])) {
    $idVoiture = $_POST['idVoiture'];
    $voiture = new VoitureBD($cnx); //$cnx est fourni par l'index
    $voitureDetail = $voiture->getVoitureById($idVoiture);
    
    // Vérifiez si le produit existe
    if ($voitureDetail) {
        $nomVoiture = $voitureDetail['libelle'];
        $prixVoiture = $voitureDetail['prix'];
        $illustrationVoiture = $voitureDetail['illustration'];
        
    } else {
        echo "La voiture n'existe pas.";
    }
    

    if (!isset($_SESSION['panier'])) {
        $_SESSION['panier'] = array();
    }
    $_SESSION['panier'][] = $idVoiture;

    echo "La Voiture a été ajouté au panier.";
}
else {
    echo "Erreur : ID de la Voiture non spécifié.";
}
?>
