<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Usuario extends CI_Controller {
	function __construct(){
		parent::__construct();
		$this->load->helper('url');
		$this->load->model('LoginM');
		$this->load->library('session');
	}
	public function index(){
		$this->load->view('musica/header');
		$this->load->view('Usuario/inicioUsuario');
    
	}
	public function PlayList(){
		$idUser = $this->session->userdata('id');
		$aux = $this->LoginM->numeroPlay($idUser);
		$idsPlay = $this->LoginM->idsPlay($idUser);
		if ($idsPlay->num_rows() == 1) {
			$play1 = $idsPlay->result()[0]->id;
			$data['play1'] = $this->LoginM->InfoPlay($play1);
		}if ($idsPlay->num_rows() == 2){
			$play1 = $idsPlay->result()[0]->id;
			$play2 = $idsPlay->result()[1]->id;
			$data['play1'] = $this->LoginM->InfoPlay($play1);
			$data['play2'] = $this->LoginM->InfoPlay($play2);
		}
		
		$data['numPlay'] = $aux;
		$PL = $this->load->view('Usuario/PlayList', $data);
        return $PL;
	}
	public function Reproductor(){
		$idUser = $this->session->userdata('id');
		$aux = $this->LoginM->numeroPlay($idUser);
		$idsPlay = $this->LoginM->idsPlay($idUser);
		if ($idsPlay->num_rows() == 1) {
			$play1 = $idsPlay->result()[0]->id;
			$data['play1'] = $this->LoginM->InfoPlay($play1);
		}if ($idsPlay->num_rows() == 2){
			$play1 = $idsPlay->result()[0]->id;
			$play2 = $idsPlay->result()[1]->id;
			$data['play1'] = $this->LoginM->InfoPlay($play1);
			$data['play2'] = $this->LoginM->InfoPlay($play2);
		}
		
		$data['numPlay'] = $aux;
		$data['usuario'] = $this->LoginM->nombreUsuario($idUser);
		$this->load->view('musica/header');
		$this->load->view('Usuario/inicioUsuario',$data);
		//$RP = $this->load->view('Usuario/inicioUsuario', $data);
		//return $RP;
	}
	public function CrearPlaylist(){
		$CP = $this->load->view('Usuario/CrearPlay');
		return $CP;
	}
	public function CancionesDisp(){
		$data['infoCanciones'] = $this->LoginM->InfoCanciones();
		$CD = $this->load->view('Usuario/CancionesDisponibles', $data);
		return $CD;
	}
	public function verPlay(){
		$idUser = $this->session->userdata('id');
		$idsPlay = $this->LoginM->idsPlay($idUser);
		if ($idsPlay->num_rows() < 2) {
			$play1 = $idsPlay->result()[0]->id;
		}else{
			$play1 = $idsPlay->result()[0]->id;
			$play2 = $idsPlay->result()[1]->id;
		}

		$data = $this->LoginM->InfoPlay($play1);
		$this->load->view('Usuario/pruebas', $data);
	}
	public function insertarPlay(){
		$obt = array(
				'nombrePlay' => $this->input->post('nombrePlay'),
			);
		$idUser = $this->session->userdata('id');
		if ($obt['nombrePlay']=="") {
			echo '<script>alert("Ingresa un nombre a la playlist");</script>';
		}else{
			$r = $this->LoginM->insertPlay($obt['nombrePlay'], $idUser);
			if($r == 1)
				echo '<script>alert("Exito al crear playlist");</script>';
			else
				echo '<script>alert("Error al crear la playlist");</script>';
		}
		$aux = $this->LoginM->numeroPlay($idUser);
		$idsPlay = $this->LoginM->idsPlay($idUser);
		if ($idsPlay->num_rows() == 1) {
			$play1 = $idsPlay->result()[0]->id;
			$data['play1'] = $this->LoginM->InfoPlay($play1); 
		}if ($idsPlay->num_rows() == 2){
			$play1 = $idsPlay->result()[0]->id;
			$play2 = $idsPlay->result()[1]->id;
			$data['play1'] = $this->LoginM->InfoPlay($play1);
			$data['play2'] = $this->LoginM->InfoPlay($play2);
		}
			
		$data['numPlay'] = $aux;
		$data['usuario'] = $this->LoginM->nombreUsuario($idUser);
		$this->load->view('musica/header');
		$this->load->view('Usuario/inicioUsuarioAct',$data);

	}
}