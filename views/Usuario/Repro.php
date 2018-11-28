	<?php if ($numPlay == 1) { ?>
        <section class="container py-3 mt-2 mb-2">
            <div class="row ">
                <div class="col-sm-12 col-md-6 text-center">
                    <img src="<?= base_url() ?>img/musica/icono2.svg" width="65%" height="65%" class="mx-auto d-block" alt="Musica">
                    <h1 class="h1 text-center">Tienes una playlist</h1>
                    <audio id="player" controls=""></audio>
                </div>
                <div class="col-sm-12 col-md-6 text-center mt-5">
                    <div class="col-sm-10 col-md-10 mr-auto ml-auto">
                        <ul class="list-group" id="Play1" style="height: 250px; overflow-y: scroll;">
                            <li class="list-group-item color5 text-white"><?= $play1['nombrePlay'] ?></li>
                            <?php $id = 0; 
                            foreach ($play1['infoCanciones'] as $info){ ?>
                                <li class="list-group-item" id="<?= base_url() ?><?= $info['dirCan']; ?>" onClick="play(this)" name="fila"><?= $info['nomCan'] ?></li>
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
                    <img src="<?= base_url() ?>img/musica/icono2.svg" width="65%" height="65%" class="mx-auto d-block" alt="Musica">
                    <h1 class="h1 text-center">Tienes dos playlist</h1>
                    <audio id="player" controls=""></audio>
                </div>
                <div class="col-sm-12 col-md-6 text-center mt-5">
                	<div class="col-sm-10 col-md-10 mr-auto ml-auto">
	                	<ul class="list-group" id="Play1" style="height: 250px; overflow-y: scroll;">
	                		<li class="list-group-item color5 text-white"><?= $play1['nombrePlay'] ?></li>
	                		<?php $id = 0; 
							foreach ($play1['infoCanciones'] as $info){ ?>
								<li class="list-group-item" id="<?= base_url() ?><?= $info['dirCan']; ?>" onClick="play(this)" name="fila"><?= $info['nomCan'] ?></li>
							<?php $id = $id + 1; } ?>
						</ul>
					</div>
                </div>
                <div class="col-sm-10 col-md-10 mr-auto ml-auto">
                        <ul class="list-group" id="Play2" style="height: 250px; overflow-y: scroll;">
                            <li class="list-group-item color5 text-white"><?= $play2['nombrePlay'] ?></li>
                            <?php $id = 0; 
                            foreach ($play2['infoCanciones'] as $info){ ?>
                                <li class="list-group-item" id="<?= base_url() ?><?= $info['dirCan']; ?>" onClick="play(this)" name="fila"><?= $info['nomCan'] ?></li>
                            <?php $id = $id + 1; } ?>
                        </ul>
                    </div>
            </div>
        </section>
    <?php }if($numPlay == 0) { ?>
        <section class="container py-3 mt-2 mb-2">
            <div class="row ">
                <div class="col-sm-12 col-md-12">
                    <img src="<?= base_url() ?>img/musica/icono2.svg" width="65%" height="65%" class="mx-auto d-block" alt="Musica">
                    <h1 class="h1 text-center">No tienes playlist :(</h1>
                </div>
            </div>
        </section>
    <?php } ?>