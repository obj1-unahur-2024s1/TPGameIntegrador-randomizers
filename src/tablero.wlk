import wollok.game.*

object menu{
	var property image = "inicio.jpg"
	method position() = game.origin()
	method gameOver(){
		image = "GameOver.png"
	}
	}
	
	
	
object barraDeVida{

	var property position = game.at(6, 0)

	var saludTony = 13
	// la barra se actualiza en función de la vida que tiene el objeto tony
	method image() = "GA1" + tony.salud() + ".png"

	// no nos deja tener el método solamente en la clase abstracta
	method chocasteCon(personaje) {
	}

}

object coleccionVidas {

	var property vidas = [ new TonyVidas(position = game.at(5, 0)), new TonyVidas(position = game.at(4, 0)), new TonyVidas(position = game.at(3, 0)) ]

	method removerVida() {
		game.removeVisual(vidas.first())
		vidas.remove(vidas.first())
	}

	method image() {
		vidas.forEach({ i => game.addVisual(i)})
	}

}

class TonyVidas {

	var property position

	method image() = "tony_fren_vida.png"

}
	
