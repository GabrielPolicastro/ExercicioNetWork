//
//  ViewController.swift
//  PrimeiroExemplo_AulaNetWork
//
//  Created by Gabriel Policastro on 23/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var primeiraParteDaPiadaLabel: UILabel!
    @IBOutlet weak var segundaParteDaPiadaLabel: UILabel!
    
    let viewModel: PiadaViewModel = PiadaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.delegate = self
        viewModel.carregouTela()
    }
    
    @IBAction func newJokeButtonAction(_ sender: Any) {
        viewModel.botaoDeGerarNovaPiadaPressionado()
    }
    
    private func escondeLabelSeNecessario() {
        DispatchQueue.main.async {
            self.segundaParteDaPiadaLabel.isHidden = self.viewModel.deveEsconderSegundaParteDaPiada()
        }
    }
}

extension ViewController: PiadaViewModelDelegate {
    func atualizaAsDuasPartesDaPiada(primeiraParte: String, segundaParte: String) {
        DispatchQueue.main.async {
            self.primeiraParteDaPiadaLabel.text = primeiraParte
            self.segundaParteDaPiadaLabel.text = segundaParte
        }
        escondeLabelSeNecessario()
    }
    
    func atualizaUmaPartesDaPiada(primeiraParte: String) {
        DispatchQueue.main.async {
            self.primeiraParteDaPiadaLabel.text = primeiraParte
        }
        escondeLabelSeNecessario()
    }
}

