import wollok.game.*

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
	}
}
	
	

	
