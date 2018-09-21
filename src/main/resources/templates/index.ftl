
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


<div class="card">
    <div class="table-responsive table-bordered ">


        <table class="table">
            <thead>
            <tr>
                <th>Nombre</th>
                <th>Sector</th>
                <th>Nivel educativo</th>
                </tr>
            </thead>

            <#list encuestas as encuesta>
                <tr>
                <td>${encuesta.getNombre()}</td>
                <td>${encuesta.getSector()}</td>
                <td>${encuesta.getNivel()}</td>




                </tr>
            <#else>
                    <td>No hay datos para mostrar.</td>
                    <td></td>
                <td>
            </#list>

        </table>
    </div>
</div>



    <p>Los registros se han realizado desde las siguientes ubicaciones:</p>
    <div id="out" class="container-fluid" style=""></div>
    <br>
    <input type="hidden" id="latitud" name="latitud"/>
    <input type="hidden" id="longitud" name="longitud"/>

</div>

</body>
<br>


<script>

    var longitudes = []

    var latitudes = []


                <#list ubicaciones as u>
                    longitudes.push(${u.getLongitud()})
                    latitudes.push(${u.getLatitud()})
                </#list>

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
                localizaciones = []



                    localizaciones.push(latitudes,longitudes);
                    console.log(localizaciones);

            for(var i=0; i<localizaciones[0].length;i++) {
                var marker = new google.maps.Marker({
                    position:  new google.maps.LatLng(localizaciones[0][i],localizaciones[1][i]),
                    map: map
                });
                marker.setMap(map);
            }
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
    $(document).ready(function(){
        $('#almacenar').click(function(){

            var id = JSON.parse(localStorage.getItem("id")) || 0;

            var encuestasalmacenadas = JSON.parse(localStorage.getItem('encuestas')) || [];

            var encuesta = {
                id: Number,
                nombre: String,
                sector: String,
                nivel: String,
                latitud: String,
                longitud: String
            };
            id2 = parseInt(id) + 1;
            var nombre = document.getElementById("nombre").value;
            var sector = document.getElementById("sector").value;
            var nivel = document.getElementById("nivel").value;
            var latitud = document.getElementById("latitud").value;
            var longitud = document.getElementById("longitud").value;

            encuesta.id = id2;
            encuesta.nombre = nombre;
            encuesta.sector = sector;
            encuesta.nivel = nivel;
            encuesta.latitud = latitud;
            encuesta.longitud = longitud;

            encuestasalmacenadas.push(encuesta);

            localStorage.setItem("encuestas", JSON.stringify(encuestasalmacenadas));
            localStorage.setItem("id", JSON.stringify(id2));

            document.getElementById("nombre").value = "";
            document.getElementById("sector").value = "";
            document.getElementById("nivel").value = "";
            document.getElementById("latitud").value = "";
            document.getElementById("longitud").value = "";

            sincronizarConServidor();

        });
    });

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
</script>
</html>