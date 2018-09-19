<html>
 <head>
        <title>Una Red Social</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> </head>
    <body>


    <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" style="color:white">2do Parcial</a>
            </div>

            <ul class="nav navbar-nav " style="text-decoration:none">
                <form method="post"  action="/login"">
                <div class="form-inline">
                <li ><input type="text" name="userpost" id="userpost" class="form-control" style="width:92.5%" placeholder="Nombre de Usuario"/></li>
                <li><input type="password" name="passpost" id="passpost" class="form-control" style="width:92.5%" placeholder="Contraseña"/></li>
                    <button type="submit" class="btn btn-info btn-xs">Iniciar Sesión</button>

                </div>
                   </form>
            </ul>
        </div>
    </nav>
    </body>



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




                    <button type="submit" class="btn btn-info btn-xs">Almacenar</button>


                </form>

</div>
<br>
</body>
</html>