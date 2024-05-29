import wollok.game.*
import autos.*

object juego{
	const carreteraR1 = new CarreteraR(pos = 2)
	const carreteraR2 = new CarreteraR(pos = 9)
	const carreteraL1 = new CarreteraL(pos = 3)
	const carreteraL2 = new CarreteraL(pos = 10)
	const autos = []
	var pos = 1
	var pausado = false
	method iniciar(){
		game.cellSize(60)
		game.width(15)
		game.height(13)
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
		game.addVisual(trenDer)
		trenDer.conducir()
		game.addVisual(trenIzq)
		trenIzq.conducir()
		autos.add(new Auto(carretera = carreteraR1, x = 2, direccion = derecha ))
		autos.add(new Auto(carretera = carreteraR1, x = 3, direccion = derecha))
		autos.add(new Auto(carretera = carreteraL1, x = 4, direccion = izquierda ))
		autos.add(new Auto(carretera = carreteraL1, x = 8, direccion = izquierda))
		autos.add(new Auto(carretera = carreteraR2, x = 2, direccion = derecha ))
		autos.add(new Auto(carretera = carreteraR2, x = 7, direccion = derecha))
		autos.add(new Auto(carretera = carreteraL2, x = 2, direccion = izquierda ))
		autos.add(new Auto(carretera = carreteraL2, x = 4, direccion = izquierda))
		
		autos.forEach({a => game.addVisual(a)})
		autos.forEach({a => a.conducir()})
	}
}

object derecha{
	method avanzar(pos){
		return pos.right(1)
	}
	method final() = 14
}

object izquierda{
	method avanzar(pos){
		return pos.left(1)
	}
	method final() = 0
}

class CarreteraR{
	const pos
	method position()= game.at(0,pos)
	method text() = pos.toString()
}

class CarreteraL{
	const pos
	method position()= game.at(14,pos)
	method text() = pos.toString()
}

