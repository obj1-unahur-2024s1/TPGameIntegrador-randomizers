import wollok.game.*
import autos.*
import gallina.*
import tablero.*

object juego{
	const carreteraR1 = new Carretera(y = 1, dir = derecha)
	const carreteraR2 = new Carretera(y = 5, dir = derecha)
	const carreteraL1 = new Carretera(y = 2, dir = izquierda)
	const carreteraL2 = new Carretera(y = 6, dir = izquierda)
	const autos = []
	var pausado = false
	var estaJugando = false
	method iniciar(){
		game.cellSize(90)
		game.width(12)
		game.height(9)
		game.title("Salva los huevos")
		game.addVisual(carreteraR1)
		game.addVisual(carreteraR2)
		game.addVisual(carreteraL1)
		game.addVisual(carreteraL2)
		game.addVisual(menu)
		keyboard.f().onPressDo{self.nivel1() new Sonido(sonido = "menu-button.mp3").reproducir()}
		keyboard.h().onPressDo{self.nivel2() new Sonido(sonido = "menu-button.mp3").reproducir()}
/*
		keyboard.r().onPressDo({self.pausar()})
		self.coliciones()*/
		game.start()	}
	method pausar(){
		if (pausado){
			autos.forEach({a => a.conducir()})
			pausado = !pausado
		}
		else {
			autos.forEach({a => a.detener()})
			pausado = !pausado
		}
	}
	
	method configurarGallina(){
		keyboard.right().onPressDo{gallina.moverD()}
		keyboard.left().onPressDo{gallina.moverI()}
		keyboard.up().onPressDo{gallina.moverU()}
		keyboard.down().onPressDo{gallina.moverA()}
		game.addVisual(gallina)
		game.onCollideDo(gallina, {auto => auto.colicion()})
	}
	
	method nivel1(){
		if (!estaJugando){
			game.removeVisual(menu)
			game.addVisual(tablero)
			game.boardGround("fondo(1).jpeg")
			self.configurarGallina()
			autos.add(trenDer)
			autos.add(trenIzq)
			autos.add(new Auto(carretera = carreteraR1, x = 2))
			autos.add(new Auto(carretera = carreteraR1, x = 3))
			autos.add(new Auto(carretera = carreteraR2, x = 4))
			autos.add(new Auto(carretera = carreteraR2, x = 6))
			autos.add(new Auto(carretera = carreteraL1, x = 2))
			autos.add(new Auto(carretera = carreteraL1, x = 3))
			autos.add(new Auto(carretera = carreteraL2, x = 4))
			autos.add(new Auto(carretera = carreteraL2, x = 6))
			autos.forEach({a => game.addVisual(a)})
			autos.forEach({a => a.conducir(400)})
			game.addVisual(fondo)
			estaJugando = true
		}
	}
	
	method nivel2(){
		if (!estaJugando){
			game.removeVisual(menu)
			game.addVisual(tablero)
			game.boardGround("fondo(1).jpeg")
			self.configurarGallina()
			autos.add(trenDer)
			autos.add(trenIzq)
			autos.add(new Auto(carretera = carreteraR1, x = 2))
			autos.add(new Auto(carretera = carreteraR1, x = 3))
			autos.add(new Auto(carretera = carreteraR2, x = 4))
			autos.add(new Auto(carretera = carreteraR2, x = 6))
			autos.add(new Auto(carretera = carreteraL1, x = 2))
			autos.add(new Auto(carretera = carreteraL1, x = 3))
			autos.add(new Auto(carretera = carreteraL2, x = 4))
			autos.add(new Auto(carretera = carreteraL2, x = 6))
			autos.add(new Auto(carretera = carreteraR1, x = 5))
			autos.add(new Auto(carretera = carreteraR1, x = 8))
			autos.add(new Auto(carretera = carreteraR2, x = 8))
			autos.add(new Auto(carretera = carreteraR2, x = 7))
			autos.add(new Auto(carretera = carreteraL1, x = 9))
			autos.add(new Auto(carretera = carreteraL1, x = 1))
			autos.add(new Auto(carretera = carreteraL2, x = 2))
			autos.add(new Auto(carretera = carreteraL2, x = 9))
			autos.forEach({a => game.addVisual(a)})
			autos.forEach({a => a.conducir(300)})
			game.addVisual(fondo)
			estaJugando = true
		}
	}
}

object derecha{
	method avanzar(pos){
		return pos.right(1)
	}
	method final() = 9
	method inicio() = -1
	method img() = "D"
}

object izquierda{
	method avanzar(pos){
		return pos.left(1)
	}
	method final() = 0
	method inicio() = 10
	method img() = "I"
}


class Carretera{
	const y
	const dir
	method position()= game.at(dir.inicio(),y)
	method dir() = dir
	method colicion(){}
}

object tablero {
	method image() = "Tabla.png"
	method position() = game.origin()
	method limiteD() = 9
	method limiteU() = 7
	method limiteA() = 0
	method limiteI() = 0
	method colicion(){}
}

object fondo{
	method image() = "fondo(1).jpeg"
	method position() = game.at(10,0)
}

class Sonido{
	const property sonido 
	
	method reproducir(){
		game.sound(sonido).play()
	}
	method parar(){
		game.sound(sonido).stop()
	}
}
