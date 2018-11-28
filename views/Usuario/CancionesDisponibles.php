<section class="container py-3 mt-2 mb-2">
        <h3 class="h3 text-uppercase text-center text-white">Canciones Disponibles</h3>
        <p class="lead text-center text-white">Aquí podras ver las canciones disponibles para agregar a tu playlist <?php echo($idpl)?></p>
        
        
        <?= form_open('/Usuario/AgregarC_Pl')?>
        <table class="table py-5 mt-2 mb-1 color2 rounded">
            <thead class="thead-dark rounded">
                <tr>
                    <th scope="col">Nombre:</th>
                    <th scope="col">Artista:</th>
                    <th scope="col">Album:</th>
                    <th scope="col">Agregar</th>
                </tr>
            </thead>
            <tbody>
           
                <?php
                
                    if($infoCanciones){
                        $i=0;

                        foreach ($infoCanciones->result() as $info) { 
                            //if($i!=0){ 
                            ?>
                                <tr>
                                    <td><?= $info->nombreCancion ?></td>
                                    <td><?= $info->nombreArtista ?></td>
                                    <td><?= $info->nombreAlbum ?></td>
                                    <td><?= form_checkbox('Canciones'.$i,$info->nombreCancion);$i++;?></td>
            
                                </tr>
                            <?php
                            /*}
                            else{$i++;}*/
                        }
                    }else
                        echo "<p>Error en la consulta del curso</p>";
                ?>
            </tbody>
        </table>
        <div class="row justify-content-end">
            <?= form_hidden("totalD",$i-1);?>
            <?= form_hidden("idPl",$idpl);?>
            <?= form_submit("","Agregar",'class="btn btn-sm color1 mt-2 mr-3 text-white"');?>
            <?= form_close();?>
        </div>
</section>