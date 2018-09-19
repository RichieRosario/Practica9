<html>
    <head>
        <title>Una Red Social</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script></head>
    <body>


    <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" style="color:white">Práctica #9</a>
            </div>
            <ul class="nav navbar-nav" style="text-decoration:none">
                <li class="navbar-item"><a href="/" class="nav-link"  >Inicio</a></li>
                <li class="navbar-item"><a href="/friends" class="nav-link">Amigos</a></li>
                <li class="navbar-item"><a href="/profile/${usuario.getUsername()}" class="nav-link"  >Perfil</a></li>
                <li class="navbar-item"><a href="/logout" class="nav-link">Cerrar Sesión</a></li>
            </ul>

        </div>
    </nav>
    </body>


    <footer class="main-footer bg-dark text-white" style="position:fixed;height:32px;width:100%;bottom:0;z-index:9;">

            <p>Una Red Social - Ricardo y Emilio &copy; 2018 </p>

    </footer>
</html>