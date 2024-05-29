import wollok.game.*
import juego.*

class Auto {
	const carretera
	const x
	const direccion
	var position = game.at(x, carretera.position().y())
	var pInicial = carretera.position()
	method image() = "L.png"
	method position() = position
	method avanzar(){
		if (self.position().x() == direccion.final()){
			position = pInicial
		}
		position = direccion.avanzar(position)
	}
	method conducir(){
		game.onTick(100, "conduc", {self.avanzar()})
	}
	method detener(){
		game.removeTickEvent("conduc")
	}/*
	method colicion(){
		gallina.posInicial()
	}*/
}

object trenDer{
	var position = game.at(-15, 6)
	var property image = "L.png"
	const vagones = [new Vagon(x = self.position().x()-1,  y = self.position().y(), dir = derecha),
					new Vagon(x = self.position().x()-2,  y = self.position().y(), dir = derecha),
					 new Vagon(x = self.position().x() -3,  y = self.position().y(), dir = derecha)]
	method position() = position
	method avanzar(){
		if (self.position().x() == 18){
			position = game.at(-15,6)
			vagones.forEach({v => v.pInicial()})
		}
		position = position.right(1)
		vagones.forEach({v => v.avanzar()})
	}
	method conducir(){
		game.onTick(200, "conducTD", {self.avanzar()})
		self.addVagones()
	}
	method detener(){
		game.removeTickEvent("conducTD")
		vagones.forEach({v => game.removeVisual(v)})
		game.removeVisual(self)
	}
	method addVagones(){
		vagones.forEach({v => game.addVisual(v)})
	}
	
}  

object trenIzq{
	var position = game.at(30, 7)
	var property image = "L.png"
	const vagones = [new Vagon(x = self.position().x()-1, y = self.position().y(),dir = izquierda),
					new Vagon(x = self.position().x()-2, y = self.position().y(),  dir = izquierda),
					 new Vagon(x = self.position().x() -3,  y = self.position().y(), dir = izquierda)]
	method position() = position
	method avanzar(){
		if (self.position().x() == -5){
			position = game.at(30,7)
			vagones.forEach({v => v.pInicial()})
		}
		position = position.left(1)
		vagones.forEach({v => v.avanzar()})
	}
	method conducir(){
		game.onTick(200, "conducTL", {self.avanzar()})
		self.addVagones()
	}
	method detener(){
		game.removeTickEvent("conducTL")
		vagones.forEach({v => game.removeVisual(v)})
		game.removeVisual(self)
	}
	method addVagones(){
		vagones.forEach({v => game.addVisual(v)})
	}
	
}

 class Vagon{
  	const x
  	const y
  	const dir
  	var property position = game.at(x,y)
	var property image = "L.png"
	method pInicial(){
		position = game.at(x,y)
	}
	method avanzar(){
		position = dir.avanzar(position)
	}
  }