<!-- Inicio del navbar -->

<nav class="navbar navbar-expand navbar-dark color1 sticky-top">
        <a class="navbar-brand" href="http://192.168.64.2/RPrueba/index.php/Musica">
            <img src="http://192.168.64.2/RPrueba/img/musica/disco.svg" width="30" height="30" class="d-inline-block align-top" alt="Logo Musica">
            Reproductor
        </a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
        </button>
</nav>

<!--Inicio del formulario-->
<div class="container-fluid color4">
        <section class="container py-3 mt-2 mb-2">

            <div class="row ">
                <div class="col-sm-12 col-md-6">
                    <h1 class="h1 text-center ">Reproductor</h1>
                    <img src="http://192.168.64.2/RPrueba/img/musica/icono2.svg" width="70%" height="70%" class="mx-auto d-block" alt="Musica">
                </div>
                <div class="col-sm-12 col-md-6 align-self-center">
                    <section class="container">
                            <form action="http://192.168.64.2/RPrueba/index.php/Musica/login" method="post">
                                <div class="form-group row">
                                    <label for="" class="col-4 col-form-label d-none d-sm-block">Usuario:</label>    
                                    <input type="text" placeholder="Escribe tu usuario aquí:" class="form-control col-8" name="usuario">
                                    
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-4 col-form-label d-none d-sm-block">Contraseña:</label>
                                    <input type="password" placeholder="Escribe tu contraseña:" class="form-control col-8" name="contra">
                        
                                    </div>
                                <div class="form-group"><center>
                                    <button class="btn color1">Ingresar</button>
                            </center> </div>
                           </form>
                    </section>
                </div>
            </div>
        </section>
    </div>
    <!--Fin del formulario-->

    <!-- Inicio del footer -->

    <footer class="container-fluid color5">
        <div class="row text-white py-4 text-white">
            <div class="col-md-3">
                <img src="http://192.168.64.2/RPrueba/img/musica/disco.svg" alt="" width="50px" height="auto" class="float-left mr-3">
                <h4 class="lead">Escucha tu musica favorita!</h4>
                <footer class="blockquote-footer">Reproductor de musica <cite title="Source Title">*****</cite></footer>
            </div>
            <div class="col-md-3">
            </div>
            <div class="col-md-3">
                <h4 class="lead">Footer</h4>
                <p>Informacion que se ingresara en el footer</p>
            </div>
            <div class="col-md-3">
                <h4 class="lead">Seguir</h4>
                <a href="http://www.facebook.com"><span class="badge badge-primary">Facebook</span></a>
                <a href="http://www.youtube.com"><span class="badge badge-danger">Youtube</span></a>
            </div>
        </div>
    </footer>

    <!-- Fin del footer -->


<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="http://192.168.64.2/RPrueba/js/bootstrap.js"></script>
  </body>
</html>