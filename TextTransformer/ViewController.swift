//
//  ViewController.swift
//  TextTransformer
//
//  Created by Mohamed Kelany on 10/25/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var inputTextField: NSTextField!
    @IBOutlet weak var typeSegmentedControl: NSSegmentedControl!
    @IBOutlet weak var outputTextField: NSTextField!
    
    
    let zalgoCharacters = ZalgoCharacters()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        onChangeTypeSegmentedControl(self)
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func onChangeTypeSegmentedControl(_ sender: Any) {
        switch typeSegmentedControl.selectedSegment {
        case 0:
            outputTextField.stringValue = rot13(inputTextField.stringValue)
        case 1:
            outputTextField.stringValue = similar(inputTextField.stringValue)
        case 2:
            outputTextField.stringValue = strike(inputTextField.stringValue)
        default:
            outputTextField.stringValue = zalgo(inputTextField.stringValue)
        }
    }
    
    @IBAction func onTappedCopyButton(_ sender: NSButton) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(outputTextField.stringValue, forType: .string)
    }
    
    
    func rot13(_ input: String) -> String {
        return ROT13.string(input)
    }
    
    func similar(_ input: String) -> String {
        var output = input
        output = output.replacingOccurrences(of: "a", with: "а")
        output = output.replacingOccurrences(of: "e", with: "е")
        output = output.replacingOccurrences(of: "i", with: "і")
        output = output.replacingOccurrences(of: "o", with: "о")

        output = output.replacingOccurrences(of: "A", with: "А")
        output = output.replacingOccurrences(of: "E", with: "Е")
        output = output.replacingOccurrences(of: "I", with: "І")
        output = output.replacingOccurrences(of: "P", with: "Р")
    
        return output
    }
    
    func strike(_ input: String) -> String {
        
        var output = ""
        
        for letter in input {
            output.append(letter)
            output.append("\u{0335}")
        }
        return output
    }
    
    func zalgo(_ input: String) -> String {
        var output = ""
        
        for letter in input {
            output.append(letter)
            for _ in 1...Int.random(in: 1...8) {
                output.append(zalgoCharacters.above.randomElement())
            }
            
            for _ in 1...Int.random(in: 1...3) {
                output.append(zalgoCharacters.inline.randomElement())
            }
            
            for _ in 1...Int.random(in: 1...8) {
                output.append(zalgoCharacters.below.randomElement())
            }
        }
        return output
    }
}

extension ViewController: NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        onChangeTypeSegmentedControl(self)
    }
}

extension String {
    mutating func append(_ str: String?) {
        guard let str = str else { return }
        append(str)
    }
}

