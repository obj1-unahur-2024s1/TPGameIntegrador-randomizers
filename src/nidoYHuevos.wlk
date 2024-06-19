import gallina.*
import wollok.game.*
import juego.*

object nido {
	var property image = "Nido1.png"
	method position() = game.origin()
	method colicion(){}
}


class Huevo{
	const x
	const y
	method position() = game.at(x,y)
	method image() = "Huevo.png"
	method colicion(){}
}
