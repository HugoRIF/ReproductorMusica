<section class="container py-3 mt-2 mb-2">
     <div class="row mt-2 mb-2 text-white">
        <div class=" col-6 col-sm-6 col-md-6 col-lg-6">
            <h1 class="h1 text-center d-none d-sm-block ">USUARIOS:</h1>
            <h2 class="h2 text-left d-block d-sm-none">USUARIOS:</h2>
            
                  
        </div>
        <div class=" col-4 col-sm-4 col-md-4 col-lg-4">
            <button class="btn color1 btn-lg  border-white  text-white " onclick="AgregarUsuario()">Agregar + </button>
        </div>
    </div>
    <div class="row mt-4 mb-4 ">
        <table class="table table-striped text-white text-left" > 
            <thead >
                <tr class=" bg color5">
                    <th scope="col" style="width:2%">id</th>
                    <th scope="col" style="width:5% ">Nombre</th>
                    <th scope="col" style="width:5% ">Editar</th>
                    <th scope="col" style="width:5% ">Eliminar</th>
                </tr>
            </thead>
            <tbody class=" bg color1 ">

<?php
$idU=$idUsuarios;
$nomU=$nomUsuarios;
$i=0;
foreach ($idU as $array){
    if($i!=0){ 
        
    ?><tr>
       <td style="text-align:left">
        <?= $idU[$i];?></td>
        <td style="text-align:left">
        <?= $nomU[$i];?></td>
        <td style="text-align:left" >
        <a class=" nav-link " href="#" >
            <img src="http://192.168.64.2/RPrueba/img/musica/Editar.png"
             width="40" height="40" class="d-inline-block align-center" 
             onClick="Editar_U(<?php echo($idU[$i]) ?>)">
           
        </a></td>
        <td style="text-align:left">
        <a class=" nav-link " href="#" >
            <img src="http://192.168.64.2/RPrueba/img/musica/eliminar.png"
             width="40" height="40" class="d-inline-block align-center" 
             onClick="Eliminar_U(<?php echo($idU[$i]) ?>)">
           
        </a><?php $i++; ?></td>
            
    </tr>
        

<?php
    }else $i++;
        }
        
 ?>
</tbody>
</table>

        
    </div>
</section>
