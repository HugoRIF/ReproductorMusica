<!-- Inicio del navbar -->

<nav class="navbar navbar-expand-sm navbar-dark color1 sticky-top" id="nav">
        <a class="navbar-brand text-white">
            <img src="<?= base_url() ?>img/musica/disco.svg" width="30" height="30" class="d-inline-block align-top" alt="Logo Musica">
            Reproductor
        </a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
            <div class="navbar-nav mr-auto ml-auto text-center">
                <a class="nav-item nav-link" href="<?= base_url() ?>index.php/Administrador"  >Inicio</a>
                <a class="nav-item nav-link btn " onClick="Canciones()">Canciones</a>
                <a class="nav-item nav-link btn" onClick="Usuarios()">Usuarios</a>
            </div>
            
        <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
            <div class="navbar-nav mr-auto ml-auto text-center">
            </div>
        <div class="d-flex flex-row justify-content-center">
            <a href="<?= base_url() ?>index.php/Musica/Salir" class="btn btn-outline-warning">Salir</a>
        </div>
        </div>
</nav>

<!--Inicio del Body-->
<div class="container-fluid color4" id="Body">
        <section class="container py-3 mt-2 mb-2" style="height: 75vh">
            <div class="container h-100">
                <div class="d-flex align-items-center justify-content-center h-100">
                    <span class="clearfix"></span>
                    <div class="center-block">
                        <div class="row text-center">
                           <div class="col-sm-12 col-md-12">
                                <h1 class="h1 text-center text-withe ">Administrar:</h1>
                            </div> 
                        </div>
                        <div class="row mt-2 mb-2 text-center">
                            <div class="col">
                                <button class="btn color2 btn-lg border border-dark w-75" onclick="Canciones()">Canciones</button>
                            </div>
                        </div>
                        <div class="row mt-2 mb-2 text-center">
                            <div class="col">
                                <button class="btn color3 btn-lg border border-dark w-75" onclick="Usuarios()">Usuarios</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
</div>
    <!--Fin del body-->

    <!-- Inicio del footer -->

    <footer class="container-fluid color5">
        <div class="row text-white py-4 text-white">
            <div class="col-md-3">
                <img src="<?= base_url() ?>img/musica/disco.svg" alt="" width="50px" height="auto" class="float-left mr-3">
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
    <script src="<?= base_url() ?>js/bootstrap.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script>
    	function Canciones() {
    		$.ajax({
				url: '<?= base_url() ?>index.php/Administrador/Canciones',
				type: 'post',
				data: {},
				success: function (data) {
					$( "#Body" ).html(data);
				}
			});
    	};
        function Usuarios() {
    		$.ajax({
				url: '<?= base_url() ?>index.php/Administrador/Usuarios',
				type: 'post',
				data: {},
				success: function (data) {
					$( "#Body" ).html(data);
				}
			});
    	};
        function VER_Artista(idArt) {
            var id = idArt;
    		$.ajax({
				url: '<?= base_url() ?>index.php/Administrador/Artista_Especifico/?idArtista='+id,
				type: 'GET',
				data: {},
				success: function (data) {
					$( "#Body" ).html(data);
				}
			});
    	};
        function Editar_U(idU) {
            var id = idU;
    		$.ajax({
				url: '<?= base_url() ?>index.php/Administrador/EditarU/?idUsuario='+id,
				type: 'GET',
				data: {},
				success: function (data) {
					$( "#Body" ).html(data);
				}
			});
        };
        function Eliminar_U(idU) {
            var id = idU;
    		$.ajax({
				url: '<?= base_url() ?>index.php/Administrador/EliminarU/?idUsuario='+id,
				type: 'GET',
				data: {},
				success: function (data) {
					$( "#Body" ).html(data);
				}
			});
    	};

        function AgregarUsuario() {
    		$.ajax({
				url: '<?= base_url() ?>index.php/Administrador/AgregarU',
				type: 'post',
				data: {},
				success: function (data) {
					$( "#Body" ).html(data);
				}
			});
        };
        function AgregarCancion() {
    		$.ajax({
				url: '<?= base_url() ?>index.php/Administrador/AgregarC',
				type: 'post',
				data: {},
				success: function (data) {
					$( "#Body" ).html(data);
				}
			});
    	};
    </script>
  </body>
</html>