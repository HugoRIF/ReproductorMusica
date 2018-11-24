<?php if(! defined('BASEPATH')) exit ('No direct script access allowed');

class AdmiM extends CI_Model{
	function __construct(){
		parent :: __construct();
		$this->load->database();
    }
    function Mostrar_Canciones(){
        $result=$this->db->query('SELECT `nombreCancion`
                                  FROM `Cancion`
                                  ORDER BY `id` ')->result();
       $arrayNombreC = array('');
       $i=0;
        foreach ($result as $res) { 
           array_push($arrayNombreC,$result[$i]->nombreCancion);
           $i++;
       }
       return $arrayNombreC ;
       
   }
   function Mostrar_Artistas(){
    $result=$this->db->query('SELECT nombreArtista 
                            FROM Artista a, Cancion c 
                            WHERE c.idArtista = a.id 
                            ORDER BY c.id')->result();
   $arrayNombreA = array('');
   $i=0;
    foreach ($result as $res) { 
       array_push($arrayNombreA,$result[$i]->nombreArtista);
       $i++;
   }
   return $arrayNombreA ;
   
}
function Mostrar_Album(){
    $result=$this->db->query('SELECT nombreAlbum 
                            FROM Album a, Cancion c 
                            WHERE c.idAlbum = a.id 
                            ORDER BY c.id')->result();
   $arrayNombreA = array('');
   $i=0;
    foreach ($result as $res) { 
       array_push($arrayNombreA,$result[$i]->nombreAlbum);
       $i++;
   }
   return $arrayNombreA ;
   
}
function Mostrar_idArtistas(){
    $result=$this->db->query('SELECT a.id
                            FROM Artista a, Cancion c 
                            WHERE c.idArtista = a.id 
                            ORDER BY c.id')->result();
   $arrayidA = array('');
   $i=0;
    foreach ($result as $res) { 
       array_push($arrayidA,$result[$i]->id);
       $i++;
   }
   return $arrayidA ;
   
}
function nomArtista_porID($id){
    $result=$this->db->query('SELECT nombreArtista 
                            FROM Artista  
                            WHERE id ='.$id)->result();
   $NombreA = $result[0]->nombreArtista;
      
   return $NombreA ;
   
}
function Mostrar_Albunes_Artista($id){
    $result=$this->db->query('SELECT nombreAlbum,añoAlbum,numCancAlbum 
                            FROM Album 
                            WHERE idArtista ='.$id)->result();
   $arrayAAlbum = array('');
   $arrayNombreA = array('');
   $arrayNumCA = array('');
   $arrayInfoA = array('');
   $i=0;
    foreach ($result as $res) { 
       array_push($arrayNombreA,$result[$i]->nombreAlbum);
       array_push($arrayAAlbum,$result[$i]->añoAlbum);
       array_push($arrayNumCA,$result[$i]->numCancAlbum);
       
       $i++;
   }
    array_push($arrayInfoA,$arrayNombreA);
    array_push($arrayInfoA,$arrayNumCA);
    array_push($arrayInfoA,$arrayAAlbum);
   
       
   return $arrayInfoA ;
   
}
}