<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Administrador extends CI_Controller {
	function __construct(){
		parent::__construct();
		$this->load->helper('form');
		$this->load->helper('url');
		$this->load->model('LoginM');
		$this->load->library('session');
	}
	public function index(){
		$this->load->view('musica/header');
		$this->load->view('Administrador/inicioAdmin');
    
	}
	public function Canciones(){
	$ACancion=$this->load->view('Administrador/AdminCanciones');
        return $ACancion;
	}
	public function Usuarios(){
	$AUsuario=$this->load->view('Administrador/AdminUsuarios');
        return $AUsuario;
	}
}