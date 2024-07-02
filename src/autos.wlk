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
		game.onTick(time, self.identity().toString(), {self.avanzar()})
	}
	
	method detener(){
		game.removeTickEvent(self.identity().toString())
	}
	
	method colicion() {
		gallina.chocada()
	}
	
	method esAuto() = false
	
	method addVisual(){
		game.addVisual(self)
	}
	
	method removeVisual(){
		game.removeVisual(self)
	}
}

class Auto inherits Vehiculo{
	var property image = "A"+camino.dir().img()+"1.png"
	
	method imgDeDefault() {
	image = "A"+camino.dir().img()+"1.png"
	}
	
	method animacion(){
		image = "A"+camino.dir().img()+"2.png"
		game.schedule(100, {self.imgDeDefault()})
	}
	
	override method avanzar(){
		super()
		self.animacion()
	}
	
	override method esAuto() = true
}

class Tren inherits Vehiculo{
	const vagones
	var property image = "T"+camino.dir().img()+".png"
    override method avanzar(){
    	super()
    	vagones.forEach{v => v.avanzar()}
    }
	
	override method addVisual(){
		super()
		vagones.forEach{v => v.addVisual()}
	}
	
	override method removeVisual(){
		super()
		vagones.forEach{v => v.removeVisual()}
	}

	
}

class Vagon inherits Vehiculo{
	var property image = "V" + camino.dir().img() + ".png"
}

