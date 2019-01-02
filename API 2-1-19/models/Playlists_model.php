<?php if(! defined('BASEPATH')) exit ('No direct script access allowed');

class Playlists_model extends CI_Model{
	function __construct(){
		parent :: __construct();
		$this->load->database();
	}

    private function validar_select($query){
        if($query->conn_id->sqlstate == "00000"){
            return 1;
            #es 1 cuando el query se realizo con exito, codigo 00000
        }
        else{
            return 0;
            #es 0 cuando el query falla
        }
    }
    private function validar_insert($query){
        if ($query == TRUE) {
            return 1;
            #es 1 cuando el query se realizo con exito
        }else{
            return 0;
            #es 0 cuando el query falla
        }
    }

    public function numero_playlists($id_usuario){
        $numero_playlists = $this->db->query("SELECT COUNT(id) AS 'numero_playlists' FROM playlists WHERE id_usuario =".$id_usuario);
        if ($this->validar_select($numero_playlists)==1) {
            return $numero_playlists->result_array()[0];
            #el query fue exitoso y regresa el resultado del query
        }else{
            return 0;
            #el query fallo
        }
    }
    public function crear_playlist($id_usuario, $nombre_playlist){
        $playlist = $this->db->query("INSERT INTO playlists (nombre, numero_de_canciones, id_usuario) VALUES ('$nombre_playlist', 0, '$id_usuario')");
        if ($this->validar_insert($playlist)==1) {
            $id_playlist = $this->db->insert_id();
            return $id_playlist;
            #el query fue exitoso y regresa el id de la playlist creada
        }else{
            return 0;
            #el query fallo
        }
    }
    public function agregar_cancion($id_playlist, $id_cancion){
        //$aux=0;
        $this->db->trans_start();
        foreach ($id_cancion as  $id) {
            $cancion = $this->db->query("INSERT INTO playlist_con_canciones (id_playlist,id_cancion) VALUES ('$id_playlist','$id')");
            /*if ($this->validar_insert($cancion)==1) {
                $aux = $aux + 1;
            }else{
                $valido = 0;
            }*/
        }
        $this->db->trans_complete();
        /*if ($aux == count($id_cancion)) {
            $valido = 1;
        }*/
        if ($this->db->trans_status() === FALSE) {
            # code...
            $this->db->trans_rollback();
            return 0;
        }else{
            $this->db->trans_commit();
            return 1;
        }
        //return $valido;
    }
}