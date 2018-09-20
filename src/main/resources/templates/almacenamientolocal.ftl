<html>
<#include "layout.ftl">
<style>
    #out {
        height: 50%;
    }
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
    }
</style>
<br>
<body class="bg-light">
<div class="container" >



    <div class="table-responsive table-bordered ">


        <table id="datoslocal" class="table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Sector</th>
                <th>Nivel educativo</th>
                <th>Acciones</th>
            </tr>
            </thead>

            <tbody>

            </tbody>

        </table>
    </div>



    <br>
    <input type="hidden" id="latitud" name="latitud"/>
    <input type="hidden" id="longitud" name="longitud"/>

</div>

</body>
<br>


<script>


    function cargar(){

        var encuestatemp = {
            id: Number,
            nombre: String,
            sector: String,
            nivel: String,
            latitud: String,
            longitud: String
        };

        var encuestasalmacenadas = JSON.parse(localStorage.getItem('encuestas'));


        for(var i = 0; i < encuestasalmacenadas.length; i++){

            var markup ="<tr><td>"+encuestasalmacenadas[i].id +
                    "</td><td>"+encuestasalmacenadas[i].nombre+"</td><td>"+ encuestasalmacenadas[i].sector + "</td><td>"+encuestasalmacenadas[i].nivel + "</td><td><div class=\"btn-group\" role=\"group\"><button class=\"btn btn-info btn-xs\">Modificar</button><button class=\"btn btn-danger btn-xs\">Eliminar</button></div></td></tr>";

            $("#datoslocal tbody").append(markup);
        }

    }


    function sincronizarConServidor() {

        var encuestas = JSON.parse(localStorage.getItem("encuestas"));
        encuestas = JSON.stringify(encuestas);

        $.ajax({
            type: 'POST',
            dataType: 'json',
            data: {
                encuestas: encuestas
            },
            url: '/registrarse',
            success: function (data) {

            },
            error: function () {
                console.log("Error");
            }
        });
    }

    window.addEventListener("DOMContentLoaded", function() {
        cargar();
    });

</script>
</html>