import wollok.game.*
import juego.*
import autos.*

object gallina {
	var sonido = new Sonido(sonido = "salto.mp3")
	var property position = game.at(4,0)
	var dirMira = "U"
	var property image = "GU1.png"
	
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
	
	method animacion(dir){
		image = "G" + dirMira + "2.png"
		sonido.reproducir()
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
