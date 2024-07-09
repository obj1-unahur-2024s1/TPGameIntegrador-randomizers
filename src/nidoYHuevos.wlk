import gallina.*
import wollok.game.*
import juego.*

object nido {
	var property cantidadHuevos  = 0

	var property image = "Nido0.png"
	method position() = game.origin()
	method colicion(){
		if (gallina.tieneHuevo()){
			cantidadHuevos  += 1
			image = "Nido" + cantidadHuevos  + ".png"
			gallina.dejarHuevo()
			self.victoria()
		}
	}
	method default(){
		image = "Nido0.png"
		game.addVisual(self)

		cantidadHuevos  = 0
	}
	
	method victoria(){
		if (cantidadHuevos == 3){
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
