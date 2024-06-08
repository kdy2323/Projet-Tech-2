
    <h2>Laissez un avis</h2>
    <form action="traitement_suggestion.php" method="POST">
        <label for="nom">Nom :</label>
        <input type="text" name="nom" id="nom" required><br><br>

        <label for="email">Email :</label>
        <input type="email" name="email" id="email" required><br><br>

        <label for="suggestion">Votre avis :</label><br>
        <textarea name="suggestion" id="suggestion" rows="5" cols="40" required></textarea><br><br>

        <input type="submit" value="Envoyer">
    </form>

