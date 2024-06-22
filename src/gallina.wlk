import wollok.game.*
import juego.*
import autos.*

object gallina {
	const salto = new Sonido(sonido = "salto.mp3")
	const grito = new Sonido(sonido = "Pollo.mp3")
	var property position = game.at(4,0)
	var dirMira = "U"
	var property image = "GU01.png"
	var property tieneHuevo = false
	var huevo 
	method moverD(){
		dirMira = "D"
		if (tablero.limiteD() != self.position().x()){
			position = position.right(1)
			self.animacion(dirMira)
			}
	}
	
	method moverI(){
		dirMira = "I"
		if (tablero.limiteI() != self.position().x()){
			position = position.left(1)
			self.animacion(dirMira)
		}
	}
	
	method moverU(){
		dirMira = "U"
		if (tablero.limiteU() != self.position().y()){
			position = position.up(1)
			self.animacion(dirMira)
			
			}
	}
	
	method moverA(){
		dirMira = "A"
		if (tablero.limiteA() != self.position().y()){
			position = position.down(1)
			self.animacion(dirMira)
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
		image = "G" + dirMira + self.imgConOSinHuevo().toString() + "2.png"
		salto.reproducir()
		game.schedule(200, {self.imgDef(dir)}
		)
	}
	
	method imgDef(dir){
		image = "G" + dir + self.imgConOSinHuevo().toString() + "1.png"
	}
	
	method chocada(){
		pluma.aparecerEn(self.position().x(), self.position().y())
		grito.reproducir()
		position = game.at(4,0)
		juego.perderVida()
		if (self.tieneHuevo()){
			tieneHuevo = false
			if (juego.estaJugando()){huevo.addVisual()}
			huevo = null
		}
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

object pluma{
	var property position = game.at(0,0)
	method image() = "Plumas.png"
	method aparecerEn(x,y){
		position = game.at(x,y)
		game.addVisual(self)
		game.schedule(100, {game.removeVisual(self)})
	}
}
