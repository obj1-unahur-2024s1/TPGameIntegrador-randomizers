import gallina.*
import wollok.game.*
import juego.*

object nido {
	var img = 0
	var property image = "Nido0.png"
	method position() = game.origin()
	method colicion(){
		if (gallina.tieneHuevo()){
			img += 1
			image = "Nido" + img + ".png"
			gallina.dejarHuevo()
		}
	}
	method default(){
		image = "Nido0.png"
		game.addVisual(self)
		img = 1
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
