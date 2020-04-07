//
//  ViewController.swift
//  TranslateIt
//
//  Created by André Grecco Carvalho on 02/04/20.
//  Copyright © 2020 André Grecco Carvalho. All rights reserved.
//

import Cocoa
import IBMSwiftSDKCore

public struct texto {
    var original: String
    var traducao: String
}
public var txt = texto(original: "", traducao: "")

class ViewController: NSViewController {
    
    @IBOutlet weak var indic: NSProgressIndicator!
    @IBOutlet weak var Scr2: NSScrollView!
    @IBOutlet var Recepcao: NSTextView!
    @IBOutlet weak var Scr1: NSScrollView!
    let dispatch_group = DispatchGroup()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func TranslateIt(_ sender: Any) {
        if (Scr2.documentView! as! NSTextView).string != "" {
            Recepcao.selectAll(nil)
            Recepcao.delete(nil)
        }
        if (Scr1.documentView! as! NSTextView).string != "" {
            txt.original = (self.Scr1.documentView! as! NSTextView).string
            indic.isHidden = false
            indic.startAnimation(self)
            asyncTraducao()
        }
    }
    func atualizarTraducao() {
        indic.stopAnimation(self)
        indic.isHidden=true
        Scr2.documentView?.insertText(txt.traducao)
    }
    func asyncTraducao() {
        let lt=setupLanguageTranslatorV3()
        dispatch_group.enter()
        lt.translate(text: [txt.original], modelID: "en-pt"){
            response, error in

            guard let translation = response?.result else {
                print(error?.localizedDescription ?? "unknown error")
                return
            }
            txt.traducao=translation.translations[0].translation
            self.dispatch_group.leave()
        }
        dispatch_group.notify(queue: .main) {
            self.atualizarTraducao()
        }
    }
    @IBAction func fecharAplicacao(_ sender: Any) {
        NSApp.terminate(self)
    }
    
}

