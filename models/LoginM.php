<?php if(! defined('BASEPATH')) exit ('No direct script access allowed');

class LoginM extends CI_Model{
	function __construct(){
		parent :: __construct();
		$this->load->database();
	}
	function Checar_Usuario($data){
		
		
		$query = $this->db->query('SELECT idtipousuario 
									FROM `usuario`
									 WHERE nombreusuario ="'.$data['usuario'].'"
									AND contrausuario ="'.$data['contra'].'"');
		$tipoU="";
		if($query->num_rows())
		{
			
			$query2 = $query->result();
			$tipoU = $query2[0]->idtipousuario;
			return $tipoU;
		}else{
			return 0;
		}
		
	}
	function Regresa_idUsuario($data){
		
		
		$query = $this->db->query('SELECT id
									FROM `usuario`
									 WHERE nombreusuario ="'.$data['usuario'].'"
									AND contrausuario ="'.$data['contra'].'"')->result();
		
		$idU = $query[0]->id;
			return $idU;
		
	}
	function InfoCanciones(){
		$query = "SELECT nombreCancion, nombreArtista, nombreAlbum 
					FROM cancion c, artista a, album alb 
					WHERE c.idArtista = a.id AND c.idAlbum = alb.id";
		$info = $this->db->query($query);
		return $info;
	}
	function numeroPlay($userId){
		$query = "SELECT id FROM playlist p WHERE p.idUsuario =".$userId;
		$numPlay = $this->db->query($query);
		if ($numPlay->num_rows()) {
			$aux = count($numPlay->result());
			return $aux;
		}else
			return 0;
	}
	function idsPlay($userId){
		$query = "SELECT id FROM playlist p WHERE p.idUsuario =".$userId;
		$idsPlay = $this->db->query($query);
		return $idsPlay;
	}
	function nombrePlay($playId){
		$query = "SELECT nombrePlaylist FROM playlist p WHERE p.id =".$playId;
		$nombrePlay = $this->db->query($query)->result()[0]->nombrePlaylist;
		return $nombrePlay;
	}
	function idCanciones($playId){
		$query = "SELECT idCancion FROM playlist_cancion pc WHERE pc.idPlaylist =".$playId;
		$ids = $this->db->query($query);
		return $ids;
	}
	function nombreArtista($cancionId){
		$query = "SELECT idArtista FROM cancion c WHERE c.id =".$cancionId;
		$idArt = $this->db->query($query)->result()[0]->idArtista;
		$query2 = "SELECT nombreArtista FROM artista a WHERE a.id =".$idArt;
		$nombreArt = $this->db->query($query2)->result()[0]->nombreArtista;
		return $nombreArt;
	}
	function nombreAlbum($cancionId){
		$query = "SELECT idAlbum FROM cancion c WHERE c.id =".$cancionId;
		$idAlb = $this->db->query($query)->result()[0]->idAlbum;
		$query2 = "SELECT nombreAlbum FROM album a WHERE a.id =".$idAlb;
		$nombreAlb = $this->db->query($query2)->result()[0]->nombreAlbum;
		return $nombreAlb;
	}
	function nombreCancion($cancionId){
		$query = "SELECT nombreCancion FROM cancion c WHERE c.id =".$cancionId;
		$nombreCan = $this->db->query($query)->result()[0]->nombreCancion;
		return $nombreCan;
	}
	function InfoPlay($playId){
		$data['idPlay'] = $playId;
		$data['nombrePlay'] = $this->LoginM->nombrePlay($playId);
		$data['idCanciones'] = $this->LoginM->idCanciones($playId);
		$info = array();
		foreach ($data['idCanciones']->result() as $idCan) {
			$aux['nomCan'] = $this->LoginM->nombreCancion($idCan->idCancion);
			$aux['nomArt'] = $this->LoginM->nombreArtista($idCan->idCancion);
			$aux['nomAlb'] = $this->LoginM->nombreAlbum($idCan->idCancion);
			array_push($info, $aux); 
		}
		$data['infoCanciones'] = $info;
		return $data;
	}
	
}
