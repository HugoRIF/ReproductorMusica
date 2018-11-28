<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Usuario extends CI_Controller {
	function __construct(){
		parent::__construct();
		$this->load->helper('url');
		$this->load->helper('form');
		$this->load->model('LoginM');
		$this->load->library('session');
	}
	public function index(){
		$this->load->view('musica/header');
		$this->load->view('Usuario/inicioUsuario');
    
	}
	public function Playlist(){
		$idUser = $this->session->userdata('id');
		$aux = $this->LoginM->numeroPlay($idUser);
		$idsPlay = $this->LoginM->idsPlay($idUser);
		if ($idsPlay->num_rows() == 1) {
			$play1 = $idsPlay->result()[0]->id;
			$data['idplay1']=$play1;
			$data['play1'] = $this->LoginM->InfoPlay($play1);
		}if ($idsPlay->num_rows() == 2){
			$play1 = $idsPlay->result()[0]->id;
			$play2 = $idsPlay->result()[1]->id;
			$data['idplay1']=$play1;
			$data['idplay2']=$play2;
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
		$data['idpl']=$this->input->get('idPL');
		
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
	public function AgregarC_Pl(){
		$idPL=$this->input->post('idPl');
		$total=$this->input->post('totalD');
		$Canciones_Agregar=array();
		for ($i=1; $i <= $total ; $i++) { 
			$datos=$this->input->post('Canciones'.$i);
			if($datos!=""){
				 array_push($Canciones_Agregar,$datos);
			}
			
		}
		$datos=array(
			'idpl'=>$idPL,
			'Canciones'=>$Canciones_Agregar
		);
		$Agrego_Canciones=$this->LoginM->Guardar_Canciones_en_PlayList($datos);
		echo '<script>alert("Canciones Agregadas");</script>';

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
		/*
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
		$this->load->view('Usuario/inicioUsuario',$data);*/
	}


	/*public function insCancion(){
		//print_r($this->input->post('idP'));
		$idPlay = $this->input->get('idP');
		$nombreCancion = $this->input->get('nomCan');
		settype($idPlay, "integer");
		/*if (isset($data['idPlay'])) {
			echo "<script>alert(esta definida)</script>";
		}else{
			echo "<script>alert(NO esta definida)</script>";
		}
		//print_r($data['idPlay'];
		//echo(gettype($data['idP']);
		//print_r($data['nombreCancion'];
		//echo(gettype($data['nombreCancion']);
		$idCan = $this->LogiM->idCan($nombreCancion);
		settype($idCan, "integer");
		$r = $this->LogiM->insCanPlay($idPlay, $idCan);
		$this->load->view('Usuario/Repro');
	}*/

}