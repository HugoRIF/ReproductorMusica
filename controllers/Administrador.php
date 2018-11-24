<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Administrador extends CI_Controller {
	function __construct(){
		parent::__construct();
		$this->load->helper('form');
		$this->load->helper('url');
		$this->load->model('AdmiM');
		$this->load->library('session');
	}
	public function index(){
		$this->load->view('musica/header');
		$this->load->view('Administrador/inicioAdmin');
    
	}
	public function Canciones(){
	$datos=array(
		'Nombre'=>$this->AdmiM->Mostrar_Canciones(),
		'Artista'=>$this->AdmiM->Mostrar_Artistas(),
		'Album'=>$this->AdmiM->Mostrar_Album(),
		'idArtista'=>$this->AdmiM->Mostrar_idArtistas(),
	);
	$ACancion=$this->load->view('Administrador/AdminCanciones',$datos);
        return $ACancion;
	}
	public function Usuarios(){
	 $Sesionid=$this->session->userdata('id');
	$datos=array(
		'idUsuarios'=>$this->AdmiM->Mostrar_idUsuarios($Sesionid),
		'nomUsuarios'=>$this->AdmiM->Mostrar_nomUsuarios($Sesionid),
	);
	$AUsuario=$this->load->view('Administrador/AdminUsuarios',$datos);
        return $AUsuario;
	}
	public function Artista_Especifico(){
		$ArtistaID=$this->input->get('idArtista');
		$data = array(
			'ArtistaID' => $ArtistaID,
			'Canciones' => $this->AdmiM->Mostrar_Canciones_Artista($ArtistaID),
			'nomArtista' => $this->AdmiM->nomArtista_porID($ArtistaID),
			'AlbunesC' => $this->AdmiM->Mostrar_Album_ArrCancion($ArtistaID),
			
		);
		
	$AUsuario=$this->load->view('Administrador/ArtistaEsp',$data);
		return $AUsuario;
		}
public function EditarU(){
	$=$this->input->get('idArtista');
	$data = array(
		'ArtistaID' => $ArtistaID,
		'Canciones' => $this->AdmiM->Mostrar_Canciones_Artista($ArtistaID),
		'nomArtista' => $this->AdmiM->nomArtista_porID($ArtistaID),
		'AlbunesC' => $this->AdmiM->Mostrar_Album_ArrCancion($ArtistaID),
		
	);
	
	$AUsuario=$this->load->view('Administrador/ArtistaEsp',$data);
	return $AUsuario;
}
}