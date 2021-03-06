//
//  ProdutoManager.swift
//  CoreData_Swift
//
//  Created by joaquim on 15/04/15.
//  Copyright (c) 2015 Joaquim Pessoa Filho. All rights reserved.
//

import CoreData
import UIKit

public class ProdutoManager {
    static let sharedInstance:ProdutoManager = ProdutoManager()
    static let entityName:String = "Produto"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
    }()
    
    private init(){}
    
    func novoProduto()->Produto
    {
        return NSEntityDescription.insertNewObjectForEntityForName(ProdutoManager.entityName, inManagedObjectContext: managedContext) as! Produto
    }
    
    func salvar()
    {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func buscarProdutos()->Array<Produto>
    {
        let fetchRequest = NSFetchRequest(entityName: ProdutoManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Produto] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        return Array<Produto>()
    }
}