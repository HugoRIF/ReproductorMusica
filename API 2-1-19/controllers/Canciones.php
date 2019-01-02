<?php
use Restserver\Libraries\REST_Controller;
defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . 'libraries/REST_Controller.php';
require APPPATH . 'libraries/Format.php';

class Canciones extends REST_Controller {

    function __construct()
    {
        parent::__construct();

        $this->load->database();
        $this->load->model('Canciones_model');
        $this->load->helper('url');

    }

    private function crear_respuesta($codigo, $mensaje, $data){
        $respuesta = array('codigo' => $codigo,
                            'mensaje' => $mensaje,
                            'data' => $data);
        return $respuesta;
    }



/**************************** METODOS GET CANCIONES ***************** */
private function checar_parametros_definidos_get($id,$nombre,$artista,$album,$id_genero,$direccion){
    if($id>0 && isset($nombre) && isset($artista) && isset($album) && isset($id_genero) && isset($direccion)){
    //if(!isset($id) && !isset($nombre) && !isset($artista) && !isset($album) && !isset($id_genero) && !isset($direccion)){
        #estan definidos
        return 1;
    }elseif(!isset($id) && !isset($nombre) && !isset($artista) && !isset($album) && !isset($id_genero)&& !isset($direccion)){
        #no estan definidos
        return 0;
    }
    else{
        #cualquier otro
        return 2;
    }
}
public function canciones_get(){
    $id = $this->get('id');
    $nombre = $this->get('nombre');
    $artista = $this->get('artista');
    $album = $this->get('album');
    $id_genero = $this->get('id_genero');
    $direccion = $this->get('direccion');

    $opcion= $this->checar_parametros_definidos_get($id,$nombre,$artista,$album,$id_genero,$direccion);

    switch ($opcion) {
        case 1:
            # Todos estan definidos
            $respuesta= $this->crear_respuesta(404,"no implementado",[]);
            break;
        case 2:
            # Todos estan definidos
            $respuesta= $this->crear_respuesta(404,"No implementado",[]);
            break;
        
        default:
           # peticion sin parametros
           #Hacemos la consulta
            $canciones = $this->Canciones_model->ver_canciones();
           #checamos si la consulta tuvo exito
            if($canciones != 0){
                #si tuvo exito la consulta, no es 0
                $respuesta = $this->crear_respuesta(200, "canciones encontradas",$canciones);
            }
            else{
                # no tuvo exito el query
                $respuesta= $this->crear_respuesta(404,"error en la consulta",[]);
            }
            break;
    }
    #mandamos la respuesta
    $this->response($respuesta);
}



/***********************************METODOS POST CANCIONES ********************************** */
private function checar_parametros_definidos_post($nombre,$artista,$album,$id_genero,$direccion){
    if(isset($nombre) && isset($artista) && isset($album) && isset($id_genero)&& isset($direccion)){
        # todos estan definidos
        return 1;
    }
    else{
        #no estan definidos
        return 0;
    }
}
private function validar_parametros_post($nombre,$artista,$album,$id_genero,$direccion){
    if(!empty($nombre) && !empty($artista) && !empty($album) && !empty($id_genero) && $id_genero >0 && !empty($direccion)){
        # todos son validos
        return 1;
    }
    else{
        #no son validos
        return 0;
    }
}
public function canciones_post(){
   
    $nombre = $this->post('nombre');
    $artista = $this->post('artista');
    $album = $this->post('album');
    $id_genero = $this->post('id_genero');
    $direccion = $this->post('direccion');

    $opcion= $this->checar_parametros_definidos_post($nombre,$artista,$album,$id_genero,$direccion);

    switch ($opcion) {
        case 1:
            # Todos estan definidos
            #Validamos los parametros
             $parametros_validos=$this->validar_parametros_post($nombre,$artista,$album,$id_genero,$direccion);
             if($parametros_validos==1){
                #parametros validos
                $artista_existe=$this->Canciones_model->artista_existe($artista);
                #checamos el exito del query de artista
                if($artista_existe > 0){
                    #exito query del artista
                    if($artista_existe == 1){
                        #artista existe
                        #vemos si existe el album
                        $album_existe=$this->Canciones_model->album_existe($album);
                        #checamos el exito del query de album
                        if($album_existe >0){
                            #exito query del album
                            if($album_existe == 1 ){
                                #album existe
                                #vemos si existe la cancion
                                $cancion_existe=$this->Canciones_model->cancion_existe($nombre);
                                #checamos el exito del query de cancion
                                if($cancion_existe >0){
                                    #exito del query de cancion
                                    if($cancion_existe == 1){
                                        #cancion existe
                                        $respuesta= $this->crear_respuesta(200,"la cancion ya existe",[]);
                                    }
                                    else{
                                        #cancion no existe
                                        $cancion_nueva=$this->Canciones_model->cancion_nueva($nombre,$artista,$album,$id_genero,$direccion);
                                        #checamos el exito del query insertar cancion
                                        if($cancion_nueva==1){
                                            $respuesta= $this->crear_respuesta(201,"cancion agregada",[]);
                                        }else{
                                            #no se puede agregar cancion
                                            $respuesta= $this->crear_respuesta(400,"no se pudo agregar la cancion",[]);
                                        }
                                    }
                                }
                                else{
                                    #falla del query de cancion
                                    $respuesta= $this->crear_respuesta(404,"error en la consulta de la cancion",[]);
                                }
                       
                            }
                            else{
                                #album no existe
                                #agregamos el album
                                $album_nuevo=$this->Canciones_model->album_nuevo($artista,$album);
                                #checamos el exito del query insert album
                                if($album_nuevo==1){
                                    #exito al agregar album
                                    #agregamos la cancion
                                    $cancion_nueva=$this->Canciones_model->cancion_nueva($nombre,$artista,$album,$id_genero,$direccion);
                                    #checamos el exito del query insertar cancion
                                    if($cancion_nueva==1){
                                        $respuesta= $this->crear_respuesta(201,"cancion y album agregado",[]);
                                    }else{
                                        #no se puede agregar cancion
                                        $respuesta= $this->crear_respuesta(400,"no se pudo agregar la cancion",[]);
                                    }
                                }
                                else{
                                    #no se puede agregar album
                                    $respuesta= $this->crear_respuesta(400,"no se pudo agregarel album y cancion",[]);
                                }
                                        
                            }
                        }
                        else{
                            #falla query del album
                            $respuesta= $this->crear_respuesta(404,"error en la consultad el album",[]);
            
                        }

                    }
                    else{
                        #artista no existe
                        #agregamos el artista
                        $artista_nuevo = $this->Canciones_model->artista_nuevo($artista);
                        #checamos el exito del insert artista
                        if($artista_nuevo==1){
                            #artista agregado
                            #agregamos el album
                            $album_nuevo=$this->Canciones_model->album_nuevo($artista,$album);
                            #checamos el exito del query insert album
                            if($album_nuevo==1){
                                #exito al agregar album
                                #agregamos la cancion
                                $cancion_nueva=$this->Canciones_model->cancion_nueva($nombre,$artista,$album,$id_genero,$direccion);
                                #checamos el exito del query insertar cancion
                                if($cancion_nueva==1){
                                    $respuesta= $this->crear_respuesta(201,"cancion, artista y album agregado",[]);
                                }else{
                                    #no se puede agregar cancion
                                    $respuesta= $this->crear_respuesta(400,"no se pudo agregar la cancion",[]);
                                }
                            }
                            else{
                                #no se puede agregar album
                                $respuesta= $this->crear_respuesta(400,"no se pudo agregar el album y cancion",[]);
                            }
                                    
                        
                        }
                        else{
                            #no se puede agregar el artista
                            $respuesta= $this->crear_respuesta(400,"no se pudo agregar el artista, album y cancion",[]);
                        }
                                
                    }
                }else{
                    #falla query de artista
                    $respuesta= $this->crear_respuesta(404,"error en la consulta del artista",[]);
            
                }
             }
             else{
                $respuesta= $this->crear_respuesta(400,"error en los parametros",[]);
            
             }

            break;
        
        default:
                #peticion sin parametros
                $respuesta= $this->crear_respuesta(404,"No implementado",[]);
            
            break;
    }
    #mandamos la respuesta
    $this->response($respuesta);
}
}