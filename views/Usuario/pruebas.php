<?php

	echo $idPlay;
	echo $nombrePlay;
	foreach ($idCanciones->result() as $id) {
		echo $id->idCancion;
	}

	//print_r($infoCanciones);

	foreach ($infoCanciones as $info) {
		print($info['nomCan']);
	}

 ?>