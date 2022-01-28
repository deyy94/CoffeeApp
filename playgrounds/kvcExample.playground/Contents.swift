import Foundation


//Sin usar KVC
class CarritoDeCompras{
    
    var articulo: String
    var cantidad: Int
    
    init(){
        self.articulo = ""
        self.cantidad = 0
    }
}

var  compra1 = CarritoDeCompras()


// Utilizando Key Value Coding
class CarroDeCompras: NSObject{
    @objc dynamic public var articulo: String
    @objc dynamic public var cantidad: Int
    
    public init(articulo: String,cantidad:Int){
        self.articulo = articulo
        self.cantidad = cantidad
        super.init()
    }
}

//var compra2 = CarroDeCompras()


//compra2.setValue("Sopa", forKey: "articulo")
//compra2.setValue("Jabon", forKey: "articulo")
//compra2.setValue(4, forKey: "cantidad")
//compra2.setValue(10, forKey: "cantidad")
//
//print(compra2.value(forKey: "articulo"))
//print(compra2.value(forKey: "cantidad"))


class Observador: NSObject{
     
    override public init(){
        print("Se creo un observador")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath, let change = change else{
            return
        }
        if let newValue = change[NSKeyValueChangeKey.newKey],let oldValue = change[NSKeyValueChangeKey.oldKey]{
            print("La propiedad \(keyPath) antes era \(oldValue), ahora es \(newValue)")
        }
    }
}

let compraObservable = CarroDeCompras(articulo: "Jabon", cantidad: 10)

let observer = Observador()

compraObservable.addObserver(observer, forKeyPath: #keyPath(CarroDeCompras.cantidad), options: [.new,.old], context: nil)

compraObservable.cantidad = 20






