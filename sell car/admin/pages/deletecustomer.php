<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $mail = $_POST['mail'] ?? '';

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

    // Suppression du client dans la table client
    $query = "DELETE FROM client WHERE mail = :mail";

    try {
        $stmt = $pdo->prepare($query);
        $stmt->bindParam(':mail', $mail);
        $stmt->execute();

        header("Location: ./affiche2.php");
        exit();
    } catch (PDOException $e) {
        echo "Erreur lors de la suppression du client dans la base de données : " . $e->getMessage();
        die();
    }
}

?>
