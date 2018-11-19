<title>Inicio Sesion</title>
  </head>
  

<section class="container-fluid slider d-flex justify-content-center align-items-center">
      <h1 class="display-3 text-white">Proyecto IS</h1>
    </section>
<body>

	<div class="container-fluid bg-info">
        <section class="container py-3 mt-3 mb-3">
            <h3 class="text-uppercase text-center mb-4 text-white">BIENVENIDO</h3>
            <p class="lead text-center mb-4 text-white">Por favor Inicia Sesión</p>
		
			<?= form_open('/LoginC/RecibirDatos','class="form-inline justify-content-center flex-column flex-md-row"') ?>
			<?
				$nombre = array(
				'name' => 'nombre',
				'placeholder' => 'Escribe tu Usuario'
				);
				$contra= array(
				'name' => 'contra',
				'placeholder' => 'Contraseña'
				);
			?>
			<div class="form-group mx-3 my-3">
             <?= form_label('Usuario:','nombre','class="mx-3 d-none d-sm-block text-white" ') ?>
			  <?= form_input($nombre) ?>
			</div>
			<div class="form-group mx-3 my-3">
             <?= form_label('Contraseña: ','contra','class="mx-3 d-none d-sm-block text-white"') ?>
    		 <?= form_password($contra) ?>
			</div>
			<div class="form-group mx-3 my-3">
			<center>
			<?= form_submit("","ingresar",'class="btn btn-primary"')?>
			</center>
			</div>
	
	<?= form_close()?>
	
	</div>
	
	<footer class="container-fluid bg-dark">
        <div class="row text-white py-4 text-white">
            <div class="col-md-5">
                <img src="http://192.168.64.2/ProyectoIS/img/uam-i.png" alt="" width="50px" height="auto" class="float-left mr-3">
                <h4 class="lead">Universidad Aútonoma Metropolitana</h4>
                <footer class="blockquote-footer">Equipo OMEGALab <cite title="Source Title">Bluuweb</cite></footer>
            </div>
           
            
        </div>
    </footer>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="http://192.168.64.2/CodeIgniter/js/bootstrap.js"></script>
  </body>
</html>