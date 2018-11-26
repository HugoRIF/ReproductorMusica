<section class="container py-3 mt-2 mb-2">
     <div class="row mt-2 mb-2 text-white">
        <div class=" col-12 col-sm-12 col-md-12 col-lg-12">
            <h1 class="h1 text-center d-none d-sm-block ">AGREGAR CANCION:</h1>
            <h2 class="h2 text-left d-block d-sm-none">AGREGAR CANCION:</h2>
            
                  
        </div>
        <br>  <br>  <br>  <br>  
        <div class="col-12 col-sm-12 col-md-12 ">
                    <section class="container">
                    <?php echo form_open_multipart('Administrador/Subir_Cancion');?>
                                    <div class="form-group row">
                                    <label for="" class="col-4  col-form-label d-none d-sm-block"><h3>Cancion:</h3></label>    
                                    <input type="text" placeholder="Escribe el nombre Cancion" class="form-control col-8 col-sm-8 col-md-4" name="Cancion">
                                    
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-4  col-form-label d-none d-sm-block"><h3>Artista:</h3></label>    
                                    <input type="text" placeholder="Escribe el Artista" class="form-control col-8 col-sm-8 col-md-4" name="Artista">
                                    
                                </div>
                                
                                <div class="form-group row">
                                    <label for="" class="col-4 col-form-label d-none d-sm-block"><h3>Album:</h3></label>
                                    <input type="text" placeholder="Escribe el Album" class="form-control col-8 col-sm-8 col-md-4" name="Album">
                        
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-4 col-form-label d-none d-sm-block"><h3>Genero:</h3></label>
                                    <select name="Genero" class=" custom-select col-8 col-sm-8 col-md-4"  >
                                    <option selected>Selecciona el genero</option>
                                        <?php $Generos=$Genero;
                                            $i=0;
                                            foreach($Generos as $g){ ?>
                                               <option  class=" color1  text-white"><?= $Generos[$i];$i++;?></option>
                                         <?php
                                            }
                                        ?>
                                    </select>
                                </div>
                                <div class="form-group custom-file  row">
                                    
                                    <input type="file" class="custom-file-input " id="customFile" name="userfile">
                                    <label class="custom-file-label col-8 col-form-label " for="customFile">Elije la cancion</label>

                        
                                </div>
                                <br>
                                <br>
                                
                                    <center>
                                    <div class="form-group col-6 col-sm-6 col-md-6 col-lg-6 ">
                                        <input type="submit"  class="btn-lg color1 text-white border-white" value="Agregar">
                        
                                    </div>
                                </div>
                                </center>
                                <?php  echo form_close(); ?>
                           
                                    <div class=" col-12">
                                    <center>
                                        <button class="btn-lg btn-warning  border-white" onclick="Usuarios()">Cancelar</button>
                                    </center>
                                    </div>
                                    
                    </section>
                                   
        </div>

    
</section>
<br><br><br><br>
