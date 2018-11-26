<section class="container-fluid py-3 mt-2 mb-2 mx-2">
	<div class="row mt-1 mb-2 justify-content-md-center">
		<div class="col-6 text-right">
			<h1 class="h1 mr-4">Playlists</h1>
		</div>
		<div class="col-4 text-right">
			<button class="btn btn-sm color1 mt-3 text-white" href="#" onClick="Crear()" id="btAgregarPlay"
			<?php if ($numPlay>=2) {?> disabled <?php } ?> >Agregar</button>
		</div>
	</div>
	<div class="container-fluid row justify-content-md-center">
		<?php if($numPlay == 1) { ?>
			<section class="col-5 text-center rounded color5 my-1 mx-4">
				<div class="row my-1">
					<div class="col-8 text-right my-1">
						<h4 class="h4 my-1 text-white"><?= $play1['nombrePlay'] ?></h4>
					</div>
					<div class="col-4 text-right my-1">
						<button class="btn btn-sm color3 my-1 mx-1 text-white rounded-left">►</button>
						<button class="btn btn-sm color1 my-1 mx-1 text-white rounded-right" onClick="Canciones(<?php echo ($idplay1)?>)">+</button>
						
					</div>
				</div>
				<table class="table mt-2 mb-1 color5 rounded text-white">
					<thead class="thead">
						<tr>
							<th scope="col">Cancion:</th>
							<th scope="col">Artista:</th>
							<th scope="col">Album:</th>
						</tr>
					</thead>
					<tbody>
						<?php foreach ($play1['infoCanciones'] as $info) {?>
							<tr>
		                    	<td><?= $info['nomCan'] ?></td>
		                        <td><?= $info['nomArt'] ?></td>
		                        <td><?= $info['nomAlb'] ?></td>
	                    	</tr>
						<?php	# code...
						}  
						?>
					</tbody>
				</table>
			</section>
		<?php } ?>
		<?php if($numPlay == 2){ ?>
			<section class="col-5 text-center rounded color5 my-1 mx-4">
				<div class="row my-1">
					<div class="col-8 text-right my-1">
						<h4 class="h4 my-1 text-white"><?= $play1['nombrePlay'] ?></h4>
					</div>
					<div class="col-4 text-right my-1">
						<button class="btn btn-sm color3 my-1 mx-1 text-white rounded-left">►</button>
						<button class="btn btn-sm color1 my-1 mx-1 text-white rounded-right" onClick="Canciones(<?php echo ($idplay1)?>)">+</button>
						
				</div>
				<table class="table mt-2 mb-1 color5 rounded text-white">
					<thead class="thead">
						<tr>
							<th scope="col">Cancion:</th>
							<th scope="col">Artista:</th>
							<th scope="col">Album:</th>
						</tr>
					</thead>
					<tbody>
						<?php foreach ($play1['infoCanciones'] as $info) {?>
							<tr>
		                    	<td><?= $info['nomCan'] ?></td>
		                        <td><?= $info['nomArt'] ?></td>
		                        <td><?= $info['nomAlb'] ?></td>
	                    	</tr>
						<?php } ?>
					</tbody>
				</table>
			</section>
			<section class="col-5 text-center rounded color5 my-1 mx-4">
				<div class="row my-1">
					<div class="col-8 text-right my-1">
						<h4 class="h4 my-1 text-white"><?= $play2['nombrePlay'] ?></h4>
					</div>
					<div class="col-4 text-right my-1">
						<button class="btn btn-sm color3 my-1 mx-1 text-white rounded-left">►</button>
						<button class="btn btn-sm color1 my-1 mx-1 text-white rounded-right" onClick="Canciones(<?php echo ($idplay2)?>)">+</button>
						
					</div>
				</div>
				<table class="table mt-2 mb-1 color5 rounded text-white">
					<thead class="thead">
						<tr>
							<th scope="col">Cancion:</th>
							<th scope="col">Artista:</th>
							<th scope="col">Album:</th>
						</tr>
					</thead>
					<tbody>
						<?php foreach ($play2['infoCanciones'] as $info) {?>
							<tr>
		                    	<td><?= $info['nomCan'] ?></td>
		                        <td><?= $info['nomArt'] ?></td>
		                        <td><?= $info['nomAlb'] ?></td>
	                    	</tr>
						<?php } ?>
					</tbody>
				</table>
			</section>
		<?php }if($numPlay == 0) { ?>
			<section class="col-8 text-center rounded my-1 mx-4">
				<h1 class="h1">Aun no tienes playlist :( crea una :)</h1>
			</section>
		<?php } ?>
	</div>
</section>