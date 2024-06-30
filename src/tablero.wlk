import wollok.game.*

object tablero {
	method image() = "Tabla.jpg"
	method position() = game.origin()
	method colicion(){}
}

object menu{
	var property image = "inicio.jpg"
	method position() = game.origin()
	method gameOver(){
		image = "GameOver.png"
	}
	method menuInicial(){
		image = "inicio.jpg"
	}
	method victoria(){
		image = "victoria.png"
	}
	method colicion(){}
	
}

class Vida{
	const x
	var property image = "Co1.png"
	method position() = game.at(x, 8)
	method vidaPerdida() {
		image = "Co2.png"
	}
	method reinicio(){
		image = "Co1.png"
		game.removeVisual(self)
	}
}

object fondo{
	method image() = "F1.png"
	method position() = game.at(10,0)
}

object fondo2{
	method image() = "F2.png"
	method position() = game.at(0,8)
}
	
	

	
