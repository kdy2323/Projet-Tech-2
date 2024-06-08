<?php

 

?>
<?php
$libelle = '';
$prix = '';
$illustration = '';
$qstock  = '';
$id_categorie = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $libelle = $_POST['libelle'] ?? '';
    $prix = $_POST['prix'] ?? '';
    $illustration = $_POST['illustration'] ?? '';
    $qstock = $_POST['qstock'] ?? '';
    $id_categorie = $_POST['id_categorie'] ?? '';

    // Connexion à la base de données
    $dsn = 'pgsql:host=localhost;dbname=shopp;port=5432';
    $user = 'anonyme';
    $password = 'anonyme';

    try {
        $pdo = new PDO($dsn, $user, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch (PDOException $e) {
        echo "Erreur de connexion à la base de données : " . $e->getMessage();
        die();
    }

    // Insertion des données dans la table
    $query = "INSERT INTO voiture (libelle, prix, illustration, qstock, id_categorie) 
              VALUES (:libelle, :prix, :illustration, :qstock, :id_categorie)";

    try {
        $stmt = $pdo->prepare($query);
        $stmt->bindParam(':libelle', $libelle);
        $stmt->bindParam(':prix', $prix);
        $stmt->bindParam(':illustration', $illustration);
        $stmt->bindParam(':qstock', $qstock);
        $stmt->bindParam(':id_categorie', $id_categorie);
        $stmt->execute();

        
        header("Location: ./affiche.php");
        exit();
    } catch (PDOException $e) {
        echo "Erreur lors de l'insertion des données dans la base de données : " . $e->getMessage();
        die();
    }
}
?>
