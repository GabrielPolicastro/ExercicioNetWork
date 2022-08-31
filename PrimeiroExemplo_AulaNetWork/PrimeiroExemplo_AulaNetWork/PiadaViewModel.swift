//
//  PiadaViewModel.swift
//  PrimeiroExemplo_AulaNetWork
//
//  Created by Gabriel Policastro on 24/08/22.
//

import Foundation

protocol PiadaViewModelDelegate {
    func atualizaAsDuasPartesDaPiada(primeiraParte: String, segundaParte: String)
    func atualizaUmaPartesDaPiada(primeiraParte: String)
    
}

class PiadaViewModel {
    
    private enum TipoDaPiada: String {
        case single = "single"
        case twoParts = "twoPart"
    }
    
    private let service: Service
    private var piada: Piada?
    
    var delegate: PiadaViewModelDelegate? // esse aqui é necessario para
    
    
    init(service: Service = .init()) {
        self.service = service
    }
    
    func carregouTela() {
        carregaPiada()
    }
    
    func botaoDeGerarNovaPiadaPressionado() {
       carregaPiada()
        // fazer a requisicao para o servico para pegar uma nova piada e devolver para a viewController para ela atualizar a view com a piada nova
    }
    
    func deveEsconderSegundaParteDaPiada() -> Bool {
        guard let piada = piada else { return false }
        let tipoDaPiada = TipoDaPiada(rawValue: piada.type)
        
        switch tipoDaPiada {
        case .single:
            return true
        case .twoParts:
            return false
        case .none:
            return false
        }
    }
    
    private func carregaPiada() {
        service.realizarRequisicaoDePiada {
            piada in
            self.piada = piada
            self.atualizaPiada(piada)
        }
    }
    
    private func atualizaPiada(_ piada: Piada) {
        if piada.type == "single" {
            // só tem uma parte
            //            guard let primeiraParteDaPiada = piada.joke else { return }
            //
            //            delegate?.atualizaUmaPartesDaPiada(
            //                primeiraParte: primeiraParteDaPiada
            //            )
            atualizaUmaParteDaPiada(piada)
            
        } else {
            // tem duas partes
            //            guard let primeiraParteDaPiada = piada.setup,
            //                  let segundaParteDaPiada = piada.delivery else { return }
            //
            //            delegate?.atualizaAsDuasPartesDaPiada(
            //                primeiraParte: primeiraParteDaPiada,
            //                segundaParte: segundaParteDaPiada
            //            )
            atualizaAsDuasPartesDaPiada(piada)
        }
    }
    
    private func atualizaPiada2(_ piada: Piada) {
        let tipoDaPiada = TipoDaPiada(rawValue: piada.type)
        
        switch tipoDaPiada {
        case .single:
            atualizaUmaParteDaPiada(piada)
        case .twoParts:
            atualizaAsDuasPartesDaPiada(piada)
        case .none:
            break
        }
    }
    
    private func atualizaUmaParteDaPiada(_ piada:Piada) {
        guard let primeiraParteDaPiada = piada.joke else { return }
        
        delegate?.atualizaUmaPartesDaPiada(
            primeiraParte: primeiraParteDaPiada
        )
    }
    
    private func atualizaAsDuasPartesDaPiada(_ piada:Piada) {
        guard let primeiraParteDaPiada = piada.setup,
              let segundaParteDaPiada = piada.delivery else { return }
        
        delegate?.atualizaAsDuasPartesDaPiada(
            primeiraParte: primeiraParteDaPiada,
            segundaParte: segundaParteDaPiada
        )
    }
}
