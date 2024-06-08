$(document).ready(function () {

    //exercices jquery Mozart
    $('#montrer_image').hide();
    $('#para1').hide();
    $('#vie').hide();
    $('#deuxieme').hide();
    $('#troisieme').hide();
    $('#quatrieme').hide();
    $('#cinquieme').hide();
    $('#cacher').hide();

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


    /* Js POUR exer_jquery2.php */
    $('#submit').remove();
    $('#description_voiture').hide();

    $('#choix_voiture').change(function () {
        let name = $(this).attr('name');
        let id_produitvoiture = $(this).val(); //on récupère la valeur du <select>, dans name
        console.log("name = " + name + " et id_voiture = " + id_voiture);
        let parametre = 'id_voiture=' + id_voiture;
        let retour = $.ajax({
            type: 'GET',
            data: parametre,
            datatype: 'json',
            url: 'admin/lib/php/ajax/ajaxRechercheVoiture.php',
            success: function (data) {
                console.log(data);
                $('#description_voiture').show();
                $('#image_voiture').html("<img src='./admin/images/" + data[0].illustration + "' alt='voiture'>");
                $('#detail_voiture').html("Nom : " + data[0].libelle + "<br>Prix : " + data[0].prix);
            }

        });

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
                url: "./lib/php/ajax/ajaxEditvoiture.php",
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
            url: './lib/php/ajax/ajaxDeletevoiture.php',
            success: function () {
                console.log("Supprimé");
            }
        });
    }
});

//ajouter un produit : agrandir le texte quand on passe la souris
$('p').mouseover(function () {
    $(this).css('font-size', '20px');
}).mouseout(function () {
    $(this).css('font-size', '16px');
});


    //ajouter une ligne de tableau
$('#ajouter_voiture').click(function(){
    let html = "<tr id='nouvelle'><th scope=\"row\"> * </th>";
    html += "<td contenteditable='true' id='libelle' name='libelle'></td>";
    html += "<td contenteditable='true' id='prix' name='prix'></td>";
    html += "<td contenteditable='true' id='illustration' name='illustration'></td></tr>";
    $("#tableau_produitsvoitures tbody").prepend(html);
    $('td[id]').blur(function(){
        let valeur = $(this).text();
        let champ = $(this).attr('id');
        let flag = true;
        $('#tableau_voitures tr:gt(1)').each(function() { //"greater than" indice 1 (qui est la nouvelle ligne créée)
            let autre = $(this).find('td:eq(0)').text();
            // utilise la méthode :eq() [= EQual] pour sélectionner la cellule et la méthode text() pour récupérer son contenu
            if(autre === valeur) {
                if ($('td[id]').attr('name') == 'libelle_produit') {
                    flag = false;
                }
            }
            if(flag == false){
                return false;
            }
        });
        if(flag == false){
            $('#nouveau_td').html("<span class='txtRed txtGras'>Voiture déjà encodé</span>")
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


// Display image au passage de la souris sur le nom du fichier
$("td[id]").mouseover(function () {
    let id_voiture = $(this).attr("id"); // valeur de l'id
    parametre = "id_voiture=" + id_voiture;
    let retour = $.ajax({
        type: 'GET',
        data: parametre,
        datatype: 'json',
        url: './lib/php/ajax/ajaxRechercheVoiture.php',
        success: function (data) {
            console.log(data);
            $('#illustration').html("<img src='./images/" + data[0].illustration + "' alt='voiture'>");
        }
    });
});

// Filtrage de la table produit
$("#filtre").keyup(function () {
    let filtre = $(this).val().toLowerCase();
    $("#tableau_produits tbody tr").filter(function () {
        $(this).toggle($(this).text().toLowerCase().indexOf(filtre) > -1);
        // indexOf retourne -1 si la valeur ne correspond pas au filtre
    });
});
});
