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
}

class Auto inherits Vehiculo{
	var property image = "A"+camino.dir().img()+"1.png"
	
	method imgDeDefault() = "A"+camino.dir().img()+"1.png"
	
	method animacion(){
		image = "A"+camino.dir().img()+"2.png"
		game.schedule(100, {self.imgDeDefault()})
	}
	
	override method avanzar(){
		super()
		self.animacion()
	}
}

class Tren inherits Vehiculo{
	var property image = "T"+camino.dir().img()+".png"

	
}

class Vagon inherits Vehiculo{
	var property image = "V" + camino.dir().img() + ".png"
}


/*
class Auto {
	const carretera
	const x
	var property position = game.at(x, carretera.position().y())
	var pInicial = carretera.position()
	var property image = "A"+carretera.dir().img()+"1.png"
	
	method avanzar(){
		if (self.position().x() == carretera.dir().final()){
			position = pInicial
		}
		position = carretera.dir().avanzar(position)
		self.animacion()
	}
	
	method conducir(time){
		game.onTick(time, self.identity().toString(), {self.avanzar()})
	}
	
	method detener(){
		game.removeTickEvent(self.identity().toString())
	}
	
	method animacion(){
		image = "A"+carretera.dir().img()+"2.png"
		game.schedule(100, {self.imgDefault()})
	}
	
	method imgDefault(){
		image = "A"+carretera.dir().img()+"1.png"
	}
	
	method colicion() {
		gallina.chocada()
	}
}




object trenDer{
	var property position = game.at(-3, 3)
	var property image = "TD.png"
	const vagones = [new Vagon(x = self.position().x()-1,  y = self.position().y(), dir = derecha),
					new Vagon(x = self.position().x()-2,  y = self.position().y(), dir = derecha),
					 new Vagon(x = self.position().x() -3,  y = self.position().y(), dir = derecha)]
	
	method avanzar(){
		if (self.position().x() == 13){
			position = game.at(-3,3)
			vagones.forEach({v => v.pInicial()})
		}
		position = position.right(1)
		vagones.forEach({v => v.avanzar()})
	}
	
	method conducir(time){
		game.onTick(time, "conducTD", {self.avanzar()})
		self.addVagones()
	}
	
	method detener(){
		game.removeTickEvent("conducTD")
        vagones.forEach({v => game.removeVisual(v)})
	}
	
	method addVagones(){
		vagones.forEach({v => game.addVisual(v)})
	}
	
	method colicion() {
		gallina.chocada()
	}
	
}  

object trenIzq{
	var property position = game.at(9, 4)
	var property image = "TI.png"
	const vagones = [new Vagon(x = self.position().x()+1, y = self.position().y(),dir = izquierda),
					new Vagon(x = self.position().x()+2, y = self.position().y(),  dir = izquierda),
					 new Vagon(x = self.position().x() +3,  y = self.position().y(), dir = izquierda)]
					 
	
	method avanzar(){
		if (self.position().x() == -3){
			position = game.at(9,4)
			vagones.forEach({v => v.pInicial()})
		}
		position = position.left(1)
		vagones.forEach({v => v.avanzar()})
	}
	
	method conducir(time){
		game.onTick(time, "conducTL", {self.avanzar()})
		self.addVagones()
	}
	
	method detener(){
		game.removeTickEvent("conducTL")
		vagones.forEach({v => game.removeVisual(v)})
	}
	
	method addVagones(){
		vagones.forEach({v => game.addVisual(v)})
	}
	
	method colicion() {
		gallina.chocada()
	}
	
}

 class Vagon{
  	const x
  	const y
  	const dir
  	
  	var property position = game.at(x,y)
  	
	var property image = "V" + dir.img() + ".png" 
	
	method pInicial(){
		position = game.at(x,y)
	}
	
	method avanzar(){
		position = dir.avanzar(position)
	}
	
	method colicion() {
		gallina.chocada()
	}
  }*/