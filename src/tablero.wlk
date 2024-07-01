import wollok.game.*
import juego.*

object tablero {
	method image() = "Tabla.jpg"
	method position() = game.origin()
	method colicion(){}
}

object menu{
	var property image = "inicio.png"
	method position() = game.origin()
	method gameOver(){
		image = "GameOver.png"
	}
	method menuInicial(){
		image = "inicio.png"
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
	}
}

object barraDeVida{
	const corazones = [new Vida(x = 1), new Vida(x = 2),new Vida(x = 3)]
	var property vidas = 3
	method addVisual(){
		corazones.forEach{ corazon => game.addVisual(corazon)
		}
	}
	method removeVisual(){
		corazones.forEach{ corazon => game.removeVisual(corazon)}
	}
	method reinicio(){
		corazones.forEach{ corazon => corazon.reinicio()}
		vidas = 3
	}
	method perderVida(){
		
		if (vidas == 3){
			corazones.get(2).vidaPerdida()
			vidas -= 1
		}
		else if (vidas == 2){
			corazones.get(1).vidaPerdida()
			vidas -= 1
		}
		else {
			vidas -= 1
			juego.gameOver()
		}
	}
	method perderVidas(){
		vidas = 0
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
	

	
