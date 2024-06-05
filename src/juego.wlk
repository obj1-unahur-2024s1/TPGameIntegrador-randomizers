import wollok.game.*
import autos.*

object juego{
	const carreteraR1 = new Carretera(y = 1, dir = derecha)
	const carreteraR2 = new Carretera(y = 5, dir = derecha)
	const carreteraL1 = new Carretera(y = 2, dir = izquierda)
	const carreteraL2 = new Carretera(y = 6, dir = izquierda)
	const autos = []
	var pausado = false
	method iniciar(){
		game.cellSize(90)
		game.boardGround("Tabla.png")
		game.width(10)
		game.height(8)
		game.title("Salva los huevos")
		game.addVisual(carreteraR1)
		game.addVisual(carreteraR2)
		game.addVisual(carreteraL1)
		game.addVisual(carreteraL2)
		
		self.nivel1()/*
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
	
	method nivel1(){
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
		autos.forEach({a => a.conducir()})
	}
}

object derecha{
	method avanzar(pos){
		return pos.right(1)
	}
	method final() = 10
	method inicio() = 0
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
}

