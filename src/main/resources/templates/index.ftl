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



                <form method="post" class="container-fluid" action="/registrarse"  >
                    <div class="form-group row">
                        <div class="col-md-6">
                            <input type="text" name="nombre" id="nombre" class="form-control" style="width:92.5%" placeholder="Nombre"/>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-6">
                            <input type="text" name="sector" id="sector" class="form-control" style="width:92.5%" placeholder="Sector"/>
                        </div>
                    </div>

                    <div class="form-group row">
                        <div class="col-md-6">
                            <select name="nivel" id="nivel" class="form-control" style="width:92.5%" placeholder="Nivel escolar">
                            <option value="Basico">Básico</option>
                            <option value="Medio">Medio</option>
                            <option value="Grado Universitario">Grado Universitario</option>
                            <option value="Postgrado">Postgrado</option>
                                <option value="Doctorado">Doctorado</option>
                            </select>
                        </div>
                    </div>


                    <div id="out"></div>
                    <input type="hidden" id="latitud" name="latitud"/>
                    <input type="hidden" id="longitud" name="longitud"/>


                    <button id="almacenar" type="button" class="btn btn-info btn-xs">Almacenar</button>


                </form>

</div>
<br>
</body>



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

                console.log($('input[name=longitud]').val())
                var marker = new google.maps.Marker({
                    position: pos,
                    map: map
                });      infoWindow.setPosition(pos);
                infoWindow.setContent('Usted se encuentra aqui.');
                infoWindow.open(map);
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