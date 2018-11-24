<section class="container py-3 mt-2 mb-2">
     <div class="row mt-2 mb-2 text-white">
        <div class="col-sm-6 col-md-6">
            <h1 class="h1 text-center d-none d-sm-block "><?= $nomArtista ?></h1>
            <h2 class="h2 text-center d-block d-sm-none"><?= $nomArtista ?></h2>
                  
        </div>
        
    </div>
    <div class="row mt-4 mb-4 ">
        <table class="table table-striped text-white text-left" > 
            <thead >
                <tr class=" bg color5">
                    <th scope="col" style="width:20%">Cancion</th>
                    <th scope="col" style="width:20% ">Album</th>
                   
                </tr>
            </thead>
            <tbody class=" bg color1 ">

<?php
$CancionesA=$Canciones;
$Album=$AlbunesC;

$i=0;
foreach ($CancionesA as $array){
    if($i!=0){ 
        
    ?><tr>
       
        <td style="text-align:left" >
        <?= $CancionesA[$i];?></td>
        <td style="text-align:left">
        <?= $Album[$i];$i++;?></td>
            
    </tr>
        

<?php
    }else $i++;
        }
        
 ?>
</tbody>
</table>

        
    </div>
    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</section>
