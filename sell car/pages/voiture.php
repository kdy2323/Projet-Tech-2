<?php
$voiture = new VoitureBD($cnx); //$cnx est fourni par l'index
$voitures[] = $voiture->getVueAllVoitures();
$nbr = count($voitures)
?>
<div style="text-align: right;">
    <a href="./pages/ajouter_au_panier.php" class="btn btn-primary">Voir le panier</a>
</div>


<div class="album py-5 bg-light">
    <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
            <?php
            for ($i = 0; $i < $nbr; $i++) {
                ?>
                <div class="col">
                    <div class="card shadow-sm card-deck">
                        <svg class="bd-placeholder-img card-img-top" width="100%" height="50"
                             xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail"
                             preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title>
                            <rect width="100%" height="100%" fill="#55595c"/>
                            <img class="img-fluid" src="./admin/images/<?php print $voitures[$i]->illustration; ?>" alt="Voiture"/>
                        </svg>
                        <div class="card-body">
                            <p class="card-text"><?php print $voitures[$i]->libelle; ?></p>
                            <p class="card-text"><?php print $voitures[$i]->prix; echo '€' ?></p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                <a class="nav-link" href="./index_.php?page=details.php"><button type="button" class="btn btn-sm btn-outline-secondary">Voir plus</button></a>
                                    
                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="ajouterAuPanier(<?php echo $voitures[$i]->id; ?>)">Ajouter au panier</button>

                                </div>
                                <small class="text-muted">9 mins</small>
                            </div>
                        </div>
                    </div>
                </div>
                <?php
            }
            ?>
        </div>
    </div>
</div>



