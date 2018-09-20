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



    <p>Los registros se han realizado desde las siguientes ubicaciones:</p>
    <div id="out" class="container-fluid"></div>
    <br>
    <input type="hidden" id="latitud" name="latitud"/>
    <input type="hidden" id="longitud" name="longitud"/>

</div>

</body>
<br>


<script>
    var map, infoWindow;
    function initMap() {
        map = new google.maps.Map(document.getElementById('out'), {
            center: {la: -34.397, lng: 150.644},
            zoom: 7
        });
        infoWindow = new google.maps.InfoWindow;

        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var pos = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };

                $('input[name=latitud]').val(position.coords.latitude);
                $('input[name=longitud]').val(position.coords.longitude);
                var latitudes = []
                var longitudes = []
                console.log($('input[name=longitud]').val())
              var marker = new google.maps.Marker({
                    position: pos,
                    map: map
                });
                map.setCenter(pos);
            }, function() {
                handleLocationError(true, infoWindow, map.getCenter());
            });
        } else {
            // Browser doesn't support Geolocation
            handleLocationError(false, infoWindow, map.getCenter());
        }
    }

    function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ?
                'Error: The Geolocation service failed.' :
                'Error: Your browser doesn\'t support geolocation.');
        infoWindow.open(map);
    }
</script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAAiRGQv-yrkruO0SLtxrlkCnL008nJUHc&callback=initMap">
</script>

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