<html>
<#include "layout.ftl">

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




                    <button id="almacenar" type="submit" class="btn btn-info btn-xs">Almacenar</button>


                </form>

</div>
<br>
</body>

<script>
    $(document).ready(function(){
        $('#almacenar').click(function(){
            var nombre = document.getElementById("nombre").value;
            var sector = document.getElementById("sector").value;
            var nivel = document.getElementById("nivel").value;

            localStorage.setItem("Nombre", nombre);
            localStorage.setItem("Sector", sector);
            localStorage.setItem("Nivel", nivel);

            navigator.geolocation.getCurrentPosition(function (position) {
                localStorage.setItem("latitude", position.coords.latitude);
                localStorage.setItem("longitude", position.coords.longitude);
            }, function (error) { console.log(error) })

            document.getElementById("nombre").value = "";
            document.getElementById("sector").value = "";
            document.getElementById("nivel").value = "";

        });
    });
</script>

</html>