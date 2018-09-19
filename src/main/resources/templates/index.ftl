<html>
<#include "layout.ftl">


<br>
<body class="bg-light">
<div class="container" >



                <form method="post" class="container-fluid" action="/registrarse" style="margin-top:-25%;" >
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




                    <button type="submit" class="btn btn-info btn-xs">Almacenar</button>


                </form>

</div>
<br>
</body>
</html>