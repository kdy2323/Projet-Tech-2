
    <div class="container">
        <form method="POST" action="pages/ajout.php">
            <div class="mb-3">
                <label for="nom" class="form-label">Nom:</label>
                <input type="text" class="form-control" name="libelle" placeholder="Entrez le nom">
            </div>
            <div class="mb-3">
                <label for="prenom" class="form-label">Prix:</label>
                <input type="text" class="form-control" name="prix" placeholder="Entrez le prix">
            </div>
            <div class="mb-3">
                <label for="prenom" class="form-label">Illustration:</label>
                <input type="text" class="form-control" name="illustration" placeholder="Entrez l'illustration">
            </div>
            <div class="mb-3">
                <label for="qte" class="form-label">Qstock:</label>
                <input type="number" class="form-control" name="qstock" placeholder="Entrez la quantité en stock">
            </div>
            <div class="mb-3">
                <label for="id_categorie" class="form-label">ID Catégorie:</label>
                <input type="number" class="form-control" name="id_categorie" placeholder="Entrez l'ID de la catégorie">
            </div>
            <button type="submit" class="btn btn-primary" name="submit">Envoyer les informations</button>
        </form>
    </div>

