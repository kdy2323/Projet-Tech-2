<?php

class Autoloader{
    //fonction qui appelle la méthode de chargement
    //automatique des classes
    static function register(){
        spl_autoload_register(array(__CLASS__,'autoload'));
    }
    //méthode appelée par register()
    static function autoload($classname){
        require $classname.".class.php";
    }
}