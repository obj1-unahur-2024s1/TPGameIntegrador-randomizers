import gallina.*
import wollok.game.*
import juego.*

object nido {
<<<<<<< HEAD
	var property cantidadHuevos  = 0
=======
	var cantidadHuevos = 0
>>>>>>> c95c67c9148d3b52cb4a2a8ddafd457362bf73df
	var property image = "Nido0.png"
	method position() = game.origin()
	method cantidadHuevos() = cantidadHuevos
	method colicion(){
		if (gallina.tieneHuevo()){
<<<<<<< HEAD
			cantidadHuevos  += 1
			image = "Nido" + cantidadHuevos  + ".png"
=======
			cantidadHuevos += 1
			image = "Nido" + cantidadHuevos + ".png"
>>>>>>> c95c67c9148d3b52cb4a2a8ddafd457362bf73df
			gallina.dejarHuevo()
			self.victoria()
		}
	}
	method default(){
		image = "Nido0.png"
		game.addVisual(self)
<<<<<<< HEAD
		cantidadHuevos  = 0
	}
	
	method victoria(){
		if (cantidadHuevos  == 3){
=======
		cantidadHuevos = 0
	}
	
	method victoria(){
		if (cantidadHuevos == 3){
>>>>>>> c95c67c9148d3b52cb4a2a8ddafd457362bf73df
			juego.victoria()
		}
	}

}


class Huevo{
	const x
	const y
	method position() = game.at(x,y)
	method image() = "Huevo.png"
	method colicion(){
		if(!gallina.tieneHuevo()){
			game.removeVisual(self)
			gallina.agarrarHuevo(self)
		}
	}
	method addVisual(){
		if(!game.hasVisual(self)){
			game.addVisual(self)
		}
	}
	
	method sacarVisual(){
		if(game.hasVisual(self)){
			game.removeVisual(self)
		}
	}
}
