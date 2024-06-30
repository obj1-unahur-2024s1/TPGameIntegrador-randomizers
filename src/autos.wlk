import wollok.game.*
import juego.*
import gallina.*

class Vehiculo{
	const camino
	const x
	var property position = game.at(x, camino.position().y()) 
	var pInicial = camino.position()
	
	method avanzar(){
		if (self.position().x() == camino.dir().final()){
			position = pInicial
		}
		position = camino.dir().avanzar(position)
	}
	
	method conducir(time){
		game.onTick(time, "conduc", {self.avanzar()})
	}
	
	method detener(){
		game.removeTickEvent("conduc")
	}
	
	method colicion() {
		gallina.chocada()
	}
	
	method esAuto() = false
}

class Auto inherits Vehiculo{
	var property image = "A"+camino.dir().img()+"1.png"
	
	method imgDeDefault() = "A"+camino.dir().img()+"1.png"
	
	method animacion(){
		image = "A"+camino.dir().img()+"2.png"
		game.schedule(100, {self.imgDeDefault()})
	}
	
	override method avanzar(){
		self.animacion()
		super()
	}
	
	override method esAuto() = true
}

class Tren inherits Vehiculo{
	var property image = "T"+camino.dir().img()+".png"
	

	
}

class Vagon inherits Vehiculo{
	var property image = "V" + camino.dir().img() + ".png"
}

