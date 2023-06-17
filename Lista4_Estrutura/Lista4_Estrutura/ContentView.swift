//
//  ContentView.swift
//  Lista4_Estrutura
//
//  Created by Giovanni Favorin de Melo on 12/06/23.
//

// validar o máximo de cadastros ...
// colocar enum em UF.sigla ...
// validar os dados recebidos ...
// arrumar o cálculo de lucro ...

// organizar os produtos em ordem alfabética ou ordem crescente de VALOR DE COMPRA // VALOR DE LUCRO
// Estados com o com produto mais caro
// Fabricantes com produto mais barato

// BUSCA DE PRODUTOS
// Buscar produto com valor especificado pelo usuario

// FILA DE CLIENTES
// Fazer chamada de clientes, estilo fila e fila prioritária será estilo pilha
// Checar cliente com mais de 60 anos, se mais de 3, listar por ordem de chegada
import SwiftUI

//produto, cliente, UF, fabricante
struct Fabricante: Identifiable {//de 2 ... 5 cadastros
    var id = UUID()
    
    var codigo:String
    var marca:String
    var site:String
    var telefone:String
    var uf:String
    struct UF { // 27
        var nome:String
        var sigla:String// poderia ser um enum com cada sigla de cada Estado
    }
    var produtos:[Produto]
    struct Produto: Identifiable { // 5 ... 50
        var id = UUID()
        
        var descricao:String
        var peso:Double
        var valorCompra:Double
        var valorVenda:Double
        var valorLucro:Double// calculado
        var percentLucro:Double// calculado
    }
}

struct Cliente: Identifiable { // 3 ... 30
    var id = UUID()
    var nome:String
    var idade:String
}

struct FabricaView: View {
    @Binding var fabricas:[Fabricante]
    @State var modeloCodigo = ""
    @State var modeloMarca = ""
    @State var modeloSite = ""
    @State var modeloTelefone = ""
    @State var modeloUF = ""
    
    var body: some View {
        VStack {
            TextField("Código", text: $modeloCodigo)
            TextField("Marca", text: $modeloMarca)
            TextField("Site", text: $modeloSite)
            TextField("Telefone", text: $modeloTelefone)
            TextField("UF", text: $modeloUF)
            Button("Adicionar") {
                fabricas.append(Fabricante(codigo: modeloCodigo, marca: modeloMarca, site: modeloSite, telefone: modeloTelefone, uf: modeloUF, produtos: []))
            }
            ForEach($fabricas) { fabrica in
                DisclosureGroup(content: {
                    let codigo = fabrica.codigo.wrappedValue
                    let site = fabrica.site.wrappedValue
                    let telefone = fabrica.telefone.wrappedValue
                    let uf = fabrica.uf.wrappedValue
                    Text("\(codigo)")
                    Text("\(site)")
                    Text("\(telefone)")
                    Text("\(uf)")
                    NavigationLink(destination: ProdutoView(produtos: fabrica.produtos)) {
                        Text("Produtos")
                            .font(.headline)
                    }
                    
                }, label: {
                    let title = fabrica.marca.wrappedValue
                    Text(title)
                })
            }
            Spacer()
        }.navigationTitle("Fábricas")
            .padding()
    }
}

struct ProdutoView: View {
    @Binding var produtos:[Fabricante.Produto]
    @State var modeloDescricao = ""
    @State var modeloPeso = ""
    @State var modeloValorCompra = ""
    @State var modeloValorVenda = ""
    @State var calculoFeito: Bool = false
    @State var modeloValorLucro: Double = 0.0
    @State var modeloPercentLucro:Double = 0.0
    
    var body: some View {
        VStack {
            TextField("Descrição", text: $modeloDescricao)
            TextField("Peso", text: $modeloPeso)
            TextField("Valor de compra", text: $modeloValorCompra)
            TextField("Valor de venda", text: $modeloValorVenda)
            Button("Calcular lucro") {
                if let modeloValorCompra = Double(modeloValorCompra) {
                    if let modeloValorVenda = Double(modeloValorVenda) {
                        modeloValorLucro = modeloValorVenda - modeloValorCompra
                        modeloPercentLucro = (modeloValorCompra - modeloValorLucro)// tem q arrumar o calculo de lucro
                        calculoFeito = true
                    } else {
                        print("Valor inválido")
                    }
                } else {
                    print("Valor inválido")
                }
            }
            if calculoFeito {
                let valorFormatado = String(format: "%.2f", modeloValorLucro)
                let percentFormatado = String(format: "%.2f", modeloPercentLucro)
                Text("\(valorFormatado) e \(percentFormatado)%")
                
                Button("Adicionar") {
                    produtos.append(Fabricante.Produto(descricao: modeloDescricao, peso: Double(modeloPeso)!, valorCompra: Double(modeloValorCompra)!, valorVenda: Double(modeloValorVenda)!, valorLucro: Double(valorFormatado)!, percentLucro: Double(percentFormatado)!))
                }
            }
            ForEach($produtos) { produto in
                DisclosureGroup(content: {
                    let peso = produto.peso.wrappedValue
                    let valorCompra = produto.valorCompra.wrappedValue
                    let valorVenda = produto.valorVenda.wrappedValue
                    let valorLucro = produto.valorLucro.wrappedValue
                    let percentLucro = produto.percentLucro.wrappedValue
                    
                    Text("\(peso)")
                    Text("\(valorCompra)")
                    Text("\(valorVenda)")
                    Text("\(valorLucro)")
                    Text("\(percentLucro)")
                }, label: {
                    let nome = produto.descricao.wrappedValue
                    Text(nome)
                })
            }
            Spacer()
        }.padding()
    }
}

struct ClienteView: View {
    @Binding var clientes:[Cliente]
    @State var modeloNome = ""
    @State var modeloIdade = ""
    
    var body: some View {
        VStack {
            TextField("Nome", text: $modeloNome)
            TextField("Idade", text: $modeloIdade)
            Button("Adicionar") {
                clientes.append(Cliente(nome: modeloNome, idade: modeloIdade))
            }
            ForEach($clientes) { cliente in
                DisclosureGroup(content: {
                    let idade = cliente.idade.wrappedValue
                    Text("\(idade)")
                }, label: {
                    let nome = cliente.nome.wrappedValue
                    Text("\(nome)")
                })
            }
            Spacer()
        }.padding()
    }
}

struct ContentView: View {
    @State var fabricas:[Fabricante] = []
    @State var cliente:[Cliente] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                if (fabricas.count >= 2) {
                    ForEach(fabricas) { fabrica in
                        if (fabrica.produtos.count >= 5) {
                            //e agora??
                        }
                    }
                    
                }
                Spacer()
                HStack {
                    NavigationLink(destination: ClienteView(clientes: $cliente)) {
                        Text("Cadastro de clientes")
                            .font(.headline)
                    }
                    Spacer()
                    NavigationLink(destination: FabricaView(fabricas: $fabricas)) {
                        Text("Cadastro de fábricas")
                            .font(.headline)
                    }
                } .padding()
            }
            .navigationTitle("Tela Principal")
        }
    }
}

@main
struct Lista4_EstruturaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
