<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Usuario extends CI_Controller {
	function __construct(){
		parent::__construct();
		$this->load->helper('form');
		$this->load->helper('url');
		$this->load->model('LoginM');
		$this->load->library('session');
	}
	public function index(){
		$this->load->view('musica/header');
		$this->load->view('Usuario/inicioUsuario');
    
	}
	public function PlayList(){
	$PL=$this->load->view('Usuario/Playlist');
        return $PL;
	}
	
}