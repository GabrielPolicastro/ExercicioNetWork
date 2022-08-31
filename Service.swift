//
//  Service.swift
//  PrimeiroExemplo_AulaNetWork
//
//  Created by Gabriel Policastro on 24/08/22.
//

//
//protocol PiadaDataSource {
//    func realizarRequisicaoDePiada()
//}

import Foundation

class Service {
    
    //https://v2.jokeapi.dev/joke/Any?safe-mode
    
    func realizarRequisicaoDePiada(completion: @escaping (Piada) -> Void) {
        
        guard let url = URL(string: "https://v2.jokeapi.dev/joke/Any?safe-mode") else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            
            let dic = json as? [String: Any]
            //print("---------> \(dic)")
            
            guard let typePiada = dic?["type"] as? String else { return }
            let jokePiada = dic?["joke"] as? String
            let setupPiada = dic?["setup"] as? String
            let deliveryPiada = dic?["delivery"] as? String
            

//            print("--------> \(typePiada)")
//            print("--------> \(jokePiada)")
//            print("--------> \(setupPiada)")
//            print("--------> \(deliveryPiada)")
            
            
            let piada = Piada(
                type: typePiada,
                joke: jokePiada,
                setup: setupPiada,
                delivery: deliveryPiada
            )
            completion(piada)
        }
        
        task.resume()
    }
}



// let typePiada = dic?["type"]
// guard let typePiada = typePiada else { return }
