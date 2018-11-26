<!-- Inicio del navbar -->

<nav class="navbar navbar-expand navbar-dark color1 sticky-top">
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
            <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle btn btn-outline-warning" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Menú
                    </a>
                    <div class="dropdown-menu color3" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item disabled"><?= $usuario ?></a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#" onClick="PlayList()" id="lbPlay">Playlist</a>
                    </div>
            </div>
            <div class="navbar-nav mr-auto ml-auto text-center">
                <a class="navbar-brand text-warning" href="http://localhost/test/index.php/Usuario/Reproductor" onClick="Repro()">
                    <h3>Reproductor</h3>
                </a>
            </div>
            <div class="d-flex flex-row justify-content-center">
                <a href="http://localhost/test/index.php/Musica/Salir" class="btn btn-outline-warning" id="idSalir">Salir</a>
            </div>
        </div>
</nav>

<!--Inicio del Cuerpo-->
<div class="container-fluid color4" id="Body">
    <?php if ($numPlay == 1) { ?>
        <section class="container py-3 mt-2 mb-2">
            <div class="row ">
                <div class="col-sm-12 col-md-6 text-center">
                    <img src="http://localhost/test/img/musica/icono2.svg" width="65%" height="65%" class="mx-auto d-block" alt="Musica">
                    <h1 class="h1 text-center">Tienes una playlist</h1>
                    <audio id="player" controls=""></audio>
                </div>
                <div class="col-sm-12 col-md-6 text-center mt-4">
                    <div class="col-sm-10 col-md-10 mr-auto ml-auto">
                        <ul class="list-group" id="Play1" style="height: 250px; overflow-y: scroll;">
                            <li class="list-group-item color5 text-white"><?= $play1['nombrePlay'] ?></li>
                            <?php $id = 0; 
                            foreach ($play1['infoCanciones'] as $info){ ?>
                                <li class="list-group-item" id="<?php echo $info['dirCan']; ?>" onClick="play(this)" name="fila"><?= $info['nomCan'] ?><?= $id ?></li>
                            <?php $id = $id + 1; } ?>
                        </ul>
                    </div>
                </div>
            </div>
        </section>
    <?php } if($numPlay == 2) { ?>
        <section class="container py-3 mt-2 mb-2">
            <div class="row ">
                <div class="col-sm-12 col-md-6 text-center">
                    <img src="http://localhost/test/img/musica/icono2.svg" width="65%" height="65%" class="mx-auto d-block" alt="Musica">
                    <h1 class="h1 text-center">Tienes dos playlist</h1>
                    <audio id="player" controls=""></audio>
                </div>
                <div class="col-sm-12 col-md-6 text-center mt-4">
                    <div class="col-sm-10 col-md-10 mr-auto ml-auto">
                        <ul class="list-group" id="Play1" style="height: 250px; overflow-y: scroll;">
                            <li class="list-group-item color5 text-white"><?= $play1['nombrePlay'] ?></li>
                            <?php $id = 0; 
                            foreach ($play1['infoCanciones'] as $info){ ?>
                                <li class="list-group-item" id="<?php echo $info['dirCan']; ?>" onClick="play(this)" name="fila"><?= $info['nomCan'] ?><?= $id ?></li>
                            <?php $id = $id + 1; } ?>
                        </ul>
                    </div>
                    <div class="col-sm-10 col-md-10 mr-auto ml-auto">
                        <ul class="list-group" id="Play2" style="height: 250px; overflow-y: scroll;">
                            <li class="list-group-item color5 text-white"><?= $play2['nombrePlay'] ?></li>
                            <?php $id = 0; 
                            foreach ($play2['infoCanciones'] as $info){ ?>
                                <li class="list-group-item" id="<?php echo $info['dirCan']; ?>" onClick="play(this)" name="fila"><?= $info['nomCan'] ?><?= $id ?></li>
                            <?php $id = $id + 1; } ?>
                        </ul>
                    </div>
                </div>

            </div>
        </section>
    <?php }if($numPlay == 0) { ?>
        <section class="container py-3 mt-2 mb-2">
            <div class="row ">
                <div class="col-sm-12 col-md-12">
                    <img src="http://localhost/test/img/musica/icono2.svg" width="55%" height="55%" class="mx-auto d-block" alt="Musica">
                    <h1 class="h1 text-center">No tienes playlist :(</h1>
                </div>
            </div>
        </section>
    <?php } ?>
</div>
<!--Fin del Cuerpo-->

    <!-- Inicio del footer -->

    <footer class="container-fluid color5">
        <div class="row text-white py-4 text-white">
            <div class="col-md-3">
                <img src="http://localhost/test/img/musica/disco.svg" alt="" width="50px" height="auto" class="float-left mr-3">
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
    <script src="http://localhost/test/js/bootstrap.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script>
    	function PlayList() {
    		$.ajax({
				url: 'http://localhost/test/index.php/Usuario/Playlist',
				type: 'post',
				data: {},
				success: function (data) {
					$( "#Body" ).html(data);
                    $("#lbPlay").addClass("active");
                    //$("#btAgregarPlay").attr("disabled", true);
				}
			});
    	};
        function Repro() {
            $.ajax({
                url: 'http://localhost/test/index.php/Usuario/Reproductor',
                type: 'post',
                data: {},
                success: function (data) {
                    //$( "#Body" ).html(data);
                    $("#lbPlay").removeClass("active");
                }
            });
        };
        function Crear() {
            $.ajax({
                url: 'http://localhost/test/index.php/Usuario/CrearPlaylist',
                type: 'post',
                data: {},
                success: function (data) {
                    $( "#Body" ).html(data);
                }
            });
        };
        function Canciones($idPL) {
            $.ajax({
                url: 'http://localhost/test/index.php/Usuario/CancionesDisp/?idPL='+$idPL,
                type: 'GET',
                data: {},
                success: function (data) {
                    $( "#Body" ).html(data);
                }
            });
        };
        var dirPlay1 = [];
        var dirPlay2 = [];
        var i = 0;
        var audio = document.getElementById('player');
        <?php if($numPlay == 2){
                foreach ($play1['infoCanciones'] as $info){ ?>
                    dirPlay1[i] = "<?php echo $info['dirCan']; ?>";
                    i = i+1;
        <?php   } 
            } if ($numPlay == 1){ 
                foreach ($play1['infoCanciones'] as $info){ ?>
                    dirPlay1[i] = "<?php echo $info['dirCan']; ?>";
                    i = i+1;
            <?php } 
            } ?>
        //console.log(dirPlay1);
        function play(elemento){
            var selected = elemento.id;
            console.log(selected);
            playCancion(selected);
        };
        function playCancion(src){
            console.log(src);
            $('#player').attr('src', src);
            var playPromise = audio.play();
        };
    </script>  
</body>
</html>