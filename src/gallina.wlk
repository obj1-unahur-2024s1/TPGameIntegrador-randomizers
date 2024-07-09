import wollok.game.*
import juego.*
import autos.*
import tablero.*

object gallina {
	const salto = new Sonido(sonido = "salto.mp3")
	const grito = new Sonido(sonido = "Pollo.mp3")
	var property position = game.at(4,0)
	var dirMira = abajo
	var property image = "GU01.png"
	var property tieneHuevo = false
	var huevo = null
	var property pausado = false
	var property reiniciado = false
	
	method pausar(){
		pausado = !pausado
	}
	
	method configurada(){
		reiniciado = !reiniciado
	}
	method mover(dir){
		if (!pausado){
		dirMira = dir
		if (dirMira.puedeAvanzar(position)){
			position = dirMira.avanzar(position)
			self.animacion(dirMira)
			}
		}
	}
	
	method imgConOSinHuevo(){
		if (tieneHuevo){
			return 1
		}
		else {
			return 0
		}
	}
	
	
	method animacion(dir){
		image = "G" + dir.img() + self.imgConOSinHuevo().toString() + "2.png"
		salto.reproducir()
		game.schedule(200, {self.imgDef(dir)}
		)
	}
	
	method imgDef(dir){
		image = "G" + dir.img() + self.imgConOSinHuevo().toString() + "1.png"
	}
	
	method chocada(){
		const pluma = new Pluma()
		pluma.aparecerEn(self.position().x(), self.position().y())
		grito.reproducir()
		self.posInicial()
		barraDeVida.perderVida()
		if (self.tieneHuevo()){
			tieneHuevo = false
			if (juego.estaJugando()){huevo.addVisual()}
			huevo = null
		}
		image = "GU01.png"
	}
	
	method posInicial(){
		position = game.at(4,0)
		image = "GU01.png"
	}
	
	method agarrarHuevo(egg){
		tieneHuevo = true
		huevo = egg
	}
	method dejarHuevo(){
		tieneHuevo = false
		huevo = null
	}
	

	
}

class Pluma{
	var property position = game.at(0,0)
	method image() = "Plumas.png"
	method aparecerEn(x,y){
		position = game.at(x,y)
		game.addVisual(self)
		game.schedule(100, {game.removeVisual(self)})
	}
	method colicion(){}
}
