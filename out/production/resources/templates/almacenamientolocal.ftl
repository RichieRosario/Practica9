
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



    <form method="post" class="container-fluid"  >
        <input type="hidden" id="id" name="id">
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



        <div class="modal-footer">
        <button id="almacenar" type="button" class="btn btn-info btn-xs">Agregar</button>
        <button id="modificar" onclick="modificar2()" type="button" class="btn btn-primary btn-xs disabled">Guardar Cambios</button>
        </div>
            <input type="hidden" id="latitud" name="latitud"/>
        <input type="hidden" id="longitud" name="longitud"/>


    </form>

    <br>

    <div class="table-responsive table-bordered card">


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
    <div class="modal-footer">
    <button id="sincronizar" type="button" onclick="sincronizarConServidor()" class="btn btn-info btn-warning">Sincronizar</button>
    </div>



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

<script>

    function cargar(){
        $('#modificar').prop('disabled', true)
        $('#almacenar').prop('disabled', false)
        var encuestasalmacenadas = JSON.parse(localStorage.getItem('encuestas'));

        var markup = "";
        for(var i = 0; i < encuestasalmacenadas.length; i++){

            markup +="<tr><td>"+encuestasalmacenadas[i].id +
                    "</td><td>"+encuestasalmacenadas[i].nombre+"</td><td>"+ encuestasalmacenadas[i].sector + "</td><td>"+encuestasalmacenadas[i].nivel + "</td><td><div class=\"btn-group\" role=\"group\"><button type=\"button\" onclick=\"modificar("+encuestasalmacenadas[i].id+")\" class=\"btn btn-info btn-xs\">Modificar</button><button type=\"button\" onclick=\"eliminar("+encuestasalmacenadas[i].id+")\" class=\"btn btn-danger btn-xs\">Eliminar</button></div></td></tr>";


        }


        document.getElementById("nombre").value = "";
        document.getElementById("sector").value = "";
        document.getElementById("nivel").selectedIndex = 0;
        document.getElementById("latitud").value = "";
        document.getElementById("longitud").value = "";

        $("#datoslocal tbody").html(markup);

    }

    function eliminar(ideliminar){


        var encuestasalmacenadas = JSON.parse(localStorage.getItem("encuestas"));

        var encuestasfinal = [];

        for(var i = 0; i < encuestasalmacenadas.length; i++){

         if(encuestasalmacenadas[i].id != ideliminar){

             encuestasfinal.push(encuestasalmacenadas[i]);
         }
        }

        localStorage.setItem("encuestas", JSON.stringify(encuestasfinal));

        cargar();
    }


    function modificar(idmodificar){

        var encuestasalmacenadas = JSON.parse(localStorage.getItem("encuestas"));

        $('#almacenar').prop('disabled', true)
        $('#modificar').prop('disabled', false)
        for(var i = 0; i < encuestasalmacenadas.length; i++){

            if(encuestasalmacenadas[i].id == idmodificar){
                document.getElementById("id").value = idmodificar;
                document.getElementById("nombre").value = encuestasalmacenadas[i].nombre;
                document.getElementById("sector").value = encuestasalmacenadas[i].sector;
                document.getElementById("nivel").value = encuestasalmacenadas[i].nivel;
                document.getElementById("latitud").value = encuestasalmacenadas[i].latitud;
                document.getElementById("longitud").value = encuestasalmacenadas[i].longitud;

            }
        }
    }

        function modificar2(){


            var encuestasalmacenadas = JSON.parse(localStorage.getItem('encuestas')) || [];

            var encuesta = {
                id: Number,
                nombre: String,
                sector: String,
                nivel: String,
                latitud: String,
                longitud: String
            };
            var id = document.getElementById("id").value;
            var nombre = document.getElementById("nombre").value;
            var sector = document.getElementById("sector").value;
            var nivel = document.getElementById("nivel").value;
            var latitud = document.getElementById("latitud").value;
            var longitud = document.getElementById("longitud").value;

            encuesta.id = id;
            encuesta.nombre = nombre;
            encuesta.sector = sector;
            encuesta.nivel = nivel;
            encuesta.latitud = latitud;
            encuesta.longitud = longitud;

            for(var i = 0; i < encuestasalmacenadas.length; i++){

                if(encuestasalmacenadas[i].id == encuesta.id){
                    encuestasalmacenadas[i].id = encuesta.id;
                    encuestasalmacenadas[i].nombre = encuesta.nombre;
                    encuestasalmacenadas[i].sector = encuesta.sector;
                    encuestasalmacenadas[i].nivel = encuesta.nivel;
                    encuestasalmacenadas[i].latitud = encuesta.latitud;
                    encuestasalmacenadas[i].longitud = encuesta.longitud;
                   }
            }





            localStorage.setItem("encuestas", JSON.stringify(encuestasalmacenadas));
            cargar();


        }


    $(function() {
        cargar();
    });


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


            cargar();
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
                localStorage.clear();
                cargar();
            },
            error: function () {
                console.log("Error");
            }
        });
    }

</script>
</html>