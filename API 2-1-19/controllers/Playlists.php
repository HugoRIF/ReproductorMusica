<?php
use Restserver\Libraries\REST_Controller;
defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . 'libraries/REST_Controller.php';
require APPPATH . 'libraries/Format.php';

class Playlists extends REST_Controller {

    function __construct()
    {
        parent::__construct();

        $this->load->database();
        $this->load->model('Playlists_model');
        $this->load->helper('url');

    }

    private function crear_respuesta($codigo, $mensaje, $data){
        $respuesta = array('codigo' => $codigo,
                            'mensaje' => $mensaje,
                            'data' => $data);
        return $respuesta;
    }
    private function checar_parametros_definidos_post($id_usuario, $nombre_playlist, $id_playlist, $id_cancion){
        if (isset($id_usuario, $nombre_playlist) && $id_playlist==NULL && $id_cancion==NULL) {
            return 1;
            #es 1 cuando solo id_usuario y nombre_playlist estan definidos
        }elseif (isset($id_playlist, $id_cancion) && $id_usuario==NULL && $nombre_playlist==NULL) {
            return 2;
            #es 2 cuando solo id_playlist y id_cancion estan definidos
        }else{
            return 0;
            #es 0 cuando no cumple los anteriores
        }

    }
    private function validar_parametros_post($id_usuario, $nombre_playlist, $id_playlist, $id_cancion){
        if (!empty($nombre_playlist) && !empty($id_usuario) && $id_usuario>0 && $id_playlist==NULL && $id_cancion==NULL) {
            return 1;
            #es 1 cuando no son vacios y id_usuario es >0
        }elseif (!empty($id_playlist) && $id_playlist>0 && !empty($id_cancion) && $id_usuario==NULL && $nombre_playlist==NULL) {
            $aux=0;
            foreach ($id_cancion as  $id) {
                if ($id > 0) {
                    $aux = $aux + 1;
                }else{
                    $valido = 0;
                    #es 0 cuando id no es >0
                    break;
                }
            }
            if (count($id_cancion) == $aux) {
                $valido = 1;
                #es 1 cuando no son vacios y id_playlist e id_cancion son >0
            }
            return $valido;
        }else{
            return 0;
            #es 0 cuando los parametros no son validos
        }
    }

    public function playlists_post(){
        $id_usuario = $this->post('id_usuario');
        $nombre_playlist = $this->post('nombre_playlist');
        $id_playlist = $this->post('id_playlist');
        $id_cancion = $this->post('id_cancion');
        $opcion = $this->checar_parametros_definidos_post($id_usuario, $nombre_playlist, $id_playlist, $id_cancion);

        switch ($opcion) {
            case 1:
                if($this->validar_parametros_post($id_usuario,$nombre_playlist,NULL,NULL)==1){
                    $numero_playlists = $this->Playlists_model->numero_playlists($id_usuario);
                    if ($numero_playlists != 0) {
                        # el query es exitoso
                        if ($numero_playlists['numero_playlists']<2) {
                            # tiene menos de dos playlists
                            $id = $this->Playlists_model->crear_playlist($id_usuario, $nombre_playlist);
                            if ($id != 0) {
                                #query exitoso
                                $playlist_creada= array('id'=>$id,'nombre'=>$nombre_playlist);
                                $respuesta = $this->crear_respuesta(201, 'playlist creada', $playlist_creada);
                            }else{
                                #query fallo
                                $respuesta = $this->crear_respuesta(202, 'error al crear la playlist', []);
                            }
                        }else{
                            #tiene 2 playlists
                            $respuesta = $this->crear_respuesta(200, "no puedes crear mas playlists", []);
                        }
                    }else{
                        #query fallo
                        $respuesta = $this->crear_respuesta(404, 'error en la consulta del numero de playlists', []);
                    }
                }else{
                    #los parametros no son validos
                    $respuesta = $this->crear_respuesta(400, 'error en los parametros', []);
                }
                break;

            case 2:
                if($this->validar_parametros_post(NULL,NULL,$id_playlist,$id_cancion)==1){
                    $cancion = $this->Playlists_model->agregar_cancion($id_playlist, $id_cancion);
                    if ($cancion != 0) {
                        $cancion_agregada = array('id_playlist'=>$id_playlist,'id_cancion'=>$id_cancion);
                        $respuesta = $this->crear_respuesta(201,'cancion(es) agregada(s) con exito',$cancion_agregada);
                        # query exitoso
                    }else{
                        #query fallo
                        $respuesta = $this->crear_respuesta(202,'error al agregar la(s) cancion(es)',[]);
                    }
                }else{
                    #los parametros no son validos
                    $respuesta = $this->crear_respuesta(400, 'error en los parametros', []);
                }
                break;
            
            default:
                //$prueba = $this->Playlists_model->numero_playlists(50);
                $respuesta = $this->crear_respuesta(400, 'no implementado', []);
                break;
        }
        $this->response($respuesta);
    }
}

