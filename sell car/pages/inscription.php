<?php
// fonction pour la mise en forme et la sécurité
function post_data($field)
{
    if (!isset($_POST[$field])) {
        return false;
    }
    $data = $_POST[$field];
    return htmlspecialchars(stripslashes(trim($data)));
}

define('REQUIRED_FIELD_ERROR', 'Ce champ est requis');
$errors = [];
$nom_client = '';
$prenom_client = '';
$email = '';
$passwordd = '';
$nom_rue = '';
$num_rue = '';
$id_ville = '';

if (isset($_POST['submit'])) {
    $nom_client = post_data('nom_client');
    $prenom_client = post_data('prenom_client');
    $email = post_data('email');
    $passwordd = post_data('passwordd');
    $nom_rue = post_data('nom_rue');
    $num_rue = post_data('num_rue');
    $id_ville = post_data('id_ville');

    // Vérification des champs requis
    if (!$nom_client) {
        $errors['nom_client'] = REQUIRED_FIELD_ERROR;
    }

    if (!$prenom_client) {
        $errors['prenom_client'] = REQUIRED_FIELD_ERROR;
    }

    if (!$email) {
        $errors['email'] = REQUIRED_FIELD_ERROR;
    } else if (!filter_var($email, FILTER_VALIDATE_EMAIL)){
        $errors['email'] = 'Veuillez entrer une adresse email valide';
    }

    if (!$passwordd) {
        $errors['passwordd'] = REQUIRED_FIELD_ERROR;
    }

    if (!$nom_rue) {
        $errors['nom_rue'] = REQUIRED_FIELD_ERROR;
    }

    if (!$num_rue) {
        $errors['num_rue'] = REQUIRED_FIELD_ERROR;
    }

    if (!$id_ville) {
        $errors['id_ville'] = REQUIRED_FIELD_ERROR;
    }

    // Si aucune erreur n'a été détectée, vous pouvez procéder à l'insertion des données dans la base de données
    if (empty($errors)) {
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

        // Insertion des données dans la table client
        $query = "INSERT INTO client (nom_client, prenom_client, mail, motdepasse, nom_rue, num_rue, id_ville) 
                  VALUES (:nom_client, :prenom_client, :email, :passwordd, :nom_rue, :num_rue, :id_ville)";

        try {
            $stmt = $pdo->prepare($query);
            $stmt->bindParam(':nom_client', $nom_client);
            $stmt->bindParam(':prenom_client', $prenom_client);
            $stmt->bindParam(':email', $email);
            $stmt->bindParam(':passwordd', $passwordd);
            $stmt->bindParam(':nom_rue', $nom_rue);
            $stmt->bindParam(':num_rue', $num_rue);
            $stmt->bindParam(':id_ville', $id_ville);
            $stmt->execute();

            session_start();
            $_SESSION['prenom_client'] = $prenom_client;
            // Redirection vers la page d'accueil ou toute autre page de votre choix
            header("Location: index_.php?page=accueil.php");
            exit();
        } catch (PDOException $e) {
            echo "Erreur lors de l'insertion des données dans la base de données : " . $e->getMessage();
            die();
        }
    }
}
?>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Formulaire d'enregistrement</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <form method="POST" action="<?php echo $_SERVER['PHP_SELF'] ?>">
        <div class="row">
            <div class="col">
                <div class="mt-5 mb-5">
                    <label for="nom_client">Nom</label>
                    <input class="form-control <?php echo isset($errors['nom_client']) ? 'is-invalid' : '' ?>"
                           name="nom_client" placeholder="Entrer votre nom" value="<?php echo $nom_client ?>">
                    <div class="invalid-feedback">
                        <?php echo $errors['nom_client'] ?>
                    </div>
                </div>
            </div>
            
            <div class="col">
                <div class="mt-5 mb-5">
                    <label for="prenom_client">Prénom</label>
                    <input class="form-control <?php echo isset($errors['prenom_client']) ? 'is-invalid' : '' ?>"
                           name="prenom_client" placeholder="Entrer votre prénom" value="<?php echo $prenom_client ?>">
                    <div class="invalid-feedback">
                        <?php echo $errors['prenom_client'] ?>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col">
                <div class="mt-5 mb-5">
                    <label for="email">Email</label>
                    <input type="text" class="form-control <?php echo isset($errors['email']) ? 'is-invalid' : '' ?>"
                           name="email" placeholder="Entrer votre email" value="<?php echo $email ?>">
                    <div class="invalid-feedback">
                        <?php echo $errors['email'] ?>
                    </div>
                </div>
            </div>
            
            <div class="col">
                <div class="mt-5 mb-5">
                    <label for="passwordd">Mot de passe</label>
                    <input type="password" class="form-control <?php echo isset($errors['passwordd']) ? 'is-invalid' : '' ?>"
                           name="passwordd" placeholder="Entrer votre mot de passe" value="<?php echo $passwordd ?>">
                    <div class="invalid-feedback">
                        <?php echo $errors['passwordd'] ?>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col">
                <div class="mt-5 mb-5">
                    <label for="nom_rue">Nom de rue</label>
                    <input class="form-control" name="nom_rue" placeholder="Entrer votre nom de rue" value="<?php echo $nom_rue ?>">
                </div>
            </div>
            
            <div class="col">
                <div class="mt-5 mb-5">
                    <label for="num_rue">Numéro de rue</label>
                    <input class="form-control" name="num_rue" placeholder="Entrer votre numéro de rue" value="<?php echo $num_rue ?>">
                </div>
            </div>
        </div>
        
        <div class="row">
        <div class="col">
                <!-- espacement margin et padding -->
                <!-- https://getbootstrap.com/docs/5.1/utilities/spacing/ -->
                <div class="mt-5 mb-5">    
                    <label for="username">ID-ville</label>
                    <!-- validation du formulaire form-control is-invalid-->
                    <!-- https://getbootstrap.com/docs/5.1/forms/validation/ -->
                    <input class="form-control "name="id_ville" placeholder="Entrer votre ID-ville" >
            </div>
        </div>
        
        <br>
        
        <div>
            <!-- btn btn-primary -->
            <!-- https://getbootstrap.com/docs/5.1/components/buttons/ -->
            <input type="submit" class="btn btn-primary" name="submit" value="Enregistrement">
        </div>
    </form>
</div>
</body>
</html>

