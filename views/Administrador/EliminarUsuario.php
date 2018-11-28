<section class="container py-3 mt-2 mb-2">
     <div class="row mt-2 mb-2 text-white">
        <div class=" col-12 col-sm-12 col-md-12 col-lg-12">
            <h1 class="h1 text-center d-none d-sm-block ">EIMINAR USUARIO: <?= $nomU?></h1>
            <h2 class="h2 text-left d-block d-sm-none">ELIMINAR USUARIO: <?= $nomU?></h2>
            
                  
        </div>
        <br>  <br>  <br>  <br>  
        <div class="col-12 col-sm-12 col-md-12 ">
                    <section class="container">
                            <form action="<?= base_url() ?>index.php/Administrador/Eliminar_Usuario" method="post">
                                <input type="hidden"  value=<?php echo($UsuarioID) ?> name="idUE">
                   
                                <br>
                                    <center>
                                    <div class="form-group col-6 col-sm-6 col-md-6 col-lg-6 ">
                                    <input type="submit"  class="btn-lg color1 text-white border-white w-60" value=" SI,Eliminar " >
                        
                                    </div>
                                </div>
                                </center>
                           </form>
                           
                                    <div class=" col-12">
                                    <center>
                                        <button class="btn-lg btn-warning  border-white" onclick="Usuarios()">NO,Regresar</button>
                                    </center>
                                    </div>
                                    
                    </section>
                                   
        </div>

    
</section>
<br><br><br><br>
