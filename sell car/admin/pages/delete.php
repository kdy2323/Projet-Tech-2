<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $libelle = $_POST['libelle'] ?? '';

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

    // Suppression du produit dans la table produits
    $query = "DELETE FROM voiture WHERE libelle = :libelle";

    try {
        $stmt = $pdo->prepare($query);
        $stmt->bindParam(':libelle', $libelle);
        $stmt->execute();

        header("Location: ./affiche2.php");
        exit();
    } catch (PDOException $e) {
        echo "Erreur lors de la suppression du produit dans la base de données : " . $e->getMessage();
        die();
    }
}

?>
