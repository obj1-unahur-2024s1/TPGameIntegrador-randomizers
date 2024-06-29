import wollok.game.*
import autos.*
import gallina.*
import tablero.*
import nidoYHuevos.*
import puntuacion.*

object juego{
	const carreteraR1 = new Carretera(y = 1, dir = derecha)
	const carreteraR2 = new Carretera(y = 5, dir = derecha)
	const carreteraL1 = new Carretera(y = 2, dir = izquierda)
	const carreteraL2 = new Carretera(y = 6, dir = izquierda)
	const rieles1 = new Carretera(y = 3, dir = derecha)
	const rieles2 = new Carretera(y = 4, dir = izquierda)
	const vehiculos = []
	const huevos = [new Huevo(x = 4, y = 7), new Huevo(x = 5, y = 7), new Huevo(x = 6, y = 7)]
	var pausado = false
	var property estaJugando = false
	const sonido = game.sound("Musica pollo.mp3") 
	const sonidoBoton = new Sonido(sonido = "menu-button.mp3")
	const corazon1 = new Vida(x = 1)
	const corazon2 = new Vida(x = 2)
	const corazon3 = new Vida(x = 3)
	var vidas = 0
	var reiniciado = false
	var nivelQueJuega
	var estaEnMenu = true
	
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
		game.addVisual(rieles1)
		game.addVisual(rieles2)
		game.addVisual(menu)
		keyboard.r().onPressDo{self.reiniciar()}
		keyboard.m().onPressDo{self.menuInicial()}
		keyboard.f().onPressDo{if (estaEnMenu){self.nivel1() sonidoBoton.reproducir()}}
		keyboard.h().onPressDo{if (estaEnMenu){self.nivel2() sonidoBoton.reproducir()}}
    	keyboard.p().onPressDo{self.pausar()}
    	self.agregarTrenes()
		game.start()	}
		
	method pausar(){
		gallina.pausado()
		if (pausado){
			self.conducirVehiculos()
			pausado = !pausado
			game.removeVisual(fondo)
			game.addVisual(fondo)
			contador.nuevoContador()
		}
		else {
			vehiculos.forEach({a => a.detener()})
			pausado = !pausado
			game.removeTickEvent("Contador")
		}
	}
	
	method reiniciar(){
		if (!estaJugando){
			puntuacion.removeVisual()				
			puntuacion.reset()
			gallina.posInicial()
			if (nivelQueJuega == 1){
				self.nivel1()
			}
			else {
				self.nivel2()
			}
		}
		else {
			self.gameOver()
		}
	} 
	
	method perderVida(){
		if (vidas == 3){
			corazon3.vidaPerdida()
			vidas -= 1
		}
		else if (vidas == 2){
			corazon2.vidaPerdida()
			vidas -= 1
		}
		else {
			vidas -= 1
			self.gameOver()
		}
	}
	
	method menuInicial(){
		if (!estaJugando){
			estaEnMenu = true
			puntuacion.reset()
			puntuacion.removeVisual()
			game.removeVisual(menu)
			menu.menuInicial()
			game.addVisual(menu)
			}
	}
	
	
	method configurarGallina(){
		if (!reiniciado){
			game.addVisual(gallina)
			gallina.posInicial()
			keyboard.right().onPressDo{gallina.mover(derecha)}
			keyboard.left().onPressDo{gallina.mover(izquierda)}
			keyboard.up().onPressDo{gallina.mover(arriba)}
			keyboard.down().onPressDo{gallina.mover(abajo)}
			game.onCollideDo(gallina, {auto => auto.colicion()})
			}
		else {
			game.addVisual(gallina)
		}
	}
	
	method conducirVehiculos(){
		vehiculos.forEach({a => a.conducir(400)})
	}
	
	method configuracionDefaut(){
		    estaEnMenu = false
		    estaJugando = true
		    vidas = 3
		    game.removeVisual(menu)
			game.addVisual(tablero)
			nido.default()
			self.configurarGallina()
			vehiculos.forEach({a => game.addVisual(a)})
			huevos.forEach{h => h.addVisual()}
			self.conducirVehiculos()
			game.addVisual(fondo)
			game.addVisual(fondo2)
			game.addVisual(corazon1)
			game.addVisual(corazon2)
			game.addVisual(corazon3)
			contador.nuevoContador()
	}
	
	method agregarTrenes(){
		vehiculos.add(new Tren(camino = rieles1, x = rieles1.dir().inicio()))
			vehiculos.add(new Tren(camino = rieles2, x = rieles2.dir().inicio()))
			vehiculos.add(new Vagon(camino = rieles1, x = rieles1.dir().inicio()-1))
			vehiculos.add(new Vagon(camino = rieles1, x = rieles1.dir().inicio()-2))
			vehiculos.add(new Vagon(camino = rieles1, x = rieles1.dir().inicio()-3))
			vehiculos.add(new Vagon(camino = rieles2, x = rieles2.dir().inicio()+1))
			vehiculos.add(new Vagon(camino = rieles2, x = rieles2.dir().inicio()+2))
			vehiculos.add(new Vagon(camino = rieles2, x = rieles2.dir().inicio()+3))
	}
	
	method nivel1(){
		if (!estaJugando){
			nivelQueJuega = 1
			vehiculos.add(new Auto(camino = carreteraR1, x = 2))
			vehiculos.add(new Auto(camino = carreteraR1, x = 5))
			vehiculos.add(new Auto(camino = carreteraR2, x = 4))
			vehiculos.add(new Auto(camino = carreteraR2, x = 6))
			vehiculos.add(new Auto(camino = carreteraL1, x = 2))
			vehiculos.add(new Auto(camino = carreteraL1, x = 7))
			vehiculos.add(new Auto(camino = carreteraL2, x = 0))
			vehiculos.add(new Auto(camino = carreteraL2, x = 3))
			self.configuracionDefaut()
		}
	}
	
	method nivel2(){
		if (!estaJugando){
			nivelQueJuega = 2
			vehiculos.add(new Auto(camino = carreteraR1, x = 0))
			vehiculos.add(new Auto(camino = carreteraR1, x = 1))
			vehiculos.add(new Auto(camino = carreteraR2, x = 4))
			vehiculos.add(new Auto(camino = carreteraR2, x = 6))
			vehiculos.add(new Auto(camino = carreteraL1, x = 2))
			vehiculos.add(new Auto(camino = carreteraL1, x = 3))
			vehiculos.add(new Auto(camino = carreteraL2, x = 4))
			vehiculos.add(new Auto(camino = carreteraL2, x = 6))
			vehiculos.add(new Auto(camino = carreteraR1, x = 4))
			vehiculos.add(new Auto(camino = carreteraR1, x = 7))
			vehiculos.add(new Auto(camino = carreteraR2, x = 1))
			vehiculos.add(new Auto(camino = carreteraR2, x = 7))
			vehiculos.add(new Auto(camino = carreteraL1, x = 9))
			vehiculos.add(new Auto(camino = carreteraL1, x = 0))
			vehiculos.add(new Auto(camino = carreteraL2, x = 2))
			vehiculos.add(new Auto(camino = carreteraL2, x = 9))
			self.configuracionDefaut()
		}
	}
	
	method gameOver(){
		self.removerImagenes()
		reiniciado = true
		gallina.posInicial()
		menu.gameOver()   
		game.addVisual(menu)
		puntuacion.nuevoPuntaje(0.max((vidas * 200) + (nido.cantidadHuevos() * 100) - (contador.tiempo())))
		puntuacion.addVisual()
		game.removeTickEvent("Contador")
		vehiculos.forEach{a => a.detener()}
		vehiculos.forEach{v => if (v.esAuto()){vehiculos.remove(v)}}
		estaJugando = false
	}
		
	method removerImagenes(){
		game.removeVisual(tablero)
		game.removeVisual(nido)
		game.removeVisual(gallina)
		corazon1.reinicio()
		corazon2.reinicio()
		corazon3.reinicio()
		huevos.forEach{h => h.sacarVisual()}
        vehiculos.forEach{a => game.removeVisual(a)}
		game.removeVisual(fondo)
		game.removeVisual(fondo2)
	}
		
	method victoria(){
			self.gameOver()
			menu.victoria()
		}
}


object derecha{
	method avanzar(pos){
		return pos.right(1)
	}
	method final() = 9
	method inicio() = -1
	method img() = "D"
	method puedeAvanzar(pos) = pos.x() != self.final()
} 

object izquierda{
	method avanzar(pos){
		return pos.left(1)
	}
	method final() = 0
	method inicio() = 10
	method img() = "I"
	method puedeAvanzar(pos) = pos.x() != self.final()
}

object arriba{
	method avanzar(pos){
		return pos.up(1)
	}
	method final() = 7
	
	method img() = "U"
	method puedeAvanzar(pos) = pos.y() != self.final()
}

object abajo{
	method avanzar(pos){
		return pos.down(1)
	}
	method final() = 0
	method img() = "A"
	method puedeAvanzar(pos) = pos.y() != self.final()
}



class Carretera{
	const y
	const dir
	method position()= game.at(dir.inicio(),y)
	method dir() = dir
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


