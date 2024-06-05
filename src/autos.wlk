import wollok.game.*
import juego.*

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
	}
	method conducir(){
		game.onTick(400, "conduc", {self.avanzar()})
	}
	method detener(){
		game.removeTickEvent("conduc")
	}/*
	method colicion(){
		gallina.posInicial()
	}*/
}

object trenDer{
	var position = game.at(-3, 3)
	var property image = "TD.png"
	const vagones = [new Vagon(x = self.position().x()-1,  y = self.position().y(), dir = derecha),
					new Vagon(x = self.position().x()-2,  y = self.position().y(), dir = derecha),
					 new Vagon(x = self.position().x() -3,  y = self.position().y(), dir = derecha)]
	method position() = position
	method avanzar(){
		if (self.position().x() == 18){
			position = game.at(-3,3)
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
	var position = game.at(13, 4)
	var property image = "TI.png"
	const vagones = [new Vagon(x = self.position().x()+1, y = self.position().y(),dir = izquierda),
					new Vagon(x = self.position().x()+2, y = self.position().y(),  dir = izquierda),
					 new Vagon(x = self.position().x() +3,  y = self.position().y(), dir = izquierda)]
	method position() = position
	method avanzar(){
		if (self.position().x() == -5){
			position = game.at(13,4)
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
	var property image = "V" + dir.img() + ".png" 
	method pInicial(){
		position = game.at(x,y)
	}
	method avanzar(){
		position = dir.avanzar(position)
	}
  }