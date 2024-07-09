import wollok.game.*
import autos.*
import gallina.*
import tablero.*
import nidoYHuevos.*
import puntuacion.*

object juego{
	var property nivelQueJuega = null
	var property estaEnMenu = true	
	var property estaJugando = false
	const musica = new Sonido(sonido = "Musica pollo.mp3")
	const sonidoBoton = new Sonido(sonido = "menu-button.mp3")
	const carreteraR1 = new Carretera(y = 1, dir = derecha)
	const carreteraR2 = new Carretera(y = 5, dir = derecha)
	const carreteraL1 = new Carretera(y = 2, dir = izquierda)
	const carreteraL2 = new Carretera(y = 6, dir = izquierda)
	const rieles1 = new Carretera(y = 3, dir = derecha)
	const rieles2 = new Carretera(y = 4, dir = izquierda)
	const vehiculos = []
	const huevos = [new Huevo(x = 4, y = 7), new Huevo(x = 5, y = 7), new Huevo(x = 6, y = 7)] 
	
	method iniciar(){
		game.schedule(400, { self.reproducirMusica()} )
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
		
	method reproducirMusica(){
		musica.reproducir()
		game.onTick(148000, "musica", {musica.reproducir()})
	}	
    
	method pausar(){
		if (estaJugando){
			pausa.pausar()
		}
	}
	
	method reiniciar(){
		if (!estaEnMenu){
			reinicio.reiniciar()
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
		if (!gallina.reiniciado()){
			game.addVisual(gallina)
			gallina.configurada()
			gallina.posInicial()
			keyboard.right().onPressDo{gallina.mover(derecha)}
			keyboard.left().onPressDo{gallina.mover(izquierda)}
			keyboard.up().onPressDo{gallina.mover(arriba)}
			keyboard.down().onPressDo{gallina.mover(abajo)}
			game.onCollideDo(gallina, {cosa => cosa.colicion()})
			}
		else {
			game.addVisual(gallina)
		}
	}
	
	method conducirVehiculos(){
		vehiculos.forEach({a => a.conducir(400)})
	}
	
	method detenerVehiculos(){
		vehiculos.forEach({a => a.detener()})
	}
		    
	method configuracionDefault(){
		    gallina.posInicial()
		    estaEnMenu = false
		    estaJugando = true
		    game.removeVisual(menu)
			game.addVisual(tablero)
			nido.default()
			self.configurarGallina()
			vehiculos.forEach({a => a.addVisual()})
			huevos.forEach{h => h.addVisual()}
			self.conducirVehiculos()
			game.addVisual(fondo)
			game.addVisual(fondo2)
			barraDeVida.addVisual()
			contador.nuevoContador()
			barraDeVida.reinicio()
	}
	
	method agregarTrenes(){
		self.agregarVehiculos([new Tren(camino = rieles1, x = rieles1.dir().inicio()),
							   new Tren(camino = rieles2, x = rieles2.dir().inicio())
			                  ])
	    vehiculos.get(0).agregarVagones([ new Vagon(camino = rieles1, x = rieles1.dir().inicio()-1),
	    	                   new Vagon(camino = rieles1, x = rieles1.dir().inicio()-2),
							   new Vagon(camino = rieles1, x = rieles1.dir().inicio()-3)])
		vehiculos.get(1).agregarVagones([new Vagon(camino = rieles2, x = rieles2.dir().inicio()+1),
							   new Vagon(camino = rieles2, x = rieles2.dir().inicio()+2), 
							   new Vagon(camino = rieles2, x = rieles2.dir().inicio()+3)])
	}
	
	method nivel1(){
		if (!estaJugando){
			nivelQueJuega = 1
			self.agregarVehiculos([new Auto(camino = carreteraR1, x = 2), new Auto(camino = carreteraR1, x = 5), 
								   new Auto(camino = carreteraR2, x = 4), new Auto(camino = carreteraR2, x = 6), 
								   new Auto(camino = carreteraL1, x = 2), new Auto(camino = carreteraL1, x = 7), 
				                   new Auto(camino = carreteraL2, x = 0), new Auto(camino = carreteraL2, x = 3) 
				                  ])
			self.configuracionDefault()
		}
	}
	
	method nivel2(){
		if (!estaJugando){
			nivelQueJuega = 2
			self.agregarVehiculos([new Auto(camino = carreteraR1, x = 0), new Auto(camino = carreteraR1, x = 1),
								   new Auto(camino = carreteraR2, x = 4), new Auto(camino = carreteraR2, x = 6),
								   new Auto(camino = carreteraL1, x = 2), new Auto(camino = carreteraL1, x = 3),
								   new Auto(camino = carreteraL2, x = 4), new Auto(camino = carreteraL2, x = 6),
								   new Auto(camino = carreteraR1, x = 4), new Auto(camino = carreteraR1, x = 7),
								   new Auto(camino = carreteraR2, x = 1), new Auto(camino = carreteraR2, x = 7),
								   new Auto(camino = carreteraL1, x = 9), new Auto(camino = carreteraL1, x = 0),
				                   new Auto(camino = carreteraL2, x = 2), new Auto(camino = carreteraL2, x = 9)
								  ])
			self.configuracionDefault()
		}
	}
	
	method gameOver(){
		self.removerImagenes()
		menu.gameOver()   
		game.addVisual(menu)
		puntuacion.nuevoPuntaje(puntuacion.calculoPuntaje())
		puntuacion.addVisual()
		game.removeTickEvent("Contador")
		self.detenerVehiculos()
		self.quitarAutos()
		estaJugando = false
	}
		
	method removerImagenes(){
		game.removeVisual(tablero)
		game.removeVisual(nido)
		game.removeVisual(gallina)
		barraDeVida.removeVisual()
		huevos.forEach{h => h.sacarVisual()}
        vehiculos.forEach{a => a.removeVisual()}
		game.removeVisual(fondo)
		game.removeVisual(fondo2)
	}
		
	method victoria(){
		self.gameOver()
		menu.victoria()
	}
	
	method vehiculosSize() = vehiculos.size()
	method agregarVehiculos(vehiculo){
		vehiculos.addAll(vehiculo)
	}
	method quitarAutos(){
		vehiculos.forEach{v => if (v.esAuto()){vehiculos.remove(v)}}
	}
	method carreteraR1() = carreteraR1
	method carreteraR2() = carreteraR2
	method carreteraL2() = carreteraL2
	method carreteraL1() = carreteraL1
	method rieles1() = rieles1
	method rieles2() = rieles2
	
}

object pausa{
	var property pausado = false
			
	method pausar(){
		gallina.pausar()
		if (pausado){
			juego.conducirVehiculos()
			pausado = !pausado
			game.removeVisual(fondo)
			game.addVisual(fondo)
			contador.nuevoContador()
		}
		else {
			juego.detenerVehiculos()
			pausado = !pausado
			game.removeTickEvent("Contador")
		}
	}			
}

object reinicio{
	var property reiniciado = false
	
	method reiniciar(){
		if (pausa.pausado()){
			juego.pausar()
		}
		if (!juego.estaJugando()){
			puntuacion.removeVisual()				
			puntuacion.reset()
			gallina.posInicial()
			barraDeVida.reinicio()
			if (juego.nivelQueJuega() == 1){
				juego.nivel1()
			}
			else {
				juego.nivel2()
			}
		}
		else {
			barraDeVida.perderVidas()
			juego.gameOver()
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


class Sonido{
	const property sonido 
	
	method reproducir(){
		game.sound(sonido).play()
	}
	method parar(){
		game.sound(sonido).stop()
	}
}


