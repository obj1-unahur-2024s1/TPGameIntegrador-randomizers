import wollok.game.*
import juego.*
import autos.*

object gallina {
	var property position = game.at(4,0)
	var dirMira = "A"
	var property image = "GA1.png"
	
	method moverD(){
		dirMira = "A"
		if (tablero.limiteD() != self.position().x()){
			position = position.right(1)
			self.animacion(dirMira)
			new Sonido(sonido = "salto.mp3").reproducir()
			}
	}
	
	method moverI(){
		dirMira = "A"
		if (tablero.limiteI() != self.position().x()){
			position = position.left(1)
			self.animacion(dirMira)
			new Sonido(sonido = "salto.mp3").reproducir()
		}
	}
	
	method moverU(){
		dirMira = "A"
		if (tablero.limiteU() != self.position().y()){
			position = position.up(1)
			self.animacion(dirMira)
			new Sonido(sonido = "salto.mp3").reproducir()
			}
	}
	
	method moverA(){
		dirMira = "A"
		if (tablero.limiteA() != self.position().y()){
			position = position.down(1)
			self.animacion(dirMira)
			new Sonido(sonido = "salto.mp3").reproducir()
			}
			
	}
	
	method animacion(dir){
		image = "GA2.png"
		game.schedule(200, {self.imgDef(dir)}
		)
	}
	
	method imgDef(dir){
		image = "G" + dir + "1.png"
	}
	
	method chocada(){
		position = game.at(4,0)
	}
	
}
