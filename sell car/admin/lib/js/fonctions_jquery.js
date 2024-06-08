$(document).ready(function () {

  

    /* Cliquer sur le titre et afficher les premiers éléments de bio*/
    $('h1').click(function () {
        $(this).css('color', 'red');
        $('#vie').show();
    })

    //passer la souris sur la bio pour appliquer plusieurs styles css
    //sortie de souris : faire apparaître le bouton d'id para1 et changer la couleur du texte de la bio
    $('#vie').mouseover(function () {
        $(this).css({
            'color': '#0044AA',
            'font-style': 'italic',
            'font-weight': 'bold'
        }),
            $(this).mouseout(function () {
                $('#para1').show();
                $(this).css('color', '#D09');
            })
    });

    $('#para1').click(function () {
        $('#deuxieme').show();
    });

    $('#deuxieme').click(function () {
        $('#troisieme').slideDown();
    });

    $('#troisieme').click(function () {
        $('#quatrieme').show();
        $('#cinquieme').fadeIn(2000);
    });

    $('#cinquieme').mouseover(function () {
        $('#cacher').show();
    });

    $('#cacher').click(function () {
        $('#montrer_image').slideDown(3000);
    });


    

    //tableau éditable
    $("td[id]").click(function () {
        let valeur1 = $.trim($(this).text());
        let id = $(this).attr("id");
        let name = $(this).attr("name");

        $(this).blur(function () {
            let valeur2 = $.trim($(this).text());
            if (valeur1 != valeur2) {
                let parametre = "champ=" + name + "&id=" + id + "&nouveau=" + valeur2;
                var retour = $.ajax({
                    type: 'GET',
                    data: parametre,
                    dataType: "text",
                    url: "./lib/php/ajax/ajaxEditVoiture.php",
                    success: function (data) {
                        //rien de particulier à faire
                        console.log("success");
                    }
                });
            }
        });
    });


    //suppression d'une ligne du tableau éditable
    $(".delete").click(function () {
        let effacer = $(this).attr('id');
        console.log("effacer = " + effacer);
        if (confirm("Supprimer ?")) {
            let ligne = $(this).closest("tr");
            ligne.css("background-color", "lightpink");
            ligne.fadeOut();
            parametre = "id_voiture=" + effacer;
            retour = $.ajax({
                type: 'GET',
                data: parametre,
                datatype: 'json',
                url: './lib/php/ajax/ajaxDeleteVoiture.php',
                success: function () {
                    console.log("Supprimé");
                }
            });

        }
    });

    //ajouter un produit : agrandir le texte on passe de la souris
    $('p').mouseover(function() {
        $(this).css('font-size', '20px');
    }).mouseout(function() {
        $(this).css('font-size', '16px');
    });

    //ajouter une ligne de tableau
    $('#ajouter_voiture').click(function(){
        let html = "<tr id='nouvelle'><th scope=\"row\"> * </th>";
        html += "<td contenteditable='true' id='libelle' name='libelle'></td>";
        html += "<td contenteditable='true' id='prix' name='prix'></td>";
        html += "<td contenteditable='true' id='illustration' name='illustration'></td></tr>";
        $("table tbody").prepend(html);
        $('td[id]').blur(function(){
            let valeur = $(this).text();
            let champ = $(this).attr('id');
            let flag = true;
            $('table tr:gt(1)').each(function() { //"greater than" indice 1 (qui est la nouvelle ligne créée)
                let autre = $(this).find('td:eq(0)').text();
                // utilise la méthode :eq() [= EQual] pour sélectionner la cellule et la méthode text() pour récupérer son contenu
                if(autre === valeur) {
                    if ($('td[id]').attr('name') == 'libelle') {
                        flag = false;
                    }
                }
                if(flag == false){
                    return false;
                }
            });
            if(flag == false){
                $('#nouveau_td').html("<span class='txtRed txtGras'>produit déjà encodée</span>")
                $('#nouvelle').fadeOut(2000);
            } else {
                $('#nouveau_td').hide();
                let parametre = "champ=" + champ + "&nouveau=" + valeur;
                console.log(parametre);
                let retour = $.ajax({
                    type: 'GET',
                    data: parametre,
                    datatype: 'json',
                    url: './lib/php/ajax/ajaxInsertVoiture.php',
                    success: function () {
                        console.log("Ajouté");
                    }
                })
            }
        });
    });

    function comparer(a,b){
        if(a == b){
            return true;
        }
        else{
            return false;
        }
    }

    /*
    var tableau = [1, 2, 3, 4, 5, 6];   var valeurRecherchee = 3;   var valeurTrouvee = false;
$.each(tableau, function(index, valeur) {
  if (valeur === valeurRecherchee) {
    valeurTrouvee = true;
    return false; // arrête la boucle each
  }
});
     */



    //Display image au passage de la souris sur le nom du fichier
    $("td[id]").mouseover(function () {
        let id = $(this).attr("id"); //valeur de l'id
        //let name = $(this).attr("name"); //nom du champ
        parametre = "id_voiture=" + id;
        let retour = $.ajax({
            type: 'GET',
            data: parametre,
            datatype: 'json',
            url: './lib/php/ajax/ajaxRechercheVoiture.php',
            success: function (data) {
                console.log(data);
                $('#illustration').html("<img src='./images/" + data[0].illutration + "' alt='voiture'>");

            }

        });
    });

    //filtrage de lecture2
    $("#filtre").keyup(function () {
        let filtre = $(this).val().toLowerCase();
        $("#table_produits tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(filtre) > -1)
            //indexOf retourne -1 si la valeur ne correspond pas au filtre
        })
    });




});

