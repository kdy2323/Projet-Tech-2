
<p style="font-family: Arial, sans-serif; font-size: 18px;">Attention: Vous êtes sur le point de supprimer un client !</p>

    <div class="container">
        <form method="POST" action="pages/deletecustomer.php">
            <div class="mb-3">
                <label for="nom" class="form-label">Email:</label>
                <input type="text" class="form-control" name="mail" placeholder="Entrez l'email du client a supprimer">
            </div>
            
            <button type="submit" class="btn btn-primary" name="submit">Envoyer les informations</button>
        </form>
    </div>
