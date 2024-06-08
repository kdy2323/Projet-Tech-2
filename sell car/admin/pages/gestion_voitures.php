
<?php
$voiture = new VoitureBD($cnx);
$voitures[] = $voiture->getVueAllVoitures();
$nbr = count($voitures);
?>

<div class="subdivision">
    <div class="subdiv1">
        <input class="form-control" id="filtre" type="text" placeholder="Filtrer"><br/>
        <p id="ajouter_voiture" class="txtGras txtItalic red">Nouveau produit</p>
        <div id="nouveau_td"></div>
        <table class="table table-striped table-hover" id="tableau_voitures">
            <thead>
            <tr>
                <th scope="col">Id</th>
                <th scope="col">Voiture</th>
                <th scope="col">Prix</th>
                <th scope="col">Image</th>

            </tr>
            </thead>
            <tbody id="table_voitures">
            <?php
            for ($i = 0; $i < $nbr; $i++) {
                ?>
                <tr id="<?php print $voitures[$i]->id_voiture; ?>">
                    <th scope="row"><?php print $voitures[$i]->id_voiture; ?></th>
                    <td contenteditable="true" id="<?php print $voitures[$i]->id_voiture; ?>"
                        name="libelle"><?php print $voitures[$i]->libelle; ?></td>
                    <td contenteditable="true" id="<?php print $voitures[$i]->id_voiture ?>"
                        name="prix"><?php print $voitures[$i]->prix; ?></td>
                    <td contenteditable="true" id="<?php print $voitures[$i]->id_produit; ?>"
                        name="illustration"><?php print $voitures[$i]->illustration; ?></td>
                    <td><img class="delete" src="./images/delete.jpg" alt="delete"
                             id="<?php print $voitures[$i]->id_voiture; ?>"></td>
                </tr>
                <?php
            }
            ?>
            </tbody>
        </table>
    </div>
    <div class="subdiv2">
        <span id="illustration"></span>
    </div>
</
