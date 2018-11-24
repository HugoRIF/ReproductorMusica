<section class="container py-3 mt-2 mb-2">
     <div class="row mt-2 mb-2 text-white">
        <div class=" col-6 col-sm-6 col-md-6 col-lg-6">
            <h1 class="h1 text-center d-none d-sm-block ">CANCIONES:</h1>
            <h2 class="h2 text-left d-block d-sm-none">CANCIONES:</h2>
            
                  
        </div>
        <div class=" col-4 col-sm-4 col-md-4 col-lg-4">
            <button class="btn color1 btn-lg border border-white  text-white ">Agregar + </button>
        </div>
    </div>
    <div class="row mt-4 mb-4 ">
        <table class="table table-striped text-white text-left" > 
            <thead >
                <tr class=" bg color5">
                    <th scope="col" style="width:20%">Artista</th>
                    <th scope="col" style="width:20% ">Canción</th>
                    <th scope="col" style="width:20% ">Album</th>
                </tr>
            </thead>
            <tbody class=" bg color1 ">

<?php
$Canciones=$Nombre;
$Artistas=$Artista;
$Albunes=$Album;
$idArtistas=$idArtista;
$i=0;
foreach ($Canciones as $array){
    if($i!=0){ 
        
    ?><tr>
       
        <td style="text-align:left" onclick="VER_Artista(<?php echo($idArtistas[$i]) ?>)">
        <?= $Artistas[$i];?></td>
        <td style="text-align:left">
        <?= $Canciones[$i];?></td>
        <td style="text-align:left">
        <?= $Albunes[$i];$i++;?></td>
            
    </tr>
        

<?php
    }else $i++;
        }
        
 ?>
</tbody>
</table>

        
    </div>
</section>
