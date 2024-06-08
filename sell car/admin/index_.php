<!doctype html>

<?php
//admin
session_start();
include ('./lib/php/admin_liste_include.php');

//include ('./admin/lib/php/admin_liste_include.php');
//$cnx = Connexion::getInstance($dsn,$user,$password);
?>
<html>
<head>
    <title>Welcome ADMIN</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <link rel="stylesheet" href="lib/css/style.css"/>
    <link rel="stylesheet" href="lib/css/custom.css"/>
    <script src="./lib/js/fonctions_jquery.js"></script>
</head>

<body>
<div id="page" class="container">
    <header class="img_header"></header>
    <section id="colGauche">
        <nav>
            <?php
            $path = "./lib/php/menu_admin.php";
            if (file_exists($path)) {
                include ($path);
            }
            ?>
        </nav>
        <a href="index_.php?page=disconnect.php">Se déconnecter</a>
        <h2>Bienvenue  administrateur</h2>
        
    </section>
    <section id="contenu">
        <div id="main">
            <?php
            if (!isset($_SESSION['page'])) {
                $_SESSION['page'] = "accueil.php";
            }
            if (isset($_GET['page'])) {
                //si on a un param page dans l'url
                $_SESSION['page'] = $_GET['page'];
            }
            $path = "./pages/" . $_SESSION['page'];
            // print "path: " . $path . "<br>";
            if (file_exists($path)) {
                include ($path);
            } else {
                include ("./pages/page404.php");
            }
            ?>
        </div>
    </section>

</div>
<footer class="footer bg-light">
  <!--  <div class="container">
        <span class="text-muted">Demo 2023</span>
    </div>
    -->
</footer>
</body>
</html>