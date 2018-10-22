class Formacion{
	var property  locomotoras
	var property vagones
	
	method agregarLocomotora(locomotive){
		locomotoras.add(locomotive)
	}
	method agregarVagon(wagon){
		vagones.add(wagon)
	}
	
	method cantidadDeVagonesLivianos(){
		return vagones.count({vagon=> vagon.pesoMaximo() < 2500})
	}
	
	method locomotoraMenosVeloz(){
	return	locomotoras.min({locomotora=> locomotora.velocidadMaxima()})
	}
	
	method esEficiente(){
		return locomotoras.all({locomotora=> locomotora.arrastreUtil()>= locomotora.peso() * 5 })
	}
	
	method pesoTotalDeVagones(){
		return vagones.sum({vagon=> vagon.pesoMaximo()})
	}
	
	method pesoTotalDeLocomotoras(){
		return locomotoras.sum({locomotora=> locomotora.peso()})
	}
	
	method arrastreUtilTotalDeLocomotoras(){
		return locomotoras.sum({locomotora=>locomotora.arrastreUtil()})
	}
	
	method puedeMoverse(){
		return self.arrastreUtilTotalDeLocomotoras()>= self.pesoTotalDeVagones()	
	}
	
	method kilosFaltantesDeEmpuje(){
		return if (self.puedeMoverse()){ 0}
				else{ self.pesoTotalDeVagones() - self.arrastreUtilTotalDeLocomotoras()}
	}
	
	method vagonMasPesado(){
		return vagones.max{vagon=> vagon.pesoMaximo()}
	}
	
	method pesoTotal(){
	return	self.pesoTotalDeLocomotoras() + self.pesoTotalDeVagones() 
	}
	
	method totalUnidades(){
		return vagones.size() + locomotoras.size()
	}
	
	method esCompleja(){
		return self.totalUnidades()>20 or self.pesoTotal() >= 10000
	}
	
	method estaBienArmada(){
		return self.puedeMoverse()
	}
}

class FormacionesDeCortaDistancia inherits Formacion{
	override method estaBienArmada(){
		return super() and not self.esCompleja()
	}
}

class FormacionesDeLargaDistancia inherits Formacion{
	override method estaBienArmada(){
		return super() and 
	}
}

class Depositos{
	var property formaciones
	var property locomotorasSueltas
	
	method vagonesPesados(){
		return formaciones.map{formacion=>formacion.vagonMasPesado()}.asSet()
	}
	
	method necesitaConductorExperimentado(){
		return formaciones.any{formacion=> formacion.esCompleja()}
	}
	
	method agregarLocomotoraAFormacion(formacion){
		if (not formacion.puedeMoverse()
			 and locomotorasSueltas.any{unidadSuelta=>unidadSuelta.arrastreUtil() >= formacion.kilosFaltantesDeEmpuje()})
				{formacion.agregarLocomotora(locomotorasSueltas.filter
					{unidadSuelta => unidadSuelta.arrastreUtil() > formacion.kilosFaltantesDeEmpuje()}.first())}	
	}
}

class VagonDePasajeros{
	var largo
	var anchoUtil
	var banios
	
	method cantidadDePasajeros(){
		return if(anchoUtil <= 2.5){largo * 8}
			else{largo * 10}
	}
	
	method cantidadDeCarga(){
		return 0
		}
	
	method pesoMaximo(){
		return self.cantidadDePasajeros() * 80
	}
	
	method cantidadDeBanios(){
		return self.cantidadDePasajeros()/50.roundUp()
	}
}

class VagonDeCarga{
	var property kilos 
	
	method cargaMaxima(){
		return kilos
	}
	
	method cantidadDePasajeros(){
		return 0
	}
	
	method pesoMaximo(){
	return self.cargaMaxima() +160 
	}
}

class Locomotoras{
	var property peso
	var property pesoMaximoDeArrastre
	var property velocidadMaxima
	
	method arrastreUtil(){
	return	pesoMaximoDeArrastre - peso
	}
	
	
}