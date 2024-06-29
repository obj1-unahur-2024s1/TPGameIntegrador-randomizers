import juego.*
import wollok.game.*

object puntuacion {
	var property puntos = 0
	const digitos = [
		new Decimal(position = new Position(x= 11, y=7)),
		new Decimal(position = new Position(x= 10, y=7)),
		new Decimal(position = new Position(x= 9, y=7))
	    ]
	method position() = game.origin()
	
	method addVisual(){
		digitos.forEach({d => d.addVisual()})
	}
	
	method removeVisual(){
		if(game.hasVisual(self)) {
			game.removeVisual(self)		
		}
		digitos.forEach({d => d.removeVisual()})
	}
	method nuevoPuntaje(puntaje){
		puntos = puntaje
		
		(0..2).forEach({i => 
			const decimal = puntos % 10
			digitos.get(i).numero(decimal)
			puntos = (puntos / 10).truncate(0)})
		
	}
	method sumarPuntos(puntaje){
		self.nuevoPuntaje(puntos + puntaje)
	}
	
	method reset(){
		puntos = 0
		}
}


class Decimal {
	var property position 
	var property numero = 0
	method addVisual(){
			game.addVisual(self)		
		
	}
	method removeVisual(){
		if(game.hasVisual(self)) {
			game.removeVisual(self)		
		}
	}
		
	method image() = "assets/"+ numero + ".png"
}

object contador{
	const property position = game.origin()
	var tiempo = 0
	method tiempo() = tiempo
	method nuevoContador(){
		game.onTick(1000,"Contador",{tiempo = tiempo + 1})
	}
	method colicion(){}
}
