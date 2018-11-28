<?php if(! defined('BASEPATH')) exit ('No direct script access allowed');

class LoginM extends CI_Model{
	function __construct(){
		parent :: __construct();
		$this->load->database();
	}
	function Checar_Usuario($data){
		
		
		$query = $this->db->query('SELECT idTipoUsuario 
		FROM `Usuario`
		 WHERE nombreUsuario ="'.$data['usuario'].'"
		AND contraUsuario ="'.$data['contra'].'"');
		$tipoU="";
		if($query->num_rows())
		{
			
			$query2 = $query->result();
			$tipoU = $query2[0]->idTipoUsuario;
			return $tipoU;
		}else{
			return 0;
		}
		
	}
	function Regresa_idUsuario($data){
		
		
		$query = $this->db->query('SELECT id
		FROM `Usuario`
		 WHERE nombreUsuario ="'.$data['usuario'].'"
		AND contraUsuario ="'.$data['contra'].'"')->result();
		
		$idU = $query[0]->id;
			return $idU;
		
	}
	function nombreUsuario($userId){
		$query = "SELECT nombreUsuario FROM Usuario u WHERE u.id=".$userId;
		$nombUsu = $this->db->query($query)->result()[0]->nombreUsuario;
		return $nombUsu;
	}
	function InfoCanciones(){
		$query = "SELECT nombreCancion, nombreArtista, nombreAlbum 
					FROM Cancion c, Artista a, Album alb 
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
		$query = "SELECT idCancion FROM Playlist_Cancion pc WHERE pc.idPlaylist =".$playId;
		$ids = $this->db->query($query);
		return $ids;
	}
	function nombreArtista($cancionId){
		$query = "SELECT idArtista FROM Cancion c WHERE c.id =".$cancionId;
		$idArt = $this->db->query($query)->result()[0]->idArtista;
		$query2 = "SELECT nombreArtista FROM Artista a WHERE a.id =".$idArt;
		$nombreArt = $this->db->query($query2)->result()[0]->nombreArtista;
		return $nombreArt;
	}
	function nombreAlbum($cancionId){
		$query = "SELECT idAlbum FROM Cancion c WHERE c.id =".$cancionId;
		$idAlb = $this->db->query($query)->result()[0]->idAlbum;
		$query2 = "SELECT nombreAlbum FROM Album a WHERE a.id =".$idAlb;
		$nombreAlb = $this->db->query($query2)->result()[0]->nombreAlbum;
		return $nombreAlb;
	}
	function nombreCancion($cancionId){
		$query = "SELECT nombreCancion FROM Cancion c WHERE c.id =".$cancionId;
		$nombreCan = $this->db->query($query)->result()[0]->nombreCancion;
		return $nombreCan;
	}
	function direcccionCancion($cancionId){
		$query = "SELECT direccionCancion FROM Cancion c WHERE c.id =".$cancionId;
		$dirCancion = $this->db->query($query)->result()[0]->direccionCancion;
		return $dirCancion;
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
			$aux['dirCan'] = $this->LoginM->direcccionCancion($idCan->idCancion);
			array_push($info, $aux); 
		}
		$data['infoCanciones'] = $info;
		return $data;
	}
	function insertPlay($playNom, $userId){
		$query = "INSERT INTO Playlist (nombrePlaylist,numCancPlaylist,idUsuario) 
      				VALUES ('$playNom',1,'$userId')";
      	$res = $this->db->query($query);
      	if($res == 1)
      		return 1;
      	else
      		return 0;
	}
	function Guardar_Canciones_en_PlayList($arreglo){
        /*el Arreglo de paramtero tiene dos elementos, el primero es el id de la play list
        el segudo es un arreglo con todas las canciones seleccionadas por el usuario  
         */
       $idPl=$arreglo['idpl'];
       $Canciones=$arreglo['Canciones'];
       #En un for recorremos el arreglo de canciones y las insertamos en la tabla
       $i=0;
       foreach ($Canciones as $respuesta) {
           $insert_CP=$this->db->query('INSERT INTO Playlist_Cancion(idPlaylist, idCancion)
                                         VALUES ('.$idPl.',(
                                                SELECT id
                                                FROM Cancion
                                                WHERE nombreCancion="'.$Canciones[$i].'"
                                            
                                         ))');
            $i++;
       }
       
   }
}