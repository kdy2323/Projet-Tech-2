<style>
    ul.nav {
        background-color: #333;
        padding: 10px;
        list-style-type: none;
        display: flex;
        justify-content: flex-end;
        margin: 0;
    }
    
    ul.nav li {
        margin-right: 20px;
    }
    
    ul.nav li a {
        color: white;
        text-decoration: none;
        font-size: 16px;
        font-weight: bold;
        padding: 10px;
    }
    
    ul.nav li a:hover {
        background-color: #555;
    }
    
    h2 {
        text-align: center;
        margin-top: 20px;
        color: #333;
    }
</style>

<h2>Interface admin</h2>
<ul class="nav">
    <li class="nav-item">
        <a class="nav-link active" aria-current="page" href="index_.php?page=accueil.php">Accueil</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="index_.php?page=gestion_voitures.php">Gestion des voitures</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="index_.php?page=add.php">Ajouter des voitures</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="index_.php?page=suppres.php">Supprimer des voitures</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="index_.php?page=suppresioncustomer.php">Gérer les clients</a>
    </li>
</ul>
