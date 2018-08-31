//
//  API.swift
//  Carros
//
//  Created by Usuário Convidado on 10/08/2018.
//  Copyright © 2018 FIAP. All rights reserved.
//

import Foundation

class API {
    
    static let path = "https://carangas.herokuapp.com/cars"
    static let session = URLSession.shared
    
    class func loadCars(onComplete: @escaping ([Car]) -> Void) {
        guard let url = URL(string: path) else {
            print("URL inválida!!")
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Erro na requisição:", error!.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Sem resposta do servidor")
                return
            }
            
            if response.statusCode != 200 {
                print("Status code inválido:", response.statusCode)
                return
            }
            
            guard let data = data else {
                print("Sem data")
                return
            }
            
            do {
                let cars: [Car] = try JSONDecoder().decode([Car].self, from: data)
                
                onComplete(cars)
                
                
            } catch {
                print("Erro ao decodificar JSON:", error.localizedDescription)
            }
        }
        
        dataTask.resume()
    }
    
    
}
