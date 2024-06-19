import wollok.game.*
import autos.*
import gallina.*
import tablero.*
import nidoYHuevos.*

object juego{
	const carreteraR1 = new Carretera(y = 1, dir = derecha)
	const carreteraR2 = new Carretera(y = 5, dir = derecha)
	const carreteraL1 = new Carretera(y = 2, dir = izquierda)
	const carreteraL2 = new Carretera(y = 6, dir = izquierda)
	const autos = []
	const huevos = [new Huevo(x = 4, y = 7), new Huevo(x = 5, y = 7), new Huevo(x = 6, y = 7)]
	var pausado = false
	var estaJugando = false
	const sonido = game.sound("Musica pollo.mp3") 
	
	
	method iniciar(){
		game.schedule(200, { sonido.play()} )
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
//		keyboard.u().onPressDo{self.gameOver()}
		contador.nuevoContador()
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
	
	method configuracionDefaut(){
		    game.removeVisual(menu)
			game.addVisual(tablero)
			self.configurarGallina()
			autos.add(trenDer)
			autos.add(trenIzq)
			autos.forEach({a => game.addVisual(a)})
			autos.forEach({a => a.conducir(400)})
			game.addVisual(fondo)
			game.addVisual(fondo2)
			game.addVisual(nido)
			huevos.forEach{h => game.addVisual(h)}
			estaJugando = true
	}
	
	method nivel1(){
		if (!estaJugando){
			autos.add(new Auto(carretera = carreteraR1, x = 2))
			autos.add(new Auto(carretera = carreteraR1, x = 3))
			autos.add(new Auto(carretera = carreteraR2, x = 4))
			autos.add(new Auto(carretera = carreteraR2, x = 6))
			autos.add(new Auto(carretera = carreteraL1, x = 2))
			autos.add(new Auto(carretera = carreteraL1, x = 3))
			autos.add(new Auto(carretera = carreteraL2, x = 4))
			autos.add(new Auto(carretera = carreteraL2, x = 6))
			self.configuracionDefaut()
		}
	}
	
	method nivel2(){
		if (!estaJugando){
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
			self.configuracionDefaut()
		}
	}
	
	method gameOver(){
		    menu.gameOver()
			game.addVisual(menu)
			puntuacion.nuevoPuntaje(155 + contador.tiempo())
			puntuacion.addVisual()
			game.removeTickEvent("Contador")
			autos.forEach{a => a.detener()}
			autos.forEach{a => game.removeVisual(a)}
			game.removeVisual(nido)
			huevos.forEach{h => game.removeVisual(h)}
			game.removeVisual(gallina)
		}
}
	
	
/* Prueba Puntuacion
 * 	method gameOver(){
		game.removeVisual(menu)
		puntuacion.nuevoPuntaje(155 + contador.tiempo())
		puntuacion.addVisual()
		game.removeTickEvent("Contador")
	}*/


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
	method image() = "Tabla.jpg"
	method position() = game.origin()
	method limiteD() = 9
	method limiteU() = 7
	method limiteA() = 0
	method limiteI() = 0
	method colicion(){}
}

object fondo{
	method image() = "F1.png"
	method position() = game.at(10,0)
}

object fondo2{
	method image() = "F2.png"
	method position() = game.at(0,8)
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

object puntuacion {
	var property puntos = 0
	const digitos = [
		new Decimal(position = new Position(x= 11, y=3)),
		new Decimal(position = new Position(x= 10, y=3)),
		new Decimal(position = new Position(x= 9, y=3)),
		new Decimal(position = new Position(x= 8, y=3)),
		new Decimal(position = new Position(x= 7, y=3)),
		new Decimal(position = new Position(x= 6, y=3))
	]
	method image() = "assets/puntuacion.png"
	method position() = game.origin()
	
	method addVisual(){
		if(!game.hasVisual(self)) {
			game.addVisual(self)
		}
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
		
		(0..5).forEach({i => 
			const decimal = puntos % 10
			digitos.get(i).numero(decimal)
			puntos = (puntos / 10).truncate(0)}
			)
		
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
}
