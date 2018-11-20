<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Musica extends CI_Controller {
	function __construct(){
		parent::__construct();
		$this->load->helper('form');
		$this->load->helper('url');
		$this->load->model('LoginM');
		$this->load->library('session');
	}

	public function index()
	{
		$this->load->view('musica/header');
		$this->load->view('musica/principal');
	}
	public function login(){
		#Recuperamos datos del form y los guardamos en un arreglo
		$data = array(
				'usuario' => $this->input->post('usuario'),
				'contra' => $this->input->post('contra')
			);
		#Validamos que no esten vacios los campos, se mandan alerts
		if($data['usuario']==""){
			echo '<script>alert("Ingresa un usuario");</script>';
			$this->load->view('musica/header');
			$this->load->view('musica/principal');
		}
		elseif($data['contra']==""){
			echo '<script>alert("Ingresa una Contraseña");</script>';
			$this->load->view('musica/header');
			$this->load->view('musica/principal');
		}
		#Si no estan vacios...
		else{
			#Checamos en el modelo si eciste el usuario 
			$idTipo_Usuario=$this->LoginM->Checar_Usuario($data);
			if($idTipo_Usuario == 1){
				#existe como Administrador
				#recupero el id del usuario y se guarda la session
				$idUsuario=$this->LoginM->Regresa_idUsuario($data);
				$usuario_data = array(
					'id' => $idUsuario,
					);
				$this->session->set_userdata($usuario_data);
				#echo($this->session->userdata('id'));
				#echo("Admin");
				$this->load->view('musica/header');
				$this->load->view('musica/inicioAdmin',$data);
			}
			elseif($idTipo_Usuario == 2){
				#existe como Usuario
				#recupero el id del usuario y se guarda la session
				$idUsuario=$this->LoginM->Regresa_idUsuario($data);
				$usuario_data = array(
					'id' => $idUsuario,
					);
				$this->session->set_userdata($usuario_data);
				$this->load->view('musica/header');
				$this->load->view('musica/inicioUsuario',$data);
			}else{
				#El usuario no existe
				echo '<script>alert("Usuario sin registro");</script>';
				$this->load->view('musica/header');
				$this->load->view('musica/principal');
			}
		}
		
	}
	function Salir(){
		$this->session->sess_destroy();
		$this->load->view('musica/header');
		$this->load->view('musica/principal');
	}
}
